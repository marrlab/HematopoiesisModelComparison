function [] = saveValues(opt_RUN,opt_group,bool_fit_repetitions_seperately,n_is,individual_IDs,sim_model_str,opt_model_str,noise_level)

% opt_RUN = 'fit_samples';%'hierarchy_comparison_BIC'
% opt_group = 'healthy';%'MDS'
% bool_fit_repetitions_seperately = true;
% bool_realdata=false;

fileName = '2019_07_data.xlsx';

cd('../../')
path1 = cd();
addpath(genpath([path1,'/Tools/Hematopoiesis']));
addpath(genpath([path1,'/Tools/other']));
cd('./AnalysisAndModeling/BulkAnalysis/')
current_dir = cd();
 
if strcmp(opt_RUN,'test_inference_procedure') || strcmp(opt_RUN,'hierarchy_comparison_BIC_test')
    noiselevel_str = strjoin(strcat(noise_level,'_'));
    noiselevel_str = noiselevel_str(noiselevel_str ~= ' ');
    if strcmp(opt_RUN,'test_inference_procedure')
        path2=[current_dir,'/Healthy_MDS_Comparison/Parameter_Inference/'];
        ResultsFolderName = ['results_test_inference_procedure_7divs_',num2str(n_is),'iS_HO_LogNormal_',noiselevel_str(1:end-1),'_fit_iC'];
    else
        path2=[current_dir,'/Lineage_Hierarchy_Comparison_preAnalysis/Model_Selection/'];
    end
    cd(path2);
    for sm_id = 1:length(sim_model_str)
        if strcmp(opt_RUN,'hierarchy_comparison_BIC_test')
            ResultsFolderName = ['results_hierarchy_comparison_BIC_test_7divs_',num2str(n_is),'iS_HO_LogNormal_simulatedFrom_',sim_model_str{sm_id},'_',noiselevel_str(1:end-1),'_fit_iC'];
        end
        clearvars PAR_TEST_T PAR_OPT_T individuals_str par_min par_max CI_lower CI_upper theta_test rate_names_test rate_names_opt
        for om_id = 1: length(opt_model_str)
            clearvars -except g_id sm_id om_id current_dir group_str sim_model_str opt_model_str individual_IDs path1 path2...
                              theta_test individuals_str n_is ResultsFolderName noise_level opt_group opt_RUN noiselevel_str
                          %p_min p_max ci_lower ci_upper Par_OPT_T Par_TEST_T
            par_min=[];
            par_max = [];
            CI_lower = [];
            CI_upper = [];
            PAR_OPT_T = [];
            PAR_TEST_T = [];
            for nl_id = 1:length(noise_level)
                for i_id = 1:length(individual_IDs)
                    target_dir = [ResultsFolderName,'/',opt_model_str{om_id},'_model/individual_',individual_IDs{i_id},'_',noise_level{nl_id},'_noise'];
                    cd(target_dir)
                    %if om_id==1
                        load(['WS_',opt_group,'_individual_',individual_IDs{i_id}],'parameters','opt','transformation_str','theta_test','rate_names_test','individuals_str');
                        rate_names_opt = rate_names_test;
                        cd(path2);
                        if (i_id==1)
                            p_min = zeros(length(transformation_str),length(opt.rates(~strwcmp(opt.rates,'x0_*'))),opt.n_individuals);
                            p_max = zeros(length(transformation_str),length(opt.rates(~strwcmp(opt.rates,'x0_*'))),opt.n_individuals);
                            ci_lower = zeros(length(transformation_str),length(opt.rates(~strwcmp(opt.rates,'x0_*'))),opt.n_individuals);
                            ci_upper = zeros(length(transformation_str),length(opt.rates(~strwcmp(opt.rates,'x0_*'))),opt.n_individuals);
                            Par_OPT_T = zeros(length(transformation_str),length(opt.rates(~strwcmp(opt.rates,'x0_*'))),opt.n_individuals);
                            Par_TEST_T = zeros(length(transformation_str),length(opt.rates(~strwcmp(opt.rates,'x0_*'))),opt.n_individuals);
                        end
                        opt.foldername = ResultsFolderName;
                        opt.c_path = cd();
                        [p_min, p_max, ci_lower, ci_upper, Par_OPT_T, Par_TEST_T]  = saveTransformedParResult(parameters,p_min,p_max,ci_lower,ci_upper,individual_IDs,Par_OPT_T,Par_TEST_T,transformation_str,opt,theta_test,i_id,rate_names_test);
                    %else
                        %load(['WS_',opt_group,'_individual_',individual_IDs{i_id}],'parameters','opt','transformation_str');
                        %cd(path2);
                        %[p_min,p_max,ci_lower,ci_upper,individual_IDs,Par_OPT_T,Par_TEST_T]  = saveTransformedParResult(parameters,p_min,p_max,ci_lower,ci_upper,individual_IDs,Par_OPT_T,Par_TEST_T,transformation_str,opt,theta_test,i_id,rate_names_test);
                    %end
                    if i_id==length(individual_IDs)
                        par_min = cat(3,par_min, p_min);
                        par_max = cat(3,par_max, p_max);
                        CI_lower = cat(3,CI_lower, ci_lower);
                        CI_upper = cat(3,CI_upper, ci_upper);
                        PAR_OPT_T = cat(3,PAR_OPT_T, Par_OPT_T);
                        PAR_TEST_T = cat(3,PAR_TEST_T, Par_TEST_T);
                        if nl_id == length(noise_level) 
                            cd(['./',opt.foldername,'/',opt.subfoldername,'/',opt.subsubfoldername]);
                            save(['ws_parameters_',opt_group,'.mat'],'par_min','par_max','CI_lower','CI_upper','PAR_OPT_T','PAR_TEST_T','rate_names_opt','rate_names_test','transformation_str','individuals_str');
                            cd(path2);
                        end
                    end
                end
            end
        end
    end
 else
    switch opt_RUN
        case 'fit_samples'
            ResultsFolderName = ['results_fit_samples_7divs_',num2str(n_is),'iS_HO_LogNormal_fit_iC'];
            path2=[current_dir,'/Healthy_MDS_Comparison/Parameter_Inference/'];
            add_str2='';
        case {'hierarchy_comparison_BIC_intermedStateComp','hierarchy_comparison_BIC'}
            ResultsFolderName = ['results_hierarchy_comparison_BIC_7divs_',num2str(n_is),'iS_HO_LogNormal_fit_iC'];
            path2=[current_dir,'/Lineage_Hierarchy_Comparison/Model_Selection/'];
            add_str2='_intermedStates';
    end
    cd(path2)

    if bool_fit_repetitions_seperately==true
        add_str_fit_repetitions_seperately = '_rep_sep';
    else
        add_str_fit_repetitions_seperately = '';
    end

    opt_model_str = {'model_A','model_B','model_C','model_D','model_E','model_F','model_G','model_H','model_I','model_J'};
    clearvars PAR_TEST_T theta_test rate_names_test
    for om_id = 1:length(opt_model_str)
        clearvars -except g_id sm_id om_id current_dir add_str2 group_str sim_model_str opt_model_str path1 path2...
                          theta_test rate_names_test rate_names_opt PAR_TEST_T individual_IDs individuals_str individual_IDs...
                          fileName ResultsFolderName add_str_fit_repetitions_seperately bool_fit_repetitions_seperately opt_group
        for i_id = 1:length(individual_IDs)
            target_dir = ['./',ResultsFolderName,'/',opt_model_str{om_id},'_model/individual_',individual_IDs{i_id}];
            cd(target_dir)
            if i_id==1
                load(['WS_',opt_group,'_individual_',individual_IDs{i_id}],'parameters','opt','transformation_str','theta_test');
                opt.c_path = cd();
                cd(path2);    
                rate_names_opt = parameters.name;
                opt.foldername = ResultsFolderName;
                opt.individuals = individual_IDs;
                opt.n_individuals = length(individual_IDs);
                if (i_id==1)
                    par_min = zeros(length(transformation_str),length(opt.rates(~strwcmp(opt.rates,'x0_*'))),opt.n_individuals);
                    par_max = zeros(length(transformation_str),length(opt.rates(~strwcmp(opt.rates,'x0_*'))),opt.n_individuals);
                    CI_lower = zeros(length(transformation_str),length(opt.rates(~strwcmp(opt.rates,'x0_*'))),opt.n_individuals);
                    CI_upper = zeros(length(transformation_str),length(opt.rates(~strwcmp(opt.rates,'x0_*'))),opt.n_individuals);
                    PAR_OPT_T = zeros(length(transformation_str),length(opt.rates(~strwcmp(opt.rates,'x0_*'))),opt.n_individuals);
                    PAR_TEST_T = zeros(length(transformation_str),length(opt.rates(~strwcmp(opt.rates,'x0_*'))),opt.n_individuals);
                end
                [par_min, par_max, CI_lower, CI_upper, PAR_OPT_T, ~]  = saveTransformedParResult(parameters,par_min,par_max,CI_lower,CI_upper,individual_IDs,PAR_OPT_T,[],transformation_str,opt,[],i_id,rate_names_opt);
                cd(path2);
            else
                load(['WS_',opt_group,'_individual_',individual_IDs{i_id}],'parameters','opt','transformation_str','theta_test');
                opt.c_path = cd();
                cd(path2);
                opt.foldername = ResultsFolderName;
                opt.individuals = individual_IDs;
                opt.n_individuals = length(individual_IDs);
                [par_min, par_max, CI_lower, CI_upper, PAR_OPT_T, ~] = saveTransformedParResult(parameters,par_min,par_max,CI_lower,CI_upper,individual_IDs,PAR_OPT_T,[],transformation_str,opt,[],i_id,rate_names_opt);
                cd(path2);
            end
            if i_id==length(individual_IDs)
                individuals_str = individual_IDs;
                cd(target_dir);
                rate_names_test = rate_names_opt;
                save(['ws_parameters_',opt.group,add_str_fit_repetitions_seperately,add_str2,'.mat'],'par_min','par_max','CI_lower','CI_upper','PAR_OPT_T','PAR_TEST_T','rate_names_opt','rate_names_test','transformation_str','individuals_str');
                cd(path2);
            end

        end
    end
end
cd([path1,'/Tools/Hematopoiesis'])
% end