function [] = BuildScoresMatrix()
    clear;
    clc;
    close all;
    
    c_path = cd();
    cd('../../../')
    path = cd();
    addpath(genpath([path,'/Tools']));
    cd(c_path)
    
    %% specify:
    n_iS = 3;
%     n_iS = 1:5;
    r_path = ['results_hierarchy_comparison_BIC_7divs_',num2str(n_iS),'iS_HO_LogNormal_fit_iC'];
    
    %%
    M_names={'model_A','model_B','model_C','model_D','model_E','model_F','model_G','model_H','model_I','model_J'};

    bool_fit_repetitions_seperately = true;
    bool_healthy_individuals_only = true;
    
    if length(n_iS)>1
        I_names = {'353_1','345_1','559_1','560_1','482_1','522_1'};
    else
        if bool_fit_repetitions_seperately==true
            if bool_healthy_individuals_only==true
                I_names = {'439_1','547_1','482_1','508_1','522_1','552_1','519_1','370_1','500_1','353_1','345_1','311_1','380_1','391_1','391_2','312_1','312_2','560_1','559_1','561_1','348_1'};
            else
                I_names = {'439_1','547_1','482_1','508_1','522_1','552_1','519_1','370_1','500_1','353_1','345_1','311_1','380_1','391_1','391_2','312_1','312_2','560_1','559_1','561_1','348_1','135_1','140_1','227_1','279_1','326_1','354_1','360_1','373_1','377_1'};
            end
            add_str = '_rep_sep';
            TH=length(I_names);
        else
            if bool_healthy_individuals_only==true
                I_names = {'439','547','482','508','522','552','519','370','500','353','345','311','380','391','312','560','559','561','348'};
            else
                I_names = {'439','547','482','508','522','552','519','370','500','353','345','311','380','391','312','560','559','561','348','135','140','227','279','326','354','360','373','377'};
            end
            add_str = '';
            TH=length(I_names);
        end
    end
    
    group_str_all = cell(length(I_names),1);
    
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
            clearvars -except group_str_all model_id indi_id M_names I_names AIC_corrected_mat AIC_mat BIC_mat LOGL_mat AIC_corrected_all_mat AIC_all_mat BIC_all_mat LOGL_all_mat MS_num_mat r_path c_path TH add_str
            if indi_id<=TH
                group_str='healthy';
            else
                group_str='MDS';
            end
            cd([r_path,'/',M_names{model_id},'_model/individual_',I_names{indi_id}]);
            load(['WS_',group_str,'_individual_',I_names{indi_id},'.mat'],'parameters','opt','options_par')
            cd(c_path);
            [AIC_mat(model_id,indi_id),AIC_corrected_mat(model_id,indi_id),BIC_mat(model_id,indi_id),LOGL_mat(model_id,indi_id)] = getModelSelectionScores(parameters.number,parameters.MS.logPost(1),opt,'log-posterior',I_names,indi_id,'single',group_str);
            LOGL_vec(indi_id) = parameters.MS.logPost(1);
            MS_num_mat(model_id,indi_id) = calculateSizeLogLPlateau(parameters);
            group_str_all{indi_id} = group_str;
        end
        [AIC_all_mat(model_id),AIC_corrected_all_mat(model_id),BIC_all_mat(model_id),LOGL_all_mat(model_id)] = getModelSelectionScores(parameters.number,LOGL_vec,opt,options_par.obj_type,I_names,indi_id,'all',group_str_all);
    end
    clearvars -except AIC_corrected_mat AIC_mat BIC_mat LOGL_mat AIC_corrected_all_mat AIC_all_mat BIC_all_mat LOGL_all_mat MS_num_mat r_path c_path add_str
    cd(r_path)
    save(['ws_scores',add_str,'.mat'],'AIC_corrected_mat','AIC_mat','BIC_mat','LOGL_mat','AIC_corrected_all_mat','AIC_all_mat','BIC_all_mat','LOGL_all_mat','MS_num_mat')
    cd(c_path);
end