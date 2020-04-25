function [] = RUN_H_hierarchy

%% info:
% author: Lisa Bast
% date: 13.01.16
%% description:
% main function for performing MLE for ODE compartment models describing hematopoiesis or MDS,
% based on experimentally measured cell abundances
%  -    compartments describe cells belonging to a certain cell type which underwent the same number 
%       of divisions 
%  -    parameters describe reaction rates 
%  -    reactions describe proliferation, differentiation and cell death
clear;
clc;
close all;

opt = setPaths();

opt.RUN = 'hierarchy_comparison_BIC'; 

switch opt.RUN
    case 'hierarchy_comparison_BIC'
        str = '_hierarchy_BIC.mat';
    otherwise
        str='';
end

%specify first individual
firstIndividual=1;
possibleCompartments = {'HSC','MPP','MLP','CMP','GMP','MEP','mature','dead'};
transformation_str = {'lin','log10','ratio'};
[opt,model_str,j_end,j_sim_end,nl_end] = getAppSettings_hierarchy(opt);
             
%% data pre-processing if necessary
if opt.realdata == true
   dataPreprocessing(possibleCompartments,opt.fitInitialConds);
end

for nl_id = 1:nl_end
    if iscell(opt.noiseLevel)
        [opt] = getNoiseSettings(opt,opt.noiseLevel{nl_id});
        opt.nL = opt.noiseLevel{nl_id};
    else
        opt.nL = opt.noiseLevel;
    end
    for j_sim = 1:j_sim_end %model scheme used for simulations index
        %initialize values
        Scores_all = cell(4,length(opt.n_intermediateStates));
        Scores = cell(4,length(opt.n_intermediateStates));
        MS_num = cell(1,length(opt.n_intermediateStates));
        for j=1:j_end %model scheme used for fit index
            for iS_ID = 1:length(opt.n_intermediateStates) % intermediate state index (in case opt.n_intermediateStates is a vector)
                opt.iS_ID = iS_ID;
                %% update options and simulate data if necessary
                opt.model = model_str{j};
                if j==1
                    opt.model_sim = model_str{j_sim}; 
                end
                [opt] = getResultsFolderStrings(opt);
                if opt.realdata==true
                    theta_test=[];
                    [~,n_states,opt] = getModelParams(opt,opt.model); %sigma is not used
                    rate_names_test = [];
                else
                    if j==1
                        %create simulation file for current model & generate in
                        %silico data
                        if (opt.applyNoise && iscell(opt.noiseLevel))
                            %update sigma
                            if (strcmp(opt.noiseLevel{nl_id},'realistic') && strcmp(opt.noiseType,'LogNormal'))
                                opt.sigma=getRealisticNoiseLevelFromRealDataFitResults(opt);
                            end
                        end
                        [theta_test,n_states,opt] = getModelParams(opt,opt.model_sim);
                        rate_names_test = strtrim(opt.rates(~strwcmp(opt.rates,'x0_*')));
                        createSimulationFiles(opt,true,opt.model_sim)
                        for i_sim_ID = 1:opt.n_individuals
                            [data] = getSimData(n_states,opt,theta_test);
                            save(['insilico_data_',opt.model_sim,'_',opt.noiseType,'_',opt.nL,'_individual_',opt.individuals{i_sim_ID},str],'data');
                        end
                    end
                    %update opt and simulation files for current model used for
                    %fit
                    [~,n_states,opt] = getModelParams(opt,opt.model);
                end
                %initialize values
                logL_List = zeros(1,opt.n_individuals);
                for i_ID=firstIndividual:opt.n_individuals
                    clearvars -except firstIndividual i_ID current_dir opt bool_simulate model_str model_comparison_pairs ...
                                      j j_sim j_end j_sim_end iS_ID result_logL N_theta p_test theta_test ...
                                      n_states n_theta model_sim logL_List Scores_all Scores MS_num par_min par_max ...
                                      CI_lower CI_upper PAR_OPT_T PAR_TEST_T rate_names_test rate_names_opt transformation_str ... 
                                      possibleCompartments individuals_str str rate_names_test nl_id nl_end group_str
                    tic;
                    t_c = cputime;
                    if (opt.applyNoise && iscell(opt.noiseLevel))
                        opt.subsubfoldername = ['individual_',opt.individuals{i_ID},'_',opt.nL,'_noise'];
                    else
                        opt.subsubfoldername = ['individual_',opt.individuals{i_ID}];
                    end
                    createResultDirs(opt.c_path,opt.foldername,opt.subfoldername,opt.subsubfoldername);
                    %% get in-silico or experimental data
                    [data,opt] = getData(opt,i_ID,possibleCompartments,str);
                    if any(any(isnan(data.NumCellDiv_ALL{1,1})))
                       continue; 
                    end
                    %% generate model file for optimization
                    if (opt.realdata==true) || ~(strcmp(opt.model,opt.model_sim))
                        bool_simulate = true;
                    else
                        bool_simulate = false;
                    end
                    createSimulationFiles(opt,bool_simulate,opt.model);

                    %% optimize cost function
                    [options_par, parameters, opt] = getOptimizationSettings(opt,theta_test,data);
                    logL = @(theta) logL_H(theta,data,opt,i_ID);

                    % define logL for storing values of sigma for optimal parameter:
                    if strcmp(opt.optimizationMode,'hierarchical')
                        opt.HO.save = true;
                        logL_final = @(theta) logL_H(theta,data,opt,i_ID);
                        opt.HO.save = false;
                    end

                    % test gradient
%                     if opt.testGradient == true
%                         test_and_plot_Gradient(parameters,logL,opt,i_ID)
%                     end

                    [parameters] = optimizationProc(options_par,parameters,logL,logL_final,opt,i_ID);
                    time_in_s = toc;
                    time_cpu_in_s = cputime - t_c;

                    % get, transform and save parameters, bounds, Confidence intervals
                    individuals_str = opt.individuals;
                    if i_ID==firstIndividual
                        group_str = cell(opt.n_individuals,1);
                        [par_min,par_max,CI_lower,CI_upper,PAR_OPT_T,PAR_TEST_T] = initializeParResult(transformation_str,opt,theta_test);
                    end
                    [par_min,par_max,CI_lower,CI_upper,PAR_OPT_T,PAR_TEST_T] = saveTransformedParResult(parameters,par_min,par_max,CI_lower,CI_upper,individuals_str,PAR_OPT_T,PAR_TEST_T,transformation_str,opt,theta_test,i_ID,rate_names_test);

                    %% observe convergence of optimization
                    MS_num{iS_ID}(j,i_ID) = calculateSizeLogLPlateau(parameters);

                    %% calculate AIC, BIC, AIC_corrected
                    logL_List(i_ID) = parameters.MS.logPost(1);
                    group_str{i_ID} = opt.group;
                    if strcmp(opt.RUN, 'topology_comparison') && (i_ID==opt.n_individuals)
                        [Scores_all{1,iS_ID}(j),Scores_all{2,iS_ID}(j),Scores_all{3,iS_ID}(j),Scores_all{4,iS_ID}(j)] = getModelSelectionScores(parameters.number,logL_List,opt,options_par.obj_type,opt.individuals,[],'all',group_str);
                    end
                    [Scores{1,iS_ID}(j,i_ID),Scores{2,iS_ID}(j,i_ID),Scores{3,iS_ID}(j,i_ID),Scores{4,iS_ID}(j,i_ID)] = getModelSelectionScores(parameters.number,parameters.MS.logPost(1),opt,options_par.obj_type,opt.individuals,i_ID,'single',opt.group);

                    %% get analytically estimated sigma (in case of hierarchical optimization) 
                    [sigma_HO] = getAnalyticallyEstimatedSigma(opt);

                    %% 4) save results
                    if opt.save
                        cd(opt.c_path);
                        cd(['./',opt.foldername,'/',opt.subfoldername,'/',opt.subsubfoldername]);
                        save(['WS_',opt.group,'_individual_',opt.individuals{i_ID},'.mat']);
                        cd(opt.c_path);
                        if strcmp(opt.RUN, 'topology_comparison')
                            cd(['./',opt.foldername,'/',opt.subfoldername]);
                            save(['WS_',opt.group,'_Scores','.mat'],'result_Scores');
                            cd(opt.c_path);
                        end
                    end

                    %% 5) plot data/ export data for plotting graphics in Python 
                    %store for every individual:
                    %a) ws_modelFitPlot.mat
                    %b) ws_modelFitPlot_sum.mat
                    if opt.n_divStates>1
                        opt.plotCompartmentSum = false;
                        if ~opt.realdata && strcmp(opt.model_sim,opt.model)
                            plotResults(theta_test,parameters.MS.par(:,1),data,opt,n_states,opt.individuals{i_ID},sigma_HO);
                        else
                            plotResults([],parameters.MS.par(:,1),data,opt,n_states,opt.individuals{i_ID},sigma_HO);
                        end
                    end
                    opt.plotCompartmentSum = true;
                    if ~opt.realdata && strcmp(opt.model_sim,opt.model)
                        plotResults(theta_test,parameters.MS.par(:,1),data,opt,n_states,opt.individuals{i_ID},sigma_HO);
                    else
                        plotResults([],parameters.MS.par(:,1),data,opt,n_states,opt.individuals{i_ID},sigma_HO);
                    end
                end
                if opt.exportResults4Python %&& (j==j_end) 
                    % store for every folder (iS)
                    %c) ws_scores.mat
                    [AIC_all_mat,AIC_corrected_all_mat,BIC_all_mat,LOGL_all_mat,AIC_mat,AIC_corrected_mat,BIC_mat,LOGL_mat,MS_num_mat] = getScoreMatrices(Scores_all,Scores,MS_num,iS_ID);
                    cd(opt.foldername);
                    if strcmp(opt.RUN, 'topology_comparison')
                        save('ws_scores.mat','BIC_mat','AIC_mat','AIC_corrected_mat','LOGL_mat','BIC_all_mat','AIC_all_mat','AIC_corrected_all_mat','LOGL_all_mat','MS_num_mat');
                    else
                        save('ws_scores.mat','BIC_mat','AIC_mat','AIC_corrected_mat','LOGL_mat','MS_num_mat');
                    end
                    cd(opt.c_path);
                end
            end
        end
    end
end
end