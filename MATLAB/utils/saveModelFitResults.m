function [] = saveModelFitResults(theta_test,theta_opt,data,opt,n_y,sigma_HO)
    %store for every individual:
    %a) ws_modelFitPlot.mat
    %b) ws_modelFitPlot_sum.mat
    for i=1:2
        if i==1
            opt.plotCompartmentSum = true;
        else
            if opt.n_divStates>1
                opt.plotCompartmentSum = false;
            else
                continue;
            end
        end
        if opt.fit_repetitions_seperately
            i_repe_start = opt.n_repetitions;
            i_repe_end = opt.n_repetitions;
        else
            i_repe_start = 1;
            i_repe_end = opt.n_repetitions;
        end
        ind_e = 1;
        for i_repe=i_repe_start:i_repe_end %index for repetitions (in case individual was observed several times)
            n_replicates = max(data.replicate(data.repetition==i_repe));
            for i_repl=1:n_replicates 
                [D] = getTransformedDataSelection(data,opt,i_repe,i_repl);
                if opt.realdata==true
                    T_max=max(max(D.t))+24;
                    t=0:0.1:T_max;
                else
                    T_min=min(min(D.t));
                    T_max=max(max(D.t))+24;
                    t=T_min:1:T_max;
                end

                [sol_test,sol_opt] = simulateModelSolution(theta_opt,theta_test,n_y,i_repe,D,t,opt);

                [sigma] = getSigma(opt,sigma_HO,theta_opt,ind_e);

                currentPath=cd();
                [S_test_T,S_opt_T,e_up,e_down,YD,tD,trans,states_str,ndivs] = getTransformedModelFitResults(sol_test,sol_opt,opt,sigma,D);
                cd(['./',opt.foldername,'/',opt.subfoldername,'/',opt.subsubfoldername]);
                if opt.plotCompartmentSum
                    save(['ws_modelFitPlot_sum',num2str(i_repe),num2str(i_repl),'.mat'],'S_opt_T','S_test_T','t','YD','tD','e_up','e_down','i_repe','i_repl','trans','states_str','ndivs','-v7');
                else
                    save(['ws_modelFitPlot',num2str(i_repe),num2str(i_repl),'.mat'],'S_opt_T','S_test_T','t','YD','tD','e_up','e_down','i_repe','i_repl','trans','states_str','ndivs','-v7');
                end
                cd(currentPath)  
                if size(sigma,1)>1
                    ind_e=ind_e+1;
                end
            end
        end
    end
    
    function [D] = getTransformedDataSelection(data,opt,i_repe,i_repl)

        if opt.fit_repetitions_seperately
           i_repe = 1; 
        end
        if opt.n_divStates>1 && ~opt.plotCompartmentSum
            D.Y = data.NumCellDiv_ALL{i_repe,i_repl};
            D.Y0 = data.NumCellDiv_ALL_Y0{i_repe,i_repl};
            D.t = data.timeDiv{i_repe,i_repl};
        else
            D.Y = data.ym{i_repe,i_repl};
            D.Y0 = data.y0{i_repe};
            D.t = data.t{i_repe,i_repl};
        end
        D.DL = data.detectionLimit_corrected{i_repe,i_repl};
        if strwcmp(opt.noiseType,'Log*')
            Y = exp(D.Y)-1;
            Y0 = exp(D.Y0)-1;
            DL = exp(D.DL)-1;
        else
            Y = D.Y;
            Y0 = D.Y0;
            DL = D.DL;
        end

        switch opt.modelFitResultsTransformation
            case 'totalNumbers'
               D.Y_t = Y;
               D.Y0_t = Y0;
               D.DL_t = DL;
               D.axis_str = [];
            case 'logTotalNumbers'
               D.Y_t = log(Y+1); 
               D.Y0_t = log(Y0+1); 
               D.DL_t = log(DL+1);
               D.axis_str = 'log ';
            case 'log2TotalNumbers'
               D.Y_t = log2(Y+1);   
               D.Y0_t = log2(Y0+1);   
               D.DL_t = log2(DL+1);
               D.axis_str = 'log_2 ';
            case 'log10TotalNumbers'
               D.Y_t = log10(Y+1); 
               D.Y0_t = log10(Y0+1); 
               D.DL = log10(DL+1);
               D.axis_str = 'log_{10} ';
            case 'percentages'
               D.Y_t = 100.*(Y./sum(Y,2));
               D.Y0_t = 100.*(Y0./sum(Y0,2));
               D.DL_t = 100.*(DL./sum(DL,2));
               D.axis_str = [];
        end
    end

    function [sol_test,sol_opt] = simulateModelSolution(theta_opt,theta_test,n_y,i_repe,D,t,opt)
        sol_test=[];
        if opt.fitInitialConds%initial conditions were fit
            if opt.fit_repetitions_seperately
                [sol_opt] = simH([],t,[theta_opt(1:n_y);theta_opt(n_y+1:end)]',opt.model,opt,false,[],[]);
                if opt.realdata==false
                    %% update opt.amiOptions.pscale
                    opt.amiOptions.pscale = opt.pscale_sim;
%                         [sol_test_points] = simH([],D.t,[theta_test(1:n_y),theta_test(n_y+1:end)],opt.model_sim,opt,false,[],[]);
                    [sol_test] = simH([],t,[theta_test(1:n_y),theta_test(n_y+1:end)],opt.model_sim,opt,false,[],[]);
                end
            else
                [sol_opt] = simH([],t,[theta_opt(1+n_y*(i_repe-1):i_repe*n_y);theta_opt(opt.n_initialConds_N*n_y+1:end)]',opt.model,opt,false,[],[]);
                if opt.realdata==false
                    %% update opt.amiOptions.pscale
                    opt.amiOptions.pscale = opt.pscale_sim;
%                         [sol_test_points] = simH([],D.t,[theta_test(1+n_y*(i_repe-1):i_repe*n_y),theta_test(opt.n_initialConds_N*n_y+1:end)],opt.model_sim,opt,false,[],[]);
                    [sol_test] = simH([],t,[theta_test(1+n_y*(i_repe-1):i_repe*n_y),theta_test(opt.n_initialConds_N*n_y+1:end)],opt.model_sim,opt,false,[],[]);
                end
            end
        else 
            [sol_opt] = simH(D.Y0,t,theta_opt',opt.model,opt,false,[],[]);
            if opt.realdata==false
                %% update opt.amiOptions.pscale
                opt.amiOptions.pscale = opt.pscale_sim;
%                     [sol_test_points] = simH(D.Y0,D.t,theta_test(:),opt.model_sim,opt,false,[],[]);
                [sol_test] = simH(D.Y0,t,theta_test,opt.model_sim,opt,false,[],[]);
            end
        end
    end
    
    function [sigma] = getSigma(opt,sigma_HO,theta_opt,ind_e)
            switch opt.optimizationMode
                case 'hierarchical'
                    sigma_vec = sigma_HO(ind_e,:);%sigma_HO: repetition*replicates x n_observables 
                    if opt.plotCompartmentSum && opt.n_divStates>1
                        sigma = sigma_vec(1:opt.n_divStates:length(sigma_vec));
                    else 
                        sigma = sigma_vec;
                    end
                case 'standard'
                    theta_lin = transformParBack(theta_opt,opt);
                    sigma = sqrt(theta_lin(strcmp(opt.rates,'s')));
            end
    end

    function [S_test_T,S_opt_T,e_up,e_down,YD,tD,trans,states_str,ndivs] = getTransformedModelFitResults(sol_test,sol_opt,opt,sigma,D)
        S_test = [];
        S_test_T = [];
        if strwcmp(opt.noiseType,'Log*')
            if (~isempty(sol_opt))
                sol_opt.y = exp(sol_opt.y)-1;
            end
            if (~isempty(sol_test))
                sol_test.y = exp(sol_test.y)-1;
            end 
        end

        if (opt.plotCompartmentSum && opt.n_divStates>1) 
            if (~isempty(sol_test))
                S_test = sum(sol_test.y(:,1:opt.n_divStates),2); 
                dS = sum(strcmp(opt.modelStates,'D'));
                for k=2:length(opt.modelStates)-dS
                    S_test = [S_test, sum(sol_test.y(:,(k-1)*opt.n_divStates+1:(k)*opt.n_divStates),2)];
                end
                if any(strcmp(opt.modelStates,'D'))
                    S_test = [S_test,sol_test.y(:,end)]; 
                end
            end
            if (~isempty(sol_opt))
                S_opt = sum(sol_opt.y(:,1:opt.n_divStates),2);
                dS = sum(strcmp(opt.modelStates,'D'));
                for k=2:length(opt.modelStates)-dS
                    S_opt = [S_opt, sum(sol_opt.y(:,(k-1)*opt.n_divStates+1:(k)*opt.n_divStates),2)];
                end
                if any(strcmp(opt.modelStates,'D'))
                    S_opt = [S_opt,sol_opt.y(:,end)]; 
                end
            end
        else
            if (~isempty(sol_opt))
                [S_opt] = sol_opt.y;
            else
                S_opt = [];
            end
            if ~isempty(sol_test)
                [S_test] = sol_test.y;
            end
        end

        if (~isempty(S_test))
            [S_test_T] = transformModelOutput(S_test,opt);
        end
        if (~isempty(S_opt))
            [S_opt_T] = transformModelOutput(S_opt,opt);
        else
            S_opt_T = [];
        end

        if (~isempty(sol_opt))
            [e_up,e_down] = transformErrorBand(S_opt,sigma,opt);
        else
            [e_up,e_down] = transformErrorBand(S_test,sigma,opt);
        end

        YD = D.Y_t;
        tD = D.t;
        trans = opt.modelFitResultsTransformation;
        states_str = opt.modelStates;
        ndivs = opt.n_divStates;
        
        function [s_up_T,s_down_T] = transformErrorBand(Y,sigma,opt)
    
            if strwcmp(opt.noiseType,'Log*')
                Y=log(Y+1);
            end

            s_up = Y+2.*sigma;
            s_down = max(0,Y-2.*sigma);

            if strwcmp(opt.noiseType,'Log*')
                s_up = exp(s_up)-1;
                s_down = exp(s_down)-1;
            end  

            switch opt.modelFitResultsTransformation
                case 'totalNumbers'
                   s_down_T = s_down;
                   s_up_T = s_up;
                case 'logTotalNumbers'
                   s_down_T = log(s_down+1);
                   s_up_T = log(s_up+1);
                case 'log2TotalNumbers'
                   s_down_T = log2(s_down+1);
                   s_up_T = log2(s_up+1);
                case 'log10TotalNumbers'
                   s_down_T = log10(s_down+1);
                   s_up_T = log10(s_up+1);
                case 'percentages'
                   s_down_T = 100.*(s_down./sum(Y,2));
                   s_up_T = 100.*(s_up./sum(Y,2));
            end
        end

        function [Y_t] = transformModelOutput(Y,opt)
            switch opt.modelFitResultsTransformation
                case 'totalNumbers'
                   Y_t = Y;
                case 'logTotalNumbers'
                   Y_t= log(Y+1); 
                case 'log2TotalNumbers'
                   Y_t = log2(Y+1);   
                case 'log10TotalNumbers'
                   Y_t = log10(Y+1); 
                case 'percentages'
                   Y_t = 100.*(Y./sum(Y,2));
            end
        end
    
    end

end