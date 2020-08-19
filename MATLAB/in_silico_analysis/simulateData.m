function [opt] = simulateData(j_sim,model_str,opt)
%simulates data according to test parameter for all individuals and noise
%levels specified in options

%% generate simulation file according to settings:
opt.model_sim = model_str{j_sim}; 
%create simulation file for current model & generate in
%silico data
[theta_test,n_states,opt] = getModelParams(opt,opt.model_sim);
opt.pscale_sim = opt.amiOptions.pscale;
rate_names_test = strtrim(opt.rates(~strwcmp(opt.rates,'x0_*')));
createSimulationFiles(opt,true,opt.model_sim)

[opt] = getResultsFolderStrings(opt);
%% update noise settings:
for nl_id = 1:length(opt.noiseLevel)
    [opt] = getNoiseSettings(opt,opt.noiseLevel{nl_id});
    opt.nL = opt.noiseLevel{nl_id};
    for i_sim_ID = 1:opt.n_individuals
        [opt] = updatePaths(opt,i_sim_ID);
        %% get simulated data for 1 individal
        data.replicate = [];
        data.repetition = [];                   
        ny0 = length(opt.modelStates);
        for l=1:opt.n_repetitions
            if opt.fitInitialConds
                par_sim = [theta_test(1+ny0*(l-1):l*ny0),theta_test(opt.n_initialConds_N*ny0+1:end)];
            else
                par_sim = theta_test;
                %initial conditions missing in testPar?
                rn=[250+unidrnd(250,1,1),unidrnd(100,1,n_states-1)];
                if (opt.n_divStates == 1) %compartment model without considering number of cell divisions
                    iniVals = rn;
                else %extended compartment model (1 compartment per cellype and number of cell divisions)
                    iniVals = zeros(1,(n_states-1)*opt.n_divStates+1);
                    for i=1:n_states-1
                        iniVals(opt.n_divStates*(i-1)+1) = rn(i);
                        iniVals_short = rn;
                    end
                end
            end

            for k=1:opt.n_replicates
                data.detectionLimit_correctedDiv{l,k} = 8.*ones(length(opt.t),1);
                data.detectionLimit_corrected{l,k} = 8.*ones(length(opt.t),1);
                if ~opt.fitInitialConds
                    if strwcmp(opt.noiseType,'Log*')
                        IV = log(iniVals+1);
                    else
                        IV=iniVals;
                    end
                else
                    IV=[];
                end
                %while simulating: noise is applied if opt.applyNoise==true according to
                %opt.noiseLevel
                [D] = simH(IV,opt.t,par_sim,opt.model_sim,opt,opt.applyNoise,[],[]);        
                if strwcmp(opt.noiseType,'Log*')
                    YM = exp(D.y)-1;
                else
                    YM = D.y;
                end
                Y0 = YM(1,:);
                data.sample = 1;
                data.replicate = [data.replicate, k];
                data.repetition = [data.repetition, l];
                data.t{l,k} = opt.t;
                data.timeDiv{l,k} = opt.t;
                dS = sum(strcmp(opt.modelStates,'D'));
                data.ym{l,k} = [];
                for i=1:length(opt.modelStates)-dS
                    data.ym{l,k} = [data.ym{l,k}, sum(YM(:,(i-1)*opt.n_divStates+1:i*opt.n_divStates),2)];
                end
                data.NumCellDiv_ALL{l,k} = YM;
                if ~opt.fitInitialConds
                    data.y0{l,k} = [];
                    for i=1:length(opt.modelStates)-dS
                        data.y0{l,k} = [data.y0{l,k}, sum(Y0(:,(i-1)*opt.n_divStates+1:i*opt.n_divStates),2)];
                    end
                    data.NumCellDiv_ALL_Y0{l,k}=Y0;
                else
                    data.y0{l,k}=[];
                    data.NumCellDiv_ALL_Y0{l,k}=[];
                end
                if strwcmp(opt.noiseType,'Log*')
                    data.ym{l,k} = log(data.ym{l,k}+ones(size(data.ym{l,k})));
                    data.y0{l,k} = log(data.y0{l,k}+ones(size(data.y0{l,k})));
                    data.NumCellDiv_ALL{l,k} = log(data.NumCellDiv_ALL{l,k}+ones(size(data.NumCellDiv_ALL{l,k})));
                    data.NumCellDiv_ALL_Y0{l,k} = log(data.NumCellDiv_ALL_Y0{l,k}+ones(size(data.NumCellDiv_ALL_Y0{l,k})));
                end
            end
            switch opt.noiseType
                case {'LogNormal','LogLaplace'}
                    data.inputCells{l} = log(Y0(1,1)+unidrnd(50,1,1)+1);
                otherwise
                    data.inputCells{l} = Y0(1,1)+unidrnd(50,1,1);
            end
        end
        cd(opt.foldername)
        save(['insilico_data_',opt.model_sim,'_',opt.noiseType,'_',opt.nL,'_individual_',opt.individuals{i_sim_ID}],'data','theta_test','rate_names_test');
        cd('../')
    end
end


end