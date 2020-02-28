function [] = saveValues(opt_RUN,opt_group,bool_fit_repetitions_seperately,bool_realdata)

% opt_RUN = 'fit_samples';%'hierarchy_comparison_BIC'
% opt_group = 'healthy';%'MDS'
% bool_fit_repetitions_seperately = true;
% bool_realdata=false;

fileName = '2019_07_data.xlsx';

cd('../../')
path1 = cd();
addpath(genpath([path1,'/Tools']));
cd('./HematopoiesisModel/')
current_dir = cd();
 
if bool_realdata == false
    path=[current_dir,'/Hematopoiesis_Healthy_MDS_Comparison/Parameter_Inference/'];
    cd(path);
    sim_model_str = {'model_A','model_B','model_C','model_D','model_E','model_F','model_G','model_H','model_I','model_J'};
    opt_model_str = {'model_A','model_B','model_C','model_D','model_E','model_F','model_G','model_H','model_I','model_J'};
    individual_ID = {'1','2','3'};
    for sm_id = 1:length(sim_model_str)
        clearvars PAR_TEST_T individuals_str theta_test rate_names_test
        for om_id = 1: length(opt_model_str)
            clearvars -except g_id sm_id om_id current_dir group_str sim_model_str opt_model_str individual_ID...
                              theta_test rate_names_test PAR_TEST_T individuals_str
            for i_id = 1:length(individual_ID)
                target_dir = ['./results_hierarchy_comparison_BIC_test_7divs_3iS_HO_LogNormal_simulatedFrom_',sim_model_str{sm_id},'_realistic_fit_iC/',opt_model_str{om_id},'_model/individual_',individual_ID{i_id}];
                cd(target_dir)
                if om_id==1
                    load(['WS_',opt_group,'_individual_',individual_ID{i_id}],'parameters','opt','transformation_str','theta_test','rate_names_test','rate_names_opt','individuals_str');
                    cd(current_dir);
                    for ts_ID=1:length(transformation_str)
                        [par_min(ts_ID,:,i_id), par_max(ts_ID,:,i_id), CI_lower(ts_ID,:,i_id), CI_upper(ts_ID,:,i_id), PAR_OPT_T(ts_ID,:,i_id), PAR_TEST_T(ts_ID,:,i_id), rate_names_opt] = getTransformedResults(parameters,theta_test,opt,transformation_str{ts_ID});
                    end
                else
                    load(['WS_',opt_group,'_individual_',individual_ID{i_id}],'parameters','opt','transformation_str');
                    cd(current_dir);
                    for ts_ID=1:length(transformation_str)
                        [par_min(ts_ID,:,i_id), par_max(ts_ID,:,i_id), CI_lower(ts_ID,:,i_id), CI_upper(ts_ID,:,i_id), PAR_OPT_T(ts_ID,:,i_id), ~, rate_names_opt] = getTransformedResults(parameters,[],opt,transformation_str{ts_ID});
                    end
                end
                if i_id==opt.n_individuals
                    cd(['./',opt.foldername,'/',opt.subfoldername,'/',opt.subsubfoldername]);
                    save(['ws_parameters_',opt_group,'.mat'],'par_min','par_max','CI_lower','CI_upper','PAR_OPT_T','PAR_TEST_T','rate_names_opt','rate_names_test','transformation_str','individuals_str');
                    cd(current_dir);
                end

            end
        end
    end
