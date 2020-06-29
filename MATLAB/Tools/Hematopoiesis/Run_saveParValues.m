close all;
clear;
clc;

% opt_RUN = 'hierarchy_comparison_BIC_test';
opt_RUN = 'hierarchy_comparison_BIC_intermedStateComp';
% opt_RUN = 'hierarchy_comparison_BIC';
% opt_RUN = 'test_inference_procedure';
% opt_RUN = 'fit_samples';

switch opt_RUN
    case 'hierarchy_comparison_BIC'
        noise_level = [];
        opt_group = 'healthy';
        bool_fit_repetitions_seperately = true;%false;
        if bool_fit_repetitions_seperately==true
            if strcmp(opt_group,'healthy')
                individual_IDs={'439_1','547_1','482_1','508_1','522_1','519_1','370_1','500_1','353_1','311_1','380_1','312_1','312_2','559_1'};
            elseif strcmp(opt_group,'CHIP')
                individual_IDs={'345_1','391_1','391_2','552_1','560_1','561_1','348_1'};
            elseif strcmp(opt_group,'MDS')
                individual_IDs= {'360_1','373_1','377_1','227_1','279_1','140_1','135_1','326_1','354_1'};
            end
        else
            if strcmp(opt_group,'healthy')
                individual_IDs={'439','547','482','508','522','519','370','500','353','311','380','312','559'};
            elseif strcmp(opt_group,'CHIP')
                individual_IDs={'345','391','552','560','561','348'};
            elseif strcmp(opt_group,'MDS')
                individual_IDs={'360','373','377','227','279','140','135','326','354'};
            end
        end
        sim_model_str = {'model_A','model_B','model_C','model_D','model_E','model_F','model_G','model_H','model_I','model_J'};
        opt_model_str = {'model_A','model_B','model_C','model_D','model_E','model_F','model_G','model_H','model_I','model_J'};
        n_is = 3;
        saveValues(opt_RUN,opt_group,bool_fit_repetitions_seperately,n_is,individual_IDs,sim_model_str,opt_model_str,noise_level)
    case 'hierarchy_comparison_BIC_intermedStateComp'
        individual_IDs = {'482_1','522_1','353_1','559_1'};%,'345_1','560_1'
        noise_level = [];
        opt_group = 'healthy';
        bool_fit_repetitions_seperately = false;%true;
        sim_model_str = {'model_A','model_B','model_C','model_D','model_E','model_F','model_G','model_H','model_I','model_J'};
        opt_model_str = {'model_A','model_B','model_C','model_D','model_E','model_F','model_G','model_H','model_I','model_J'};
        for n_is = 1:5
            saveValues(opt_RUN,opt_group,bool_fit_repetitions_seperately,n_is,individual_IDs,sim_model_str,opt_model_str,noise_level)
        end
    case 'hierarchy_comparison_BIC_test'
        individual_IDs = {'1'};%,'2','3'};
        noise_level = {'weak','middle','strong','realistic'};
        opt_group = 'healthy';
        bool_fit_repetitions_seperately = false;%true;
        sim_model_str = {'model_A','model_B','model_C','model_D','model_E','model_F','model_G','model_H','model_I','model_J'};
        opt_model_str = {'model_A','model_B','model_C','model_D','model_E','model_F','model_G','model_H','model_I','model_J'};
        n_is=3;
        saveValues(opt_RUN,opt_group,bool_fit_repetitions_seperately,n_is,individual_IDs,sim_model_str,opt_model_str,noise_level)
    case 'test_inference_procedure'
        individual_IDs = {'1'};
        noise_level = {'realistic'};
        opt_group = 'healthy';
        bool_fit_repetitions_seperately = false;%true;
        sim_model_str = {'model_A'};
        opt_model_str = {'model_A'};
        n_is=3;
    case 'fit_samples'
        individual_IDs = sort(getIndividuals(fileName,group_str{g_id},false,bool_fit_repetitions_seperately));
        noise_level = [];
        opt_group = 'healthy';%'MDS'
        bool_fit_repetitions_seperately = false;%true;
        sim_model_str = {''};
        opt_model_str = {'model_A'};
        n_is=3;
        saveValues(opt_RUN,opt_group,bool_fit_repetitions_seperately,n_is,individual_IDs,sim_model_str,opt_model_str,noise_level)
end
