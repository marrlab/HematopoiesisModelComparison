function [] = results_main()

clear;
clc;
close all;

%% set and specify paths:


%% (1) Healthy vs MDS comparison:
path_ext = 'Hematopoiesis_Healthy_MDS_Comparison/Parameter_Inference';
f_name{1} = 'results_fit_samples_7divs_3iS_HO_LogNormal_fit_iC';

%% (2) Topology comparison
path_ext = 'Hematopoiesis_Lineage_Hierarchy_Comparison/Model_Selection';
f_name{1} = 'results_hierarchy_comparison_BIC_7divs_3iS_HO_LogNormal_fit_iC';

fileNameData = '2019_07_data.xlsx';
C_dir = cd();
cd('../../')
path = [C_dir,'/HematopoiesisModel/',path_ext];

[opt_paths] = setPaths();
bool_fit_repetitions_seperately=false;
if bool_fit_repetitions_seperately==true
    add_str_fit_repetitions_seperately = '_rep_sep';
else
    add_str_fit_repetitions_seperately = '';
end

f2_name = '';

%% specify Plotting options
option_plot_fits = false;%true;
option_plot_parameter_and_CIs = true;%false;%
option_plot_col4mutations = false;
option_plot_metrics = false;%true;%
option_plot_MultistartResultTable = true;%false;%
opt_parScalePlot = 'lin';%'ratio';%'log10';% for parameter with CIs plot
opt_parPlotCIs = true;%false;
option_plot_PCA = false;%true;

%% specify colors
if option_plot_col4mutations==true
    c_map_groups = [67 119 209;... %Healthy
                    255 153 51;... %SF3B1
                    255 70 51;... %ASXL1
                    153 51 255;... %TET2
                    236 89 4;... %SF3B1 & ASXL1 
                    255 51 153;... %SF3B1 & TET2
                    204 0 102;... %ASXL1 & TET2
                    153 0 0]./255; %all

    MDS.SF3B1_total = 2;
    MDS.ASXL1_total = 2;
    MDS.TET2_total = 1;
    MDS.SF3B1_ASXL1_total = 0;  
    MDS.ASXL1_TET2_total = 0;  
    MDS.SF3B1_TET2_total = 1;  
    MDS.SF3B1_ASXL1_TET2_total = 1;  
else
    c_map_groups = [67 119 209;... %Healthy
                    255 153 51]./255; %MDS
end
%% initialize values
numberOfSamples_H = 0;
samples_H = [];

if option_plot_col4mutations==true
    MDS.SF3B1_counter=0;
    MDS.ASXL1_counter=0;
    MDS.TET2_counter=0;
    MDS.SF3B1_ASXL1_counter=0;
    MDS.SF3B1_TET2_counter=0;
    MDS.ASXL1_TET2_counter=0;
    MDS.SF3B1_ASXL1_TET2_counter=0;
end

AIC_corrected_all = cell(1,length(f_name));
AIC_all = cell(1,length(f_name));
BIC_all = cell(1,length(f_name));
LOGL_all = cell(1,length(f_name));
AIC_corrected = cell(1,length(f_name));
AIC = cell(1,length(f_name));
BIC = cell(1,length(f_name));
LOGL = cell(1,length(f_name));

MS_num = cell(1,length(f_name));

d=dir([path,f_name{1}]); 
isub = [d(:).isdir];
hierarchy_FolderNames = {d(isub).name}';
hierarchy_FolderNames(ismember(hierarchy_FolderNames,{'.','..','figures_meeting'})) = [];
for h_id=1:length(hierarchy_FolderNames)
    for f_id = 1:length(f_name)
        R_PCA = [];
        ResultsPath = [path,f_name{f_id},'/',hierarchy_FolderNames{h_id}];
        if strwcmp(f_name{f_id},'*topology*')   
            group = {'healthy'};
        else
            group = {'healthy','MDS'};
%             group = {'healthy'};
        end
        PAR_OPT_T = cell(length(group),1);
        A_SUM= cell(length(group),1);
        B= cell(length(group),1);
        G= cell(length(group),1);
        
        for g_id = 1:length(group)
            [individuals,~] = getIndividuals(fileNameData,group{g_id},false,bool_fit_repetitions_seperately);     
            opt.individuals = individuals;
            opt.n_individuals = length(individuals);
            i_start = 1;
            i_end = length(individuals);
            if g_id == 1
                 samples_MDS={};
            else
                 samples_MDS = cell(i_end-i_start,1);
            end
            logL_List = zeros(1,i_end);
            group_str = cell(length(individuals),1);
            for i_id = i_start:i_end
                    %load results for current individual
                    [parameters,options_par,opt,data,theta_test,theta_opt,sigma_HO,iS_ID] = getResults(ResultsPath,opt.individuals{i_id},group{g_id},opt);
                    if isempty(parameters)
                        continue;
                    end
                    if i_id == i_start
                        A_SUM{g_id} = zeros(length(opt.modelStates),i_end-i_start+1);
                        B{g_id} = zeros(length(opt.modelStates),i_end-i_start+1);
                        G{g_id} = zeros(length(opt.modelStates),i_end-i_start+1);
                    end
                    opt.timeScale='hours';
                    MS_num{f_id}(h_id,i_id) = calculateSizeLogLPlateau(parameters);
                    opt.individuals = individuals;
                    opt.n_individuals = length(individuals);
%                     if i_id == 1
%                         i_end = opt.n_individuals; 
%                     end
                    %% create table for scores
                    logL_List(i_id) = parameters.MS.logPost(1);
                    group_str{i_id} = group{g_id};
                    if strwcmp(f_name{f_id},'*topology*') && (i_id==i_end)
                        [AIC_all{f_id}(h_id),AIC_corrected_all{f_id}(h_id), BIC_all{f_id}(h_id),LOGL_all{f_id}(h_id)] = getModelSelectionScores(parameters.number,logL_List,opt,options_par.obj_type,opt.individuals,[],'all',group_str);
                    end
                    [AIC{f_id}(h_id,i_id),AIC_corrected{f_id}(h_id,i_id), BIC{f_id}(h_id,i_id),LOGL{f_id}(h_id,i_id)] = getModelSelectionScores(parameters.number,parameters.MS.logPost(1),opt,options_par.obj_type,opt.individuals,i_id,'single',group_str{i_id});
                    %% plot Fits
                    if (option_plot_fits == true)
                        n_states = length(opt.modelStates);
                        opt.save = true;
                        opt.foldername = [f2_name,f_name{f_id}];
                        opt.plotResults = true;
                        %% make sure simulation files are up-to-date
                        if (g_id==1 && i_id == 1)
                            createSimulationFile(opt,true,opt.model,iS_ID)
                            if ~isempty(theta_test)
                                createSimulationFile(opt,true,opt.model_sim,iS_ID)
                            end
                        end
                        opt.dataType = 'log2TotalNumbers';
                        opt.plotCompartmentSum = true;
                        plotResults(theta_test,theta_opt,data,opt,n_states,opt.individuals{i_id},sigma_HO,true)
                        opt.plotCompartmentSum = false;
                        plotResults(theta_test,theta_opt,data,opt,n_states,opt.individuals{i_id},sigma_HO,true)
                    end
                    
                    %% store results for PCA:
                    if (option_plot_PCA == true)
                        if g_id==1 && i_id == i_start
                            cd(path);
                            load('Data.mat'); % is up-to-date as getIndividuals() is called earlier in results_main.m
                        end
                        [R_PCA,colnames] = addPatientData2PCAresultMatrix(R_PCA,opt,DataTable,i_id,parameters);
                    end
                    
                     %% plot parameter and CI result, store values
                    if option_plot_parameter_and_CIs == true
                        [par_min, par_max, CI_lower, CI_upper, PAR_OPT_T{g_id}(:,i_id), rate_names] = getTransformedResults(parameters,opt,opt_parScalePlot,i_id,i_start,i_end,g_id);
                        
                        if option_plot_col4mutations==true
                            %specify color for mutation subgroup
                            [MDS,col_id,offset] = getColorIdForMutation(data,MDS);
                        else
                            if g_id ==1
                                col_id = 1;
                                offset = 0;
                            else
                                col_id = 2;
                                offset = offset+1;
                            end
                        end
                        
                        %figure
                        m_rows=length(opt.modelStates);
                        P_ID_vec = zeros(1,length(opt.modelStates));
                        m_cols=6;
                        id_plot=1;
                        if g_id == 1
                            numberOfSamples_H = opt.n_individuals;
                            samples_H = opt.individuals;
                        end
                        figure(101)
                        for id_par = 1:length(PAR_OPT_T{g_id}(:,i_id))
                           CT_ID = find(strcmp(opt.modelStates,rate_names{id_par}(4:6)));
                           switch rate_names{id_par}(1)
                               case 'a'
                                   P_ID_vec(CT_ID) = P_ID_vec(CT_ID)+1;
                                   subplot(m_rows,m_cols,(CT_ID-1)*m_cols+P_ID_vec(CT_ID))
                                   %sum of all differentiation rates per
                                   %group, individual and cell type
                                   A_SUM{g_id}(CT_ID,i_id) = A_SUM{g_id}(CT_ID,i_id)+PAR_OPT_T{g_id}(id_par,i_id);
                               case 'b'
                                   subplot(m_rows,m_cols,(CT_ID-1)*m_cols+4)
                                   B{g_id}(CT_ID,i_id) = B{g_id}(CT_ID,i_id)+PAR_OPT_T{g_id}(id_par,i_id);
                               case 'g'
                                   subplot(m_rows,m_cols,(CT_ID-1)*m_cols+5)
                                   G{g_id}(CT_ID,i_id) = G{g_id}(CT_ID,i_id)+PAR_OPT_T{g_id}(id_par,i_id);
                           end
                           if col_id ==1 %no SF3B1, no ASXL1, no TET2
                               if opt_parPlotCIs==true
                                    rectangle('Position',[i_id-0.25/2, CI_lower(id_par), 0.25, CI_upper(id_par)-CI_lower(id_par)],'FaceColor',[1 1 1],'EdgeColor',c_map_groups(col_id,:));
                                    hold on;  
                               end
                               plot(i_id,PAR_OPT_T{g_id}(id_par,i_id),'*','Color',c_map_groups(col_id,:));
                               hold on;
                           else
                               if opt_parPlotCIs==true
                                    rectangle('Position',[numberOfSamples_H+offset-0.25/2, CI_lower(id_par), 0.25, CI_upper(id_par)-CI_lower(id_par)],'FaceColor',[1 1 1],'EdgeColor',c_map_groups(col_id,:));
                                    hold on; 
                               end
                               plot(numberOfSamples_H+offset,PAR_OPT_T{g_id}(id_par,i_id),'*','Color',c_map_groups(col_id,:));
                               samples_MDS{offset}=opt.individuals{i_id};
                               hold on; 
                           end
                           switch opt_parScalePlot
                            case 'lin'
                                ylabel(rate_names{id_par});
                            case 'log10'
                                ylabel(['log_{10}(',rate_names{id_par},')']);
                            case 'ratio'
                                ylabel(['1/',rate_names{id_par}]);
                           end
                           if strcmp(opt_parScalePlot,'log10')
                                ylim([par_min(id_par) par_max(id_par)]);
                           end
                           xlim([0,opt.n_individuals+numberOfSamples_H+1]);
                           if g_id==length(group) && i_id==i_end
                               if length(group)==2
                                    xticks(1:numberOfSamples_H+opt.n_individuals);
                               else
                                    xticks(1:numberOfSamples_H);
                               end
                               xtickangle(45)
                               xticklabels([samples_H;samples_MDS]);
                           end
                           id_plot = id_plot+1;
                           hold on;
                        end
                    end
            end
            if (option_plot_parameter_and_CIs == true) && (g_id == length(group))
                table(opt.rates(~strwcmp(opt.rates,'x0_*'))',PAR_OPT_T{1}(:,1),PAR_OPT_T{1}(:,2),PAR_OPT_T{1}(:,3),PAR_OPT_T{1}(:,4),PAR_OPT_T{1}(:,5),PAR_OPT_T{1}(:,6))
                opt.foldername = f_name{f_id};
                if ~strwcmp(f_name{f_id},'*topology*')   
                    opt.subfoldername=[];
                else
                    opt.subsubfoldername=[];
                end
                cd(C_dir);
                opt.c_path = opt_paths.c_path;
                saveFigures(opt,true,strcat('resultingParsAndCIs_',opt_parScalePlot));
                if strcmp(opt_parScalePlot,'lin')
                    cd([f_name{f_id},'/',hierarchy_FolderNames{h_id}])
                    save(['WS_linear_parameters',add_str_fit_repetitions_seperately,'.mat'],'PAR_OPT_T','A_SUM','B','G','samples_H','samples_MDS','c_map_groups','group','opt','ResultsPath')
                    cd(C_dir)
                end
            end
            if (option_plot_MultistartResultTable==true) && h_id==length(hierarchy_FolderNames)
                %MS (optimization result) table (models vs individuals)
                plotTable(MS_num{f_id}(:,1:length(opt.individuals)),hierarchy_FolderNames,[],'arbitrary','% of MSs which lie within 5%-deviation-from-best-logL-value-range',opt.individuals,opt.individuals);
                opt2=opt;
                opt2.foldername = f_name{f_id};
                opt2.subfoldername=[];
                opt2.subsubfoldername=[];
                saveFigures(opt2,true,strcat('MultiStartResult_allIndividuals_allHierarchies_',group{g_id}));
            end
        end
        %% Metrics of parameter result
        if option_plot_metrics
            cd([f_name{f_id},'/',hierarchy_FolderNames{h_id}])
            load(['WS_linear_parameters',add_str_fit_repetitions_seperately,'.mat'],'PAR_OPT_T','A_SUM','B','G','samples_H','samples_MDS','c_map_groups','group','opt','ResultsPath')
            cd(C_dir)
            plot_metrics(A_SUM,B,G,samples_H,samples_MDS,'log effective proliferation',c_map_groups,group,opt,ResultsPath,MDS)
            saveFigures(opt,true,strcat('Metric4resultingLinPars_log_effective_proliferation'));
            plot_metrics(A_SUM,B,G,samples_H,samples_MDS,'net proliferation',c_map_groups,group,opt,ResultsPath,MDS)
            saveFigures(opt,true,strcat('Metric4resultingLinPars_net_proliferation'));
%             plot_metrics(A_SUM,B,G,samples_H,samples_MDS,'cellular exit time',c_map_groups,group,opt,ResultsPath,MDS)
%             saveFigures(opt,true,strcat('Metric4resultingLinPars_cellular_exit_time'));
        end
        %% PCA
        %variables: sample_nr, resulting parameter values without initial condition values, age, sex (0: male, 1: female), mutations (SF3B1, TET2, ASXL1, WT) (0: no, 1: yes)
        %colnames, R
        %missing values: setting: 'Rows'='pairwise'
        %sex and age has many missing vaues --> leave them out
        if option_plot_PCA == true
            X=R_PCA(:,2:end-5);
            [coeff,score,latent,tsquared,explained,mu] = pca(X,'Algorithm','als','NumComponents',3);
            dimensions = 2;
            plot_PCA_Result(score,R_PCA,colnames,c_map_groups,dimensions);
%             table(opt.rates(~strwcmp(opt.rates,'x0_*'))',coeff)
            opt.foldername = f_name{f_id};
            if ~strwcmp(f_name{f_id},'*topology*')   
                opt.subfoldername=[];
            else
                opt.subsubfoldername=[];
            end
            saveFigures(opt,true,strcat(['resultingPCA_',num2str(dimensions),'D']));
        end
        if h_id == length(hierarchy_FolderNames)
            opt.subsubfoldername=[];
            opt.subfoldername=[];
            %model selection score tables (models vs individuals)
            cd(opt.foldername);
            BIC_mat = BIC{f_id};
            AIC_mat = AIC{f_id};
            AIC_corrected_mat = AIC_corrected{f_id};
            LOGL_mat = LOGL{f_id};
            if strwcmp(f_name{f_id},'*topology*')
                BIC_all_mat = BIC_all{f_id};
                AIC_all_mat = AIC_all{f_id};
                AIC_corrected_all_mat = AIC_corrected_all{f_id};
                LOGL_all_mat = LOGL_all{f_id};
                save(['ws_scores',add_str_fit_repetitions_seperately,'.mat'],'BIC_mat','AIC_mat','AIC_corrected_mat','LOGL_mat','BIC_all_mat','AIC_all_mat','AIC_corrected_all_mat','LOGL_all_mat');
            else
                save(['ws_scores',add_str_fit_repetitions_seperately,'.mat'],'BIC_mat','AIC_mat','AIC_corrected_mat','LOGL_mat');
            end
            cd(C_dir);
            plotTable(AIC{f_id},hierarchy_FolderNames,[],'criterion_individuals','AIC values and difference to min(AIC)',opt.individuals,opt.individuals);
            saveFigures(opt,true,strcat('ModelComparisonResult_allIndividuals_AIC'));
            plotTable(AIC_corrected{f_id},hierarchy_FolderNames,[],'criterion_individuals','AIC_corr values and difference to min(AIC_corr)',opt.individuals,opt.individuals);
            saveFigures(opt,true,strcat('ModelComparisonResult_allIndividuals_AIC_corr'));
            plotTable(BIC{f_id},hierarchy_FolderNames,[],'criterion_individuals','BIC values and difference to min(BIC)',opt.individuals,opt.individuals);
            saveFigures(opt,true,strcat('ModelComparisonResult_allIndividuals_BIC'));

            if strwcmp(f_name{f_id},'*topology*')   
                %AIC, AIC_corrected, BIC for all individuals together
                cnames={'AIC','AIC_c','BIC'};
                cnames2={'AIC-min(AIC)','AIC_c-min(AIC_c)','BIC-min(BIC)'};
                plotTable([AIC_all{f_id}',AIC_corrected_all{f_id}',BIC_all{f_id}'],hierarchy_FolderNames,[],'criterion_all','lineage hierarchy comparison',cnames,cnames2);
                opt.foldername = f_name{f_id};
                opt.subsubfoldername=[];
                opt.subfoldername=[];
                saveFigures(opt,true,strcat('ModelComparisonResult'));
            end
        end
    end
end

end

function [] = plot_PCA_Result(score,R_PCA,colnames,c_map_groups,dimensions)
    IDX_SF3B1 = R_PCA(:,strwcmp(colnames,'SF3B1*')==1);
    IDX_ASXL1 = R_PCA(:,strwcmp(colnames,'ASXL1*')==1);
    IDX_TET2 = R_PCA(:,strwcmp(colnames,'TET2*')==1);
    
    IDX_group1 = (IDX_SF3B1+IDX_ASXL1+IDX_TET2)==0; %healthy
    IDX_group2 = (IDX_SF3B1==1 & IDX_ASXL1==0 & IDX_TET2==0); %SF3B1 only 
    IDX_group3 = (IDX_ASXL1==1 & IDX_SF3B1==0 & IDX_TET2==0); %ASXL1 only
    IDX_group4 = (IDX_ASXL1==0 & IDX_SF3B1==0 & IDX_TET2==1); %TET2 only
    IDX_group5 = (IDX_ASXL1==1 & IDX_SF3B1==1 & IDX_TET2==0); %SF3B1 and ASXL1
    IDX_group6 = (IDX_ASXL1==0 & IDX_SF3B1==1 & IDX_TET2==1); %SF3B1 and TET2
    IDX_group7 = (IDX_ASXL1==1 & IDX_SF3B1==0 & IDX_TET2==1); % ASXL1 and TET2
    IDX_group8 = (IDX_SF3B1+IDX_ASXL1+IDX_TET2)==3; %all 3 mutations

    MS=30;
    figure('Name','PCA Result','NumberTitle','off','Position',[0.1,0.1,1000,600]); 
    if dimensions==3
        h1 = scatter3(score(IDX_group1,1),score(IDX_group1,2),score(IDX_group1,3),MS,repmat(c_map_groups(1,:),numel(score(IDX_group1,1)),1),'filled');
        hold on;
        h2 = scatter3(score(IDX_group2 ,1),score(IDX_group2 ,2),score(IDX_group2,3),MS,repmat(c_map_groups(2,:),numel(score(IDX_group2,1)),1),'filled');
        hold on;
        h3 = scatter3(score(IDX_group3,1),score(IDX_group3,2),score(IDX_group3,3),MS,repmat(c_map_groups(3,:),numel(score(IDX_group3,1)),1),'filled');
        hold on;
        h4 = scatter3(score(IDX_group4 ,1),score(IDX_group4 ,2),score(IDX_group4,3),MS,repmat(c_map_groups(4,:),numel(score(IDX_group4,1)),1),'filled');
        hold on;
        h5 = scatter3(score(IDX_group5 ,1),score(IDX_group5 ,2),score(IDX_group5,3),MS,repmat(c_map_groups(5,:),numel(score(IDX_group5,1)),1),'filled');
        hold on;
        h6 = scatter3(score(IDX_group6 ,1),score(IDX_group6 ,2),score(IDX_group6,3),MS,repmat(c_map_groups(6,:),numel(score(IDX_group6,1)),1),'filled');
        hold on;
        h7 = scatter3(score(IDX_group7 ,1),score(IDX_group7 ,2),score(IDX_group7,3),MS,repmat(c_map_groups(7,:),numel(score(IDX_group7,1)),1),'filled');
        hold on;
        h8 = scatter3(score(IDX_group8 ,1),score(IDX_group8 ,2),score(IDX_group8,3),MS,repmat(c_map_groups(8,:),numel(score(IDX_group8,1)),1),'filled');
        hold on;
    else
        h1 = scatter(score(IDX_group1,1),score(IDX_group1,2),MS,repmat(c_map_groups(1,:),numel(score(IDX_group1,1)),1),'filled');
        hold on;
        h2 = scatter(score(IDX_group2 ,1),score(IDX_group2 ,2),MS,repmat(c_map_groups(2,:),numel(score(IDX_group2,1)),1),'filled');
        hold on;
        h3 = scatter(score(IDX_group3,1),score(IDX_group3,2),MS,repmat(c_map_groups(3,:),numel(score(IDX_group3,1)),1),'filled');
        hold on;
        h4 = scatter(score(IDX_group4 ,1),score(IDX_group4 ,2),MS,repmat(c_map_groups(4,:),numel(score(IDX_group4,1)),1),'filled');
        hold on;
        h5 = scatter(score(IDX_group5 ,1),score(IDX_group5 ,2),MS,repmat(c_map_groups(5,:),numel(score(IDX_group5,1)),1),'filled');
        hold on;
        h6 = scatter(score(IDX_group6 ,1),score(IDX_group6 ,2),MS,repmat(c_map_groups(6,:),numel(score(IDX_group6,1)),1),'filled');
        hold on;
        h7 = scatter(score(IDX_group7 ,1),score(IDX_group7 ,2),MS,repmat(c_map_groups(7,:),numel(score(IDX_group7,1)),1),'filled');
        hold on;
        h8 = scatter(score(IDX_group8 ,1),score(IDX_group8 ,2),MS,repmat(c_map_groups(8,:),numel(score(IDX_group8,1)),1),'filled');
        hold on;
    end
    c1 = cellstr(num2str(R_PCA(IDX_group1,1)));
    c2 = cellstr(num2str(R_PCA(IDX_group2,1)));
    c3 = cellstr(num2str(R_PCA(IDX_group3,1)));
    c4 = cellstr(num2str(R_PCA(IDX_group4,1)));
    c5 = cellstr(num2str(R_PCA(IDX_group5,1)));
    c6 = cellstr(num2str(R_PCA(IDX_group6,1)));
    c7 = cellstr(num2str(R_PCA(IDX_group7,1)));
    c8 = cellstr(num2str(R_PCA(IDX_group8,1)));
    % displacement so the text does not overlay the data points
    if dimensions==3
        dx = (max(score(:,1))-min(score(:,1)))/50; 
        dy = (max(score(:,2))-min(score(:,2)))/50; 
        dz = (max(score(:,3))-min(score(:,3)))/50;
        text(score(IDX_group1,1)+dx, score(IDX_group1,2)+dy, score(IDX_group1,3)+dz, c1);
        hold on;
        text(score(IDX_group2,1)+dx, score(IDX_group2,2)+dy, score(IDX_group2,3)+dz, c2);
        hold on;
        text(score(IDX_group3,1)+dx, score(IDX_group3,2)+dy, score(IDX_group3,3)+dz, c3);
        hold on;
        text(score(IDX_group4,1)+dx, score(IDX_group4,2)+dy, score(IDX_group4,3)+dz, c4);
        zlabel('3rd PC')
        text(score(IDX_group5,1)+dx, score(IDX_group5,2)+dy, score(IDX_group5,3)+dz, c5);
        zlabel('3rd PC')
        text(score(IDX_group6,1)+dx, score(IDX_group6,2)+dy, score(IDX_group6,3)+dz, c6);
        zlabel('3rd PC')
        text(score(IDX_group7,1)+dx, score(IDX_group7,2)+dy, score(IDX_group7,3)+dz, c7);
        zlabel('3rd PC')
        text(score(IDX_group8,1)+dx, score(IDX_group8,2)+dy, score(IDX_group8,3)+dz, c8);
        zlabel('3rd PC')
    else
        dx = (max(score(:,1))-min(score(:,1)))/100; 
        dy = (max(score(:,2))-min(score(:,2)))/100; 
        text(score(IDX_group1,1)+dx, score(IDX_group1,2)+dy, c1);
        hold on;
        text(score(IDX_group2,1)+dx, score(IDX_group2,2)+dy, c2);
        hold on;
        text(score(IDX_group3,1)+dx, score(IDX_group3,2)+dy, c3);
        hold on;
        text(score(IDX_group4,1)+dx, score(IDX_group4,2)+dy, c4);
        hold on;
        text(score(IDX_group5,1)+dx, score(IDX_group5,2)+dy, c5);
        hold on;
        text(score(IDX_group6,1)+dx, score(IDX_group6,2)+dy, c6);
        hold on;
        text(score(IDX_group7,1)+dx, score(IDX_group7,2)+dy, c7);
        hold on;
        text(score(IDX_group8,1)+dx, score(IDX_group8,2)+dy, c8);
    end
    axis equal
    xlabel('1st PC')
    ylabel('2nd PC')
    legend([h1 h2 h3 h4 h5 h6 h7 h8],{'WT','SF3B1','ASXL1','TET2','SF3B1 and ASXL1','SF3B1 and TET2','ASXL1 and TET2','SF3B1 and ASXL1 and TET2'})
    grid on;
end

function [percentage] = calculateSizeLogLPlateau(parameters)
    %calculates percentage of MSs which lie within 5%-deviation-from-best-logL-value-range
    percentage = 100*(sum(abs(parameters.MS.logPost-parameters.MS.logPost(1))<=0.05*abs(parameters.MS.logPost(1))))/length(parameters.MS.logPost);
end

function [MDS,col_id,offset] = getColorIdForMutation(data,MDS)
    MDS.id_SF3B1 = find(strcmp(data.mutations_str,'SF3B1'));
    MDS.id_ASXL1 = find(strcmp(data.mutations_str,'ASXL1'));
    MDS.id_TET2 = find(strcmp(data.mutations_str,'TET2'));
    if (~data.mutations{1,1}(1,MDS.id_SF3B1) && ~data.mutations{1,1}(1,MDS.id_ASXL1) && ~data.mutations{1,1}(1,MDS.id_TET2))
        col_id = 1;
        offset = 0;
    elseif (data.mutations{1,1}(1,MDS.id_SF3B1) && ~data.mutations{1,1}(1,MDS.id_ASXL1) && ~data.mutations{1,1}(1,MDS.id_TET2))
        col_id = 2;
        MDS.SF3B1_counter = MDS.SF3B1_counter+1;
        offset = MDS.SF3B1_counter;
    elseif (~data.mutations{1,1}(1,MDS.id_SF3B1) && data.mutations{1,1}(1,MDS.id_ASXL1) && ~data.mutations{1,1}(1,MDS.id_TET2))
        col_id = 3;
        MDS.ASXL1_counter = MDS.ASXL1_counter+1;
        offset = MDS.SF3B1_total+MDS.ASXL1_counter;
    elseif (~data.mutations{1,1}(1,MDS.id_SF3B1) && ~data.mutations{1,1}(1,MDS.id_ASXL1) && data.mutations{1,1}(1,MDS.id_TET2))
        col_id = 4;
        MDS.TET2_counter = MDS.TET2_counter+1;
        offset = MDS.SF3B1_total+MDS.ASXL1_total+MDS.TET2_counter;
    elseif (data.mutations{1,1}(1,MDS.id_SF3B1) && data.mutations{1,1}(1,MDS.id_ASXL1) && ~data.mutations{1,1}(1,MDS.id_TET2))
        col_id = 5;
        MDS.SF3B1_ASXL1_counter = MDS.SF3B1_ASXL1_counter+1;
        offset = MDS.SF3B1_total+MDS.ASXL1_total+MDS.TET2_total+MDS.SF3B1_ASXL1_counter;
    elseif (data.mutations{1,1}(1,MDS.id_SF3B1) && ~data.mutations{1,1}(1,MDS.id_ASXL1) && data.mutations{1,1}(1,MDS.id_TET2))
        col_id = 6;
        MDS.SF3B1_TET2_counter = MDS.SF3B1_TET2_counter+1;
        offset = MDS.SF3B1_total+MDS.ASXL1_total+MDS.TET2_total+MDS.SF3B1_ASXL1_total+MDS.SF3B1_TET2_counter;
    elseif (~data.mutations{1,1}(1,MDS.id_SF3B1) && data.mutations{1,1}(1,MDS.id_ASXL1) && data.mutations{1,1}(1,MDS.id_TET2))
        col_id = 7;
        MDS.ASXL1_TET2_counter = MDS.ASXL1_TET2_counter+1;
        offset = MDS.SF3B1_total+MDS.ASXL1_total+MDS.TET2_total+MDS.SF3B1_ASXL1_total+MDS.SF3B1_TET2_total+MDS.ASXL1_TET2_counter;
    else
        col_id = 8;
        MDS.SF3B1_ASXL1_TET2_counter = MDS.SF3B1_ASXL1_TET2_counter+1;
        offset = MDS.SF3B1_total+MDS.ASXL1_total+MDS.TET2_total+MDS.SF3B1_ASXL1_total+MDS.SF3B1_TET2_total+MDS.ASXL1_TET2_total+MDS.SF3B1_ASXL1_TET2_counter;
    end
end
                        
function [par_min, par_max, CI_lower, CI_upper, PAR_OPT, rate_names] = getTransformedResults(parameters,opt,opt_parScalePlot,i_id,i_start,i_end,g_id)
    if opt.PLcalculation
        CI_lower = parameters.CI.PL(:,1,parameters.CI.alpha_levels==0.95);
        CI_upper = parameters.CI.PL(:,2,parameters.CI.alpha_levels==0.95);
    else
        CI_lower = parameters.CI.local_PL(:,1,parameters.CI.alpha_levels==0.95);
        CI_upper = parameters.CI.local_PL(:,2,parameters.CI.alpha_levels==0.95);
    end
    if ~strcmp(opt.parScale,'none')
       par_opt_lin = transformParBack(parameters.MS.par(:,1),opt);
       ci_lower=transformParBack(CI_lower,opt);
       ci_upper=transformParBack(CI_upper,opt);
       parameters_min=transformParBack(parameters.min,opt);
       parameters_max=transformParBack(parameters.max,opt);
    else
       par_opt_lin = parameters.MS.par(:,1);
       parameters_min=parameters.min;
       parameters_max=parameters.max;
    end
    if i_id == i_start
        PAR_OPT_T{g_id}=zeros(length(opt.rates(~strwcmp(opt.rates,'x0_*'))),i_end);
    end
    switch opt_parScalePlot
        case 'lin'
            par_min = parameters_min(~strwcmp(opt.rates,'x0_*'));
            par_max = parameters_max(~strwcmp(opt.rates,'x0_*'));
            CI_upper = min(parameters_max(~strwcmp(opt.rates,'x0_*')),ci_upper(~strwcmp(opt.rates,'x0_*')));
            CI_lower = max(parameters_min(~strwcmp(opt.rates,'x0_*')),ci_lower(~strwcmp(opt.rates,'x0_*')));
            PAR_OPT = par_opt_lin(~strwcmp(opt.rates,'x0_*'));
        case 'log10'
            par_min = log10(parameters_min(~strwcmp(opt.rates,'x0_*')));
            par_max = log10(parameters_max(~strwcmp(opt.rates,'x0_*')));
            CI_upper = log10(min(parameters_max(~strwcmp(opt.rates,'x0_*')),ci_upper(~strwcmp(opt.rates,'x0_*'))));
            CI_lower = log10(max(parameters_min(~strwcmp(opt.rates,'x0_*')),ci_lower(~strwcmp(opt.rates,'x0_*'))));
            PAR_OPT = log10(par_opt_lin(~strwcmp(opt.rates,'x0_*')));
        case 'ratio'
            par_min=1./parameters_max(~strwcmp(opt.rates,'x0_*'));
            par_max=1./parameters_min(~strwcmp(opt.rates,'x0_*'));
            CI_upper = 1./max(parameters_min(~strwcmp(opt.rates,'x0_*')),ci_lower(~strwcmp(opt.rates,'x0_*')));
            CI_lower = 1./min(parameters_max(~strwcmp(opt.rates,'x0_*')),ci_upper(~strwcmp(opt.rates,'x0_*')));
            PAR_OPT = 1./par_opt_lin(~strwcmp(opt.rates,'x0_*'));
        otherwise
            error('the required setting for opt_parScalePlot is not implemented!')
    end   
    rate_names=strtrim(opt.rates(~strwcmp(opt.rates,'x0_*')));
end

function [] = plot_metrics(A_SUM,B,G,samples_H,samples_MDS,opt_metric,c_map_groups,group,opt,ResultsPath,MDS)
    MDS.SF3B1_counter=0;
    MDS.ASXL1_counter=0;
    MDS.TET2_counter=0;
    MDS.SF3B1_ASXL1_counter=0;
    MDS.SF3B1_TET2_counter=0;
    MDS.ASXL1_TET2_counter=0;
    MDS.SF3B1_ASXL1_TET2_counter=0;                 
    numberOfSamples_H = length(samples_H);
    figure(111)
    for g_id=1:size(B,1)
        switch opt_metric
            case 'log effective proliferation'
                M{g_id}=log(B{g_id}./G{g_id});
            case 'net proliferation'
                M{g_id}=B{g_id}-G{g_id};
            case 'cellular exit time'
                M{g_id}=1./(A_SUM{g_id}-(B{g_id}-G{g_id}));
        end
        for i_id = 1:size(B{g_id},2)
            if g_id==1
                [~,~,~,data,~,~,~,~] = getResults(ResultsPath,samples_H{i_id},group{g_id});
            else
                [~,~,~,data,~,~,~,~] = getResults(ResultsPath,samples_MDS{i_id},group{g_id});
            end
            %specify color and offset for mutation subgroup
            [MDS,col_id,offset] = getColorIdForMutation(data,MDS);
            for c_id=1:size(B{g_id},1)
                subplot(size(B{g_id},1),1,c_id)
                if col_id ==1 %no SF3B1, no ASXL1, no TET2
                    plot(i_id,M{g_id}(c_id,i_id),'*','Color',c_map_groups(col_id,:));
                    hold on;
                else
                    plot(numberOfSamples_H+offset,M{g_id}(c_id,i_id),'*','Color',c_map_groups(col_id,:));
                    hold on; 
                end
                if i_id == size(B{g_id},2) && g_id==size(B,1)
                    switch opt_metric
                        case 'log effective proliferation'
                            plot([0,opt.n_individuals+numberOfSamples_H+1],[0 0],'k--')
                        case 'net proliferation'
                            plot([0,opt.n_individuals+numberOfSamples_H+1],[0 0],'k--')
                    end
                end
                xlim([0,opt.n_individuals+numberOfSamples_H+1]);
                if g_id==length(group) && i_id==size(B{g_id},2)
                   if length(group)==2
                        xticks(1:numberOfSamples_H+opt.n_individuals);
                   else
                        xticks(1:numberOfSamples_H);
                   end
                   xtickangle(45)
                   xticklabels([samples_H;samples_MDS]);
                end
                hold on;
                ylabel(opt.modelStates{c_id})
                if c_id==size(B{g_id},1)
                    xlabel('individuals')
                end
                if c_id==1 && g_id==size(B,1)
                    title(opt_metric)
                end
            end
        end
    end
end

function [] = plotTable(X,modelNames,model_comparison_pairs,opt,title_str,cnames,cnames2)

    format short;
    X= round(X*10)/10;
    switch opt
         case 'criterion_individuals'
            idx=[];
            for i=1:size(X,2)
                idx=[idx; repmat(i,length(find(X==min(X(:,i)))),1) ,find(X==min(X(:,i)))];
            end
            XX = reshape(strtrim(cellstr(num2str(X(:)))), size(X));

            rnames=modelNames;
            X2 = X-min(X);

            XX2 = reshape(strtrim(cellstr(num2str(X2(:)))), size(X2));
            idx2=find(X2<10);

            % # use HTML to style these cells
            for i=1:size(idx,1)
                XX(idx(i,2)) = strcat(...
                    '<html><span style="color: #FF0000; font-weight: bold;">', ...
                    XX(idx(i,2)), ...
                    '</span></html>');
            end
            for i=1:size(idx2,1)
                XX2(idx2(i)) = strcat(...
                    '<html><span style="color: #FF0000; font-weight: bold;">', ...
                    XX2(idx2(i)), ...
                    '</span></html>');
            end
        case 'criterion_all'
            XX = reshape(strtrim(cellstr(num2str(X(:)))), size(X));
            idx=[];
            for i=1:size(X,2)
                idx=[idx; repmat(i,length(find(X==min(X(:,i)))),1) ,find(X==min(X(:,i)))];
            end

            rnames=modelNames;
            X2 = X-min(X);
            XX2 = reshape(strtrim(cellstr(num2str(X2(:)))), size(X2));
            idx2=find(X2<10);
            % # use HTML to style these cells
            % # use HTML to style these cells
            for i=1:size(idx,1)
                XX(idx(i,2)) = strcat(...
                    '<html><span style="color: #FF0000; font-weight: bold;">', ...
                    XX(idx(i,2)), ...
                    '</span></html>');
            end
            for i=1:size(idx2,1)
                XX2(idx2(i)) = strcat(...
                    '<html><span style="color: #FF0000; font-weight: bold;">', ...
                    XX2(idx2(i)), ...
                    '</span></html>');
            end
        case 'lrtest'
            for j=1:size(model_comparison_pairs,1)
                i1=model_comparison_pairs(j,1);
                i2=model_comparison_pairs(j,2);
                cnames{j}=strcat(modelNames{i1},' vs. ',modelNames{i2});
            end
            X=X.pVal;
            idx=(X<0.05);
            XX = reshape(strtrim(cellstr(num2str(X(:)))), size(X));
            % # use HTML to style these cells
            XX(idx) = strcat(...
                '<html><span style="color: #FF0000; font-weight: bold;">', ...
                XX(idx), ...
                '</span></html>');
            rnames=strcat(modelNames,'_data');
        otherwise
            idx=(X<5);
            XX = reshape(strtrim(cellstr(num2str(X(:)))), size(X));
            % # use HTML to style these cells
    %         XX(idx) = strcat(...
    %             '<html><span style="color: #FF0000; font-weight: bold;">', ...
    %             XX(idx), ...
    %             '</span></html>');
            rnames=modelNames;
    end


    f=figure('Name',title_str,'NumberTitle','off','Position',[0.1,0.1,1000,600]);
    parentPosition = get(f, 'position');
    uitablePosition = [0.05 0.7 0.95 0.95];
    % # create table
    % title(title_str);
    h = uitable(f,'Units','normalized', 'position',uitablePosition,...
        'ColumnName',cnames, 'RowName',rnames, 'ColumnWidth','auto','FontSize',16);
    h.Position(3:4) = [0.9 0.3];
    %# set table data
    set(h, 'Data',XX)

    if strwcmp(opt,'criterion_*')
        uitablePosition = [0.05 0.3 parentPosition(3)-1 parentPosition(4)-1];
        % # create table
        % title(title_str);
        h = uitable(f,'Units','normalized', 'position',uitablePosition,...
            'ColumnName',cnames2, 'RowName',rnames, 'ColumnWidth','auto','FontSize',16);
        h.Position(3:4) = [0.9 0.3];
        %# set table data
        set(h, 'Data',XX2)
    end

end

function [parameters,options_par,opt,data,theta_test,theta_opt,sigma_HO,iS_ID] = getResults(ResultsPath,sample_nr,group,opt)

    parameters = [];
    options_par = [];
    data = [];
    theta_test = [];
    theta_opt = [];
    sigma_HO = [];
    iS_ID = [];

    cDir = cd();
    %results Path:
    path = [ResultsPath,'/individual_',sample_nr];
    if ~isempty(path) && ~(exist(path, 'dir')==0) 
        cd(path)
        if ~(exist(['WS_',group,'_individual_',sample_nr,'.mat'], 'file')==0) 
            load(['WS_',group,'_individual_',sample_nr,'.mat'])
            switch opt.optimizationMode
                case 'hierarchical'
                    cd([ResultsPath,'/individual_',sample_nr]);
                    load('analytical_results.mat');
                    if length(size(noise))==4
                        sigma_HO = [];
                        for i=1:size(noise,4)%noise: 1 x n_observables x 1 x repetition*replicates
                            sigma_HO = [sigma_HO;noise(1,:,1,i)];%sigma_HO: repetition*replicates x n_observables 
                        end
                    else
                        sigma_HO = noise;
                    end
                case 'standard'
                    sigma_HO = [];
            end
            theta_opt = parameters.MS.par(:,1);
        end
            cd(cDir)
        %% update paths for plotting results
        opt.c_path = '/Users/lisa.bast/Documents/MATLAB_WD/class_1/HematopoiesisModel';
        opt.a_path = '/Users/lisa.bast/Documents/MATLAB_WD/class_1/Tools/AMICI-master/matlab/examples';
        opt.resultsPath = ResultsPath;
    end

end