else
    switch opt_RUN
        case 'fit_samples'
            ResultsFolderName = 'results_fit_samples_7divs_3iS_HO_LogNormal_fit_iC';
            path=[current_dir,'/Hematopoiesis_Healthy_MDS_Comparison/Parameter_Inference/'];
        case 'hierarchy_comparison_BIC'
            ResultsFolderName = 'results_topology_comparison_BIC_7divs_3iS_HO_LogNormal_fit_iC';
            path=[current_dir,'/Hematopoiesis_Lineage_Hierarchy_Comparison/Model_Selection/'];
    end

    cd(path)
    group_str = {'healthy','MDS'};

    if bool_fit_repetitions_seperately==true
        add_str_fit_repetitions_seperately = '_rep_sep';
    else
        add_str_fit_repetitions_seperately = '';
    end

    opt_model_str = {'model_A','model_B','model_C','model_D','model_E','model_F','model_G','model_H','model_I','model_J'};
    for g_id = 1:length(group_str)
        individuals_str_simple = sort(getIndividuals(fileName,group_str{g_id},false,bool_fit_repetitions_seperately));
        clearvars PAR_TEST_T theta_test rate_names_test
        for om_id = 1:length(opt_model_str)
            clearvars -except g_id sm_id om_id current_dir group_str sim_model_str opt_model_str...
                              theta_test rate_names_test PAR_TEST_T individuals_str_simple individuals_str...
                              fileName folderName add_str_fit_repetitions_seperately bool_fit_repetitions_seperately
            for i_id = 1:length(individuals_str_simple)
                target_dir = ['./',ResultsFolderName,'/',opt_model_str{om_id},'_model/individual_',individuals_str_simple{i_id}];
                cd(target_dir)
                if om_id==1
                    load(['WS_',group_str{g_id},'_individual_',individuals_str_simple{i_id}],'parameters','opt','transformation_str','theta_test','rate_names_test','rate_names_opt');
                    cd(current_dir);                
                    opt.individuals = individuals_str_simple;
                    opt.n_individuals = length(individuals_str_simple);
                    if (i_id==1)
                        par_min = zeros(length(transformation_str),length(opt.rates(~strwcmp(opt.rates,'x0_*'))),opt.n_individuals);
                        par_max = zeros(length(transformation_str),length(opt.rates(~strwcmp(opt.rates,'x0_*'))),opt.n_individuals);
                        CI_lower = zeros(length(transformation_str),length(opt.rates(~strwcmp(opt.rates,'x0_*'))),opt.n_individuals);
                        CI_upper = zeros(length(transformation_str),length(opt.rates(~strwcmp(opt.rates,'x0_*'))),opt.n_individuals);
                        PAR_OPT_T = zeros(length(transformation_str),length(opt.rates(~strwcmp(opt.rates,'x0_*'))),opt.n_individuals);
                        PAR_TEST_T = zeros(length(transformation_str),length(opt.rates(~strwcmp(opt.rates,'x0_*'))),opt.n_individuals);
                    end

                    for ts_ID=1:length(transformation_str)
                        [par_min(ts_ID,:,i_id), par_max(ts_ID,:,i_id), CI_lower(ts_ID,:,i_id), CI_upper(ts_ID,:,i_id), PAR_OPT_T(ts_ID,:,i_id), PAR_TEST_T(ts_ID,:,i_id), rate_names_opt] = getTransformedResults(parameters,theta_test,opt,transformation_str{ts_ID});
                    end
                else
                    load(['WS_',group_str{g_id},'_individual_',individuals_str{i_id}],'parameters','opt','transformation_str');
                    cd(current_dir);
                    for ts_ID=1:length(transformation_str)
                        [par_min(ts_ID,:,i_id), par_max(ts_ID,:,i_id), CI_lower(ts_ID,:,i_id), CI_upper(ts_ID,:,i_id), PAR_OPT_T(ts_ID,:,i_id), ~, rate_names_opt] = getTransformedResults(parameters,[],opt,transformation_str{ts_ID});
                    end
                end
                if i_id==length(individuals_str_simple)
                    individuals_str = individuals_str_simple;
                    cd(target_dir);
                    save(['ws_parameters_',opt.group,add_str_fit_repetitions_seperately,'.mat'],'par_min','par_max','CI_lower','CI_upper','PAR_OPT_T','PAR_TEST_T','rate_names_opt','rate_names_test','transformation_str','individuals_str');
                    cd(current_dir);
                end

            end
        end
    end
end


% end