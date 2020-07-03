function [P_test,rates_test_str] = loadTestPar(opt,option,model)
c_dir = cd();

switch opt.RUN
    case 'hierarchy_comparison_BIC'
        path = [c_dir,'/results_hierarchy_comparison_BIC_'];
    otherwise
        path = [c_dir,'/results_fit_samples_'];
end

HO_str = '';
if strwcmp(opt.optimizationMode,'hierarchical')
    HO_str = '_HO';
end
path = [path,num2str(opt.n_divStates),'divs_',num2str(opt.n_intermediateStates(opt.iS_ID)),'iS',HO_str,'_',opt.noiseType];

if opt.fitInitialConds && ~strwcmp(path,'*_fit_iC*')
   path = [path,'_fit_iC'];  
end
path = [path,'/',model,'_model'];


rates_test_str = {'b_{HSC}','b_{MPP}','b_{MLP}','b_{CMP}','b_{GMP}','b_{MEP}','b_{mat}','g_{HSC}','g_{MPP}','g_{CMP}','g_{GMP}','g_{MEP}','g_{mat}','a_{HSC_{MPP}}','a_{HSC_{CMP}}','a_{HSC_{MEP}}','a_{HSC_{mat}}','a_{MPP_{MLP}}','a_{MPP_{MEP}}','a_{MPP_{CMP}}','a_{MPP_{GMP}}','a_{MLP}','a_{MLP_{GMP}}','a_{CMP_{GMP}}','a_{CMP_{MEP}}','a_{GMP_{mat}}','a_{MEP_{mat}}','deg'};
% get rid of brackets in rate_test_str
%% rates string without brackets
for i=1:length(rates_test_str)
    rates_test_str_new{i} = strrep(rates_test_str{i},'{','');
    rates_test_str_new{i} = strrep(rates_test_str_new{i},'}','');
    rates_test_str_new{i} = rates_test_str_new{i}(~isspace(rates_test_str_new{i}));
end
Par_opt = cell(1,length(rates_test_str));

%% (1) initialize values
%% proliferation rates
%all in [0, 0.05]
%'b_{HSC}','b_{MPP}','b_{MLP}','b_{CMP}','b_{GMP}','b_{MEP}','b_{mat}'
b_HSC = 1/10;%1/90;
b_MPP = 1/13;
b_MLP = 1/14;
b_CMP = 1/17;
b_GMP = 1/18;
b_MEP = 1/15;
b_mat = 1/20;

%% death rates
%all in [0,0.001]
g_HSC = 1/400;
g_MPP = 1/100;
g_CMP = 1/200;
g_GMP = 1/350;
g_MEP = 1/300;
g_mat = 1/100; %death of mature cells

%% differentiation rates: model simple
a_HSC_MPP = 1/40;  
a_HSC_CMP = 1/15;
a_HSC_MEP = 1/13;
a_HSC_mat = 1/30;%--> zu klein?
a_MPP_MLP = 1/25;
a_MPP_MEP = 1/27;%--> zu klein?
a_MPP_CMP = 1/20;
a_MPP_GMP = 1/22;
a_MLP = 1/12;
a_MLP_GMP = 1/15;
a_CMP_GMP = 1/25;
a_CMP_MEP = 1/28;%--> zu klein?
a_GMP_mat = 1/23;
a_MEP_mat = 1/26;

%% degradation of dead cells
deg = 1/42; %degradation of dead cells

P_test = [b_HSC, b_MPP, b_MLP, b_CMP, b_GMP, b_MEP, b_mat, g_HSC, g_MPP, g_CMP, g_GMP, g_MEP, g_mat, a_HSC_MPP, a_HSC_CMP, a_HSC_MEP, a_HSC_mat, a_MPP_MLP, a_MPP_MEP, a_MPP_CMP, a_MPP_GMP, a_MLP, a_MLP_GMP, a_CMP_GMP, a_CMP_MEP, a_GMP_mat, a_MEP_mat,deg];

%% (2) update values if results are available --> mean over all available vlues
%for the specified model setting (path)
if ~isempty(path) && ~(exist(path, 'dir')==0) && strcmp(option,'calculateFromRealDataFit')
    cd(path)
%     disp(path)
    %d=dir([path,'/',model,'_model']);
    load('WS_linear_parameters.mat')
    last_individual = samples_H{end};
    cd(['./individual_',last_individual]);
    if opt.fit_repetitions_seperately==true
        load('ws_parameters_healthy_rep_sep.mat')
    else
        load('ws_parameters_healthy.mat')
    end
    transformation_str = {'lin','log10','ratio'};
    rates_data_str = opt.rates(~strwcmp(opt.rates,'x0_*'));
    for rd_id = 1:length(rates_data_str)
        for rt_id = 1:length(rates_test_str)
%             bool_identifiable = reshape((CI_lower(strcmp(transformation_str,'lin'),rd_id,:) > par_min(strcmp(transformation_str,'lin'),rd_id,:) & CI_upper(strcmp(transformation_str,'lin'),rd_id,:) < par_max(strcmp(transformation_str,'lin'),rd_id,:)),1,size(CI_lower,3));
            if strcmp(rates_data_str{rd_id},rates_test_str{rt_id})
                P = PAR_OPT_T(strcmp(transformation_str,'lin'),rd_id,:);
%                 P(~bool_identifiable)=NaN;
                Par_opt{rt_id} = [Par_opt{rt_id}, P];
            end
        end
    end
    for rt_id = 1:length(rates_test_str_new) 
        if ~isempty(Par_opt{rt_id})
            P_test(rt_id) = round(mean(Par_opt{rt_id})*1000)/1000;
        end
    end
    cd(c_dir)
end

