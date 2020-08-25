function [] = BuildScoresMatrixInSilico()
    clear;
    clc;
    close all;
    
    c_path = cd();
    cd('../')
    path = cd();
    addpath(genpath([path,'/toolboxes']));
    addpath(genpath([path,'/utils']));
    cd(c_path)
    
    %% specify:
    n_iS = 3;
    M_names_opt={'model_A','model_B','model_C','model_D','model_E','model_F','model_G','model_H','model_I','model_J'};
    M_names_sim={'model_A'};
    I_names = {'1','2','3','4','5'};
    noise_level_str = {'strong'};
    for simModel = M_names_sim
        for noiseLevel = noise_level_str
            r_path = strjoin(['results_test_7divs_',num2str(n_iS),'iS_HO_LogNormal_simulatedFrom_',simModel,'_fit_iC']);
            r_path = strrep(r_path,' ','');
            add_str = strjoin(['_',noiseLevel,'_noise']);
            add_str = strrep(add_str,' ','');
            AIC_corrected_mat = zeros(length(M_names_opt),length(I_names));
            AIC_mat = zeros(length(M_names_opt),length(I_names));
            BIC_mat = zeros(length(M_names_opt),length(I_names));
            LOGL_mat = zeros(length(M_names_opt),length(I_names));
            AIC_corrected_all_mat = zeros(length(M_names_opt),1);
            AIC_all_mat = zeros(length(M_names_opt),1);
            BIC_all_mat = zeros(length(M_names_opt),1);
            LOGL_all_mat = zeros(length(M_names_opt),1);
            MS_num_mat = zeros(length(M_names_opt),length(I_names));
            for model_id=1:length(M_names_opt)
                LOGL_vec = zeros(length(I_names),1);
                for indi_id=1:length(I_names)
                    clearvars -except model_id indi_id M_names_opt M_names_sim I_names noise_level_str noiseLevel simModel AIC_corrected_mat AIC_mat BIC_mat LOGL_mat AIC_corrected_all_mat AIC_all_mat BIC_all_mat LOGL_all_mat MS_num_mat r_path c_path TH add_str
                    r_path_detailed = [r_path,'/',M_names_opt{model_id},'/individual_',I_names{indi_id},add_str];
                    cd(r_path_detailed)
                    load(['WS_individual_',I_names{indi_id},'.mat'],'parameters','opt','options_par')
                    cd(c_path);
                    opt.c_path = c_path;
                    opt.individuals = I_names;
                    [AIC_mat(model_id,indi_id),AIC_corrected_mat(model_id,indi_id),BIC_mat(model_id,indi_id),LOGL_mat(model_id,indi_id)] = calculateModelSelectionScores(parameters.number,parameters.MS.logPost(1),opt,'log-posterior',I_names,indi_id,'single individuals');
                    LOGL_vec(indi_id) = parameters.MS.logPost(1);
                    MS_num_mat(model_id,indi_id) = calculateSizeLogLPlateau(parameters);
                end
                [AIC_all_mat(model_id),AIC_corrected_all_mat(model_id),BIC_all_mat(model_id),LOGL_all_mat(model_id)] = calculateModelSelectionScores(parameters.number,LOGL_vec,opt,options_par.obj_type,I_names,indi_id,'all individuals');
            end
            clearvars -except AIC_corrected_mat AIC_mat BIC_mat LOGL_mat AIC_corrected_all_mat AIC_all_mat BIC_all_mat LOGL_all_mat MS_num_mat r_path c_path add_str
            cd(r_path)
            save(['ws_scores',add_str,'.mat'],'AIC_corrected_mat','AIC_mat','BIC_mat','LOGL_mat','AIC_corrected_all_mat','AIC_all_mat','BIC_all_mat','LOGL_all_mat','MS_num_mat')
            cd(c_path);
        end
    end
    
end