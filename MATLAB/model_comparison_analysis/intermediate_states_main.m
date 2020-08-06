function [] = intermediate_states_main()

%% info:
% author: Lisa Bast
% date created: 23.07.2020

%% description:
% main function for performing Maximum Likelihood Estimation (MLE) for ordinary differential equation (ODE) compartment models describing hematopoiesis,
% based on experimentally measured cell abundances 
%  -    compartments describe cells belonging to a certain cell type which underwent the same number 
%       of divisions 
%  -    parameters describe reaction rates 
%  -    reactions describe proliferation, differentiation and cell death
%       processes
% function compares models of a range of intermediate states

clear;
clc;
close all;

firstIndividual=1; %specify first individual

%% get specified settings:
[opt,model_str,j_end] = getIntermediateStatesSettings();
             
%% perform data pre-processing:
dataPreprocessing(opt);

for iS_ID = 1:length(opt.n_intermediateStates) % index for number of intermediate states
    for j=1:j_end %index of model hierarchy used for fit
        
        %update options:
        [opt,n_states] = updateIntermediateStatesSettings(model_str,j,iS_ID,opt);

        %initialize values:
        [par_min,par_max,CI_lower,CI_upper,PAR_OPT_T,~,logL_vec] = initializeParameterResultMatrices(opt);

        for i_ID=firstIndividual:opt.n_individuals %index for individual for which parameter inference is performed

            clearvars -except firstIndividual i_ID opt model_str j j_end iS_ID n_states par_min par_max ...
                              CI_lower CI_upper PAR_OPT_T rate_names_opt transformation_str individuals_str logL_vec
            [opt] = updatePaths(opt,i_ID);
            
            % track the time it takes to run optimization for 1
            % sample:
            tic;
            t_c = cputime;

            %% get experimental data
            data = getExperimentalData(i_ID,opt);


            if any(any(isnan(data.NumCellDiv_ALL{1,1})))
               continue; 
            end

            opt = updateParameterOptions(data,opt);

            %% generate model file for optimization
            createSimulationFiles(opt,true,opt.model);

            %% perform MLE optimization
            [parameters,opt,options_par] = performParameterEstimation(opt,[],data,i_ID);

            time_in_s = toc;
            time_cpu_in_s = cputime - t_c;

            %% transform and save parameters, bounds, Confidence intervals
            [par_min,par_max,CI_lower,CI_upper,PAR_OPT_T,~,logL_vec] = saveTransformedParameterResult(parameters,par_min,par_max,CI_lower,CI_upper,PAR_OPT_T,[],opt.parTransformationStr,opt,[],i_ID,[],logL_vec);

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
            saveModelFitResults([],parameters.MS.par(:,1),data,opt,n_states,sigma_HO);
        end
    end
    %% calculate AIC, BIC, AIC_corrected
    [AIC_all_mat,AIC_corrected_all_mat,BIC_all_mat,LOGL_all_mat,AIC_mat,AIC_corrected_mat,BIC_mat,LOGL_mat,Time_mat,MS_num_mat] = calculateScoresMatrix(opt);
    saveModelSelectionResult(opt,AIC_all_mat,AIC_corrected_all_mat,BIC_all_mat,LOGL_all_mat,AIC_mat,AIC_corrected_mat,BIC_mat,LOGL_mat,Time_mat,MS_num_mat)
end

    function [opt,n_states] = updateIntermediateStatesSettings(model_str,j,iS_ID,opt)
        opt.iS_ID = iS_ID;
        opt.model = model_str{j};
        [~,n_states,opt] = getModelParams(opt,opt.model); 
        [opt] = getResultsFolderStrings(opt);
    end

end

    