close all;
clear;
clc;

opt_RUN = 'fit_samples';%'hierarchy_comparison_BIC';%'test_inference_procedure';

bool_fit_repetitions_seperately = true;

fileName = '2019_07_data.xlsx';
%individual_IDs = {'1'};%,'2','3'};
[individual_IDs,~] = sort(getIndividuals(fileName,bool_fit_repetitions_seperately));
% individual_IDs = {'353_1','345_1','559_1','560_1','482_1','522_1'};

sim_model_str = {'model_A'};
opt_model_str = {'model_A'};

% sim_model_str = {'model_A','model_B','model_C','model_D','model_E','model_F','model_G','model_H','model_I','model_J'};
% opt_model_str = {'model_A','model_B','model_C','model_D','model_E','model_F','model_G','model_H','model_I','model_J'};
        
switch opt_RUN
    case 'hierarchy_comparison_BIC'
        noise_level = [];
        for n_is = 1:5
            saveValues(opt_RUN,bool_fit_repetitions_seperately,n_is,individual_IDs,sim_model_str,opt_model_str,noise_level)
        end
    case 'fit_samples'
        noise_level = [];
        n_is=3;
        saveValues(opt_RUN,bool_fit_repetitions_seperately,n_is,individual_IDs,sim_model_str,opt_model_str,noise_level)
    case 'test_inference_procedure'
        noise_level = {'weak','middle','strong'};
        saveValues(opt_RUN,bool_fit_repetitions_seperately,n_is,individual_IDs,sim_model_str,opt_model_str,noise_level)
end



