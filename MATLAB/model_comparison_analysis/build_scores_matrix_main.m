function [] = BuildScoresMatrix()
    clear;
    clc;
    close all;
    
    c_path = cd();
    cd('../')
    path = cd();
    addpath(genpath([path,'/toolboxes']));
    cd(c_path)
    
    %% specify:
    n_iS = 3;
%     n_iS = 1:5;
    r_path = ['results_7divs_',num2str(n_iS),'iS_HO_LogNormal_fit_iC'];
    
    %%
    M_names={'model_A','model_B','model_C','model_D','model_E','model_F','model_G','model_H','model_I','model_J'};

    bool_fit_repetitions_seperately = true;
    
    if length(n_iS)>1
        I_names = {'353_1','345_1','559_1','560_1','482_1','522_1'};
    else
        if bool_fit_repetitions_seperately==true
            I_names = {'311_1','353_1','312_2','380_1','370_1','547_1','482_1','522_1','439_1','559_1'};
            add_str = '_rep_sep';
        else
            I_names = {'311','353','312','380','370','547','482','522','439','559'};
            add_str = '';
        end
    end
    
    AIC_corrected_mat = zeros(length(M_names),length(I_names));
    AIC_mat = zeros(length(M_names),length(I_names));
    BIC_mat = zeros(length(M_names),length(I_names));
    LOGL_mat = zeros(length(M_names),length(I_names));
    AIC_corrected_all_mat = zeros(length(M_names),1);
    AIC_all_mat = zeros(length(M_names),1);
    BIC_all_mat = zeros(length(M_names),1);
    LOGL_all_mat = zeros(length(M_names),1);
    MS_num_mat = zeros(length(M_names),length(I_names));
    for model_id=1:length(M_names)
        LOGL_vec = zeros(length(I_names),1);
        for indi_id=1:length(I_names)
            clearvars -except model_id indi_id M_names I_names AIC_corrected_mat AIC_mat BIC_mat LOGL_mat AIC_corrected_all_mat AIC_all_mat BIC_all_mat LOGL_all_mat MS_num_mat r_path c_path TH add_str
            cd([r_path,'/',M_names{model_id},'_model/individual_',I_names{indi_id}]);
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