function [] = in_silico_main()

%% info:
% author: Lisa Bast
% date created: 23.07.2020

%% description:
% main function for performing Maximum Likelihood Estimation (MLE) for ordinary differential equation (ODE) compartment models describing hematopoiesis,
% based on simulated cell abundances 
%  -    compartments describe cells belonging to a certain cell type which underwent the same number 
%       of divisions 
%  -    parameters describe reaction rates 
%  -    reactions describe proliferation, differentiation and cell death
%       processes
% function simulates data from different lineage hierarchies and compares
% the performance of models of the true lineage hierarchy to any other
% (specified) lineage hierarchy

clear;
clc;
close all;

firstIndividual=2; %specify first individual

%% get specified settings:
[opt,model_str,j_end,j_sim_end,nl_end] = getInSilicoSettings();
             
for j_sim = 2:j_sim_end %model scheme used for simulations index
    %% generate in silico data for every specified noise level and individual
    opt = simulateData(j_sim,model_str,opt);
    for nl_id = 1:nl_end
        for j=3:j_end %index of model hierarchy used for fit
            %% update options:
            [opt,n_states] = updateInSilicoSettings(model_str,j,nl_id,opt);
            
            %% initialize values:
            [par_min,par_max,CI_lower,CI_upper,PAR_OPT_T,PAR_TEST_T,logL_vec] = initializeParameterResultMatrices(opt);
            
            for i_ID=firstIndividual:opt.n_individuals %index for individual for which parameter inference is performed

                clearvars -except firstIndividual i_ID opt model_str j_sim j_sim_end j j_end nl_id nl_end n_states par_min par_max CI_lower CI_upper ...
                                  PAR_OPT_T PAR_TEST_T rate_names_opt transformation_str individuals_str logL_vec theta_test

                [opt] = updatePaths(opt,i_ID);
                
                %% load simulated data for current settings:
                [data,theta_test,rate_names_test] = getSimulatedData(opt,i_ID);
                
                % track the time it takes to run optimization for 1 sample:
                tic;
                t_c = cputime;

                if any(any(isnan(data.NumCellDiv_ALL{1,1})))
                   continue; 
                end
                   
                %% update options for parameters
                opt = updateParameterOptions(data,opt);

                %% generate simulation file for model used in optimization
                createSimulationFiles(opt,true,opt.model);

                %% perform MLE optimization
                [parameters,opt,options_par] = performParameterEstimation(opt,theta_test,data,i_ID);

                time_in_s = toc;
                time_cpu_in_s = cputime - t_c;

                %% transform and save parameters, bounds, Confidence intervals
                [par_min,par_max,CI_lower,CI_upper,PAR_OPT_T,PAR_TEST_T,logL_vec] = saveTransformedParameterResult(parameters,par_min,par_max,CI_lower,CI_upper,PAR_OPT_T,PAR_TEST_T,opt.parTransformationStr,opt,theta_test,i_ID,rate_names_test,logL_vec);

                %% observe convergence of optimization:
                MS_percentage = calculateSizeLogLPlateau(parameters);

                %% get analytically estimated noise parameter (in case of hierarchical optimization) 
                [sigma_HO] = getAnalyticallyEstimatedSigma(opt);

                %% save workspace for current individual
                if opt.save
                    cd(opt.c_path);
                    cd(['./',opt.foldername,'/',opt.subfoldername,'/',opt.subsubfoldername]);
                    save(['WS_individual_',opt.individuals{i_ID},'.mat']);
                    cd(opt.c_path);
                end

                %% save data for plotting model fit in Python 
                saveModelFitResults(theta_test,parameters.MS.par(:,1),data,opt,n_states,sigma_HO);

            end
        end
    end
end
%% calculate AIC, BIC, AIC_corrected
[AIC_all_mat,AIC_corrected_all_mat,BIC_all_mat,LOGL_all_mat,AIC_mat,AIC_corrected_mat,BIC_mat,LOGL_mat,Time_mat,MS_num_mat] = calculateScoresMatrix(opt);
saveModelSelectionResult(opt,AIC_all_mat,AIC_corrected_all_mat,BIC_all_mat,LOGL_all_mat,AIC_mat,AIC_corrected_mat,BIC_mat,LOGL_mat,Time_mat,MS_num_mat)

    function [opt,n_states] = updateInSilicoSettings(model_str,j,nl_id,opt)
        opt.model = model_str{j};
        opt.subfoldername = model_str{j};
        %update opt and simulation files for current model used for fit
        [~,n_states,opt] = getModelParams(opt,opt.model);
        [opt] = getNoiseSettings(opt,opt.noiseLevel{nl_id});
        opt.nL = opt.noiseLevel{nl_id};
    end

end

    