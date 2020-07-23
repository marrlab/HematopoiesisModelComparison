function [AIC_all_mat,AIC_corrected_all_mat,BIC_all_mat,LOGL_all_mat,AIC_mat,AIC_corrected_mat,BIC_mat,LOGL_mat,Time_mat,MS_num_mat] = calculateScoresMatrix(opt)
        cd(opt.c_path);
            if opt.fit_repetitions_seperately==true
                add_str = '_rep_sep';
            else
                add_str = '';
            end
            AIC_corrected_mat = zeros(length(opt.models_implemented),length(opt.individuals));
            AIC_mat = zeros(length(opt.models_implemented),length(opt.individuals));
            BIC_mat = zeros(length(opt.models_implemented),length(opt.individuals));
            LOGL_mat = zeros(length(opt.models_implemented),length(opt.individuals));
            Time_mat = zeros(length(opt.models_implemented),length(opt.individuals));
            AIC_corrected_all_mat = zeros(length(opt.models_implemented),1);
            AIC_all_mat = zeros(length(opt.models_implemented),1);
            BIC_all_mat = zeros(length(opt.models_implemented),1);
            LOGL_all_mat = zeros(length(opt.models_implemented),1);
            MS_num_mat = zeros(length(opt.models_implemented),length(opt.individuals));
            for model_id=1:length(opt.models_implemented)
                LOGL_vec = zeros(length(opt.individuals),1);
                for indi_id=1:length(opt.individuals)
                    clearvars -except model_id indi_id opt AIC_corrected_mat AIC_mat BIC_mat LOGL_mat Time_mat AIC_corrected_all_mat AIC_all_mat BIC_all_mat LOGL_all_mat MS_num_mat add_str iS_id 
                    cd([opt.foldername,'/',opt.subfoldername,'/',opt.subsubfoldername]);
                    load(['WS_individual_',opt.individuals{indi_id},'.mat'],'parameters','opt','options_par','time_in_s')
                    cd(c_path);
                    opt.c_path = c_path;
                    opt.pythonDataVisualization_path = [opt.foldername,'/'];
                    opt.validation=false;
                    Time_mat(model_id,indi_id) = (time_in_s*opt.n_workers)/60;
                    [AIC_mat(model_id,indi_id),AIC_corrected_mat(model_id,indi_id),BIC_mat(model_id,indi_id),LOGL_mat(model_id,indi_id)] = calculateModelSelectionScores(parameters.number,parameters.MS.logPost(1),opt,options_par.obj_type,opt.individuals,indi_id,'single individuals');
                    LOGL_vec(indi_id) = parameters.MS.logPost(1);
                    MS_num_mat(model_id,indi_id) = MS_percentage;

                end
                [AIC_all_mat(model_id),AIC_corrected_all_mat(model_id),BIC_all_mat(model_id),LOGL_all_mat(model_id)] = calculateModelSelectionScores(parameters.number,LOGL_vec,opt,options_par.obj_type,opt.individuals,[],'all individuals');
            end
            
    function [AIC,AIC_corrected,BIC,logL] = calculateModelSelectionScores(npar,logL_vec,opt,obj_type,ListOfIndividuals,individual_ID,opt_individuals)

        AIC=[];
        AIC_corrected=[]; 
        BIC=[];

        nobs = 0;
        switch opt_individuals
            case 'all individuals'
               for individual_i = 1:length(ListOfIndividuals) 
                   [nobs] = getNobsForListOfIndividuals(nobs,opt,ListOfIndividuals,individual_i);
               end
               np = npar*length(ListOfIndividuals);
               logL=sum(logL_vec);
            case 'single individuals'
               [nobs] = getNobsForListOfIndividuals(nobs,opt,ListOfIndividuals,individual_ID);
               np=npar;
               logL=logL_vec;
        end

        if strcmp(obj_type,'log-posterior')
            AIC= -2*logL+2*np;
            BIC= -2*logL+np*log(nobs);
        elseif strcmp(obj_type,'negative log-posterior')
            AIC= 2*logL+2*np;
            BIC= 2*logL+np*log(nobs);
        else
            error('Go to getModelSelectionScores() and implement score calculation for specified obj_type!')
        end
        AIC_corrected= AIC+(2*np^2+2*nobs)/(nobs-np-1);

        function [nobs] = getNobsForListOfIndividuals(nobs,opt,ListOfIndividuals,individual_ID)
            if opt.realdata == true
                [data] = getExperimentalData(individual_ID,opt);
            else
                load(['insilico_data_',opt.model_sim,'_',opt.noiseType,'_',opt.nL,'_individual_',ListOfIndividuals{individual_ID},'_topology_BIC.mat'],'data');
            end
            if opt.n_divStates>1
                yd = data.NumCellDiv_ALL;
            else
                yd = data.ym;
            end
            [a,b]=size(yd);
            for a_idx=1:a
                for b_idx=1:b
                    [r,c]=size(yd{a_idx,b_idx});
                    nobs =nobs+r*c;
                end
            end
        end
    end
end
