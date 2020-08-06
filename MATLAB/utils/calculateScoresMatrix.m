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
end
