function [par_test,n_x,opt] = getModelParams(opt,model)
par_test=[];
%path which is checked for optimized parameters --> if values can be found
%there, the test parameter will be the mean
if opt.realdata==false && opt.structuralIdentifiability==false
    [P_test,rates_test_str] = loadTestPar(opt,'calculateFromRealDataFit',model);
end

if opt.fitDeadCells
    opt.modelStates = [opt.modelStates,{'D'}];
end

switch model
    case 'model_A' 
        opt.rates = {'a_{HSC_{MPP}}', 'b_{HSC}', 'g_{HSC}', 'a_{MPP_{MLP}}', 'a_{MPP_{CMP}}', 'b_{MPP}', 'g_{MPP}', 'a_{MLP}', 'b_{MLP}', 'a_{CMP_{GMP}}', 'a_{CMP_{MEP}}', 'b_{CMP}', 'g_{CMP}', 'a_{GMP_{mat}}', 'b_{GMP}', 'g_{GMP}', 'a_{MEP_{mat}}', 'b_{MEP}', 'g_{MEP}', 'b_{mat}', 'g_{mat}'};
    case 'model_B' 
        opt.rates = {'a_{HSC_{MPP}}', 'b_{HSC}', 'g_{HSC}', 'a_{MPP_{MLP}}', 'a_{MPP_{CMP}}', 'b_{MPP}', 'g_{MPP}', 'a_{MLP}', 'a_{MLP_{GMP}}', 'b_{MLP}', 'a_{CMP_{GMP}}', 'a_{CMP_{MEP}}', 'b_{CMP}', 'g_{CMP}', 'a_{GMP_{mat}}', 'b_{GMP}', 'g_{GMP}', 'a_{MEP_{mat}}', 'b_{MEP}', 'g_{MEP}', 'b_{mat}', 'g_{mat}'};            
    case 'model_C'
        opt.rates = {'a_{HSC_{MPP}}', 'a_{HSC_{mat}}', 'b_{HSC}', 'g_{HSC}', 'a_{MPP_{CMP}}', 'a_{MPP_{MLP}}', 'b_{MPP}', 'g_{MPP}', 'a_{CMP_{MEP}}', 'a_{CMP_{GMP}}', 'b_{CMP}', 'g_{CMP}', 'a_{MLP}', 'a_{MLP_{GMP}}', 'b_{MLP}', 'a_{MEP_{mat}}', 'b_{MEP}', 'g_{MEP}', 'a_{GMP_{mat}}', 'b_{GMP}', 'g_{GMP}', 'b_{mat}', 'g_{mat}'};
    case 'model_D'
        opt.rates = {'a_{HSC_{MPP}}', 'a_{HSC_{mat}}', 'b_{HSC}', 'g_{HSC}', 'a_{MPP_{CMP}}', 'a_{MPP_{MLP}}', 'b_{MPP}', 'g_{MPP}', 'a_{CMP_{MEP}}', 'a_{CMP_{GMP}}', 'b_{CMP}', 'g_{CMP}', 'a_{MLP}', 'b_{MLP}', 'a_{MEP_{mat}}', 'b_{MEP}', 'g_{MEP}', 'a_{GMP_{mat}}', 'b_{GMP}', 'g_{GMP}', 'b_{mat}', 'g_{mat}'};
    case 'model_E'
        opt.rates = {'a_{HSC_{MPP}}', 'a_{HSC_{MEP}}', 'b_{HSC}', 'g_{HSC}', 'a_{MPP_{CMP}}', 'a_{MPP_{MLP}}', 'a_{MPP_{MEP}}', 'b_{MPP}', 'g_{MPP}', 'a_{CMP_{MEP}}', 'a_{CMP_{GMP}}', 'b_{CMP}', 'g_{CMP}', 'a_{MLP}', 'a_{MLP_{GMP}}', 'b_{MLP}', 'a_{MEP_{mat}}', 'b_{MEP}', 'g_{MEP}', 'a_{GMP_{mat}}', 'b_{GMP}', 'g_{GMP}', 'b_{mat}', 'g_{mat}'};
    case 'model_F'
        opt.rates = {'a_{HSC_{CMP}}', 'a_{HSC_{MPP}}','b_{HSC}', 'g_{HSC}', 'a_{CMP_{MEP}}', 'a_{CMP_{GMP}}', 'b_{CMP}', 'g_{CMP}', 'a_{MPP_{GMP}}', 'a_{MPP_{MLP}}', 'b_{MPP}', 'g_{MPP}', 'a_{MLP}', 'b_{MLP}', 'a_{MEP_{mat}}', 'b_{MEP}', 'g_{MEP}', 'a_{GMP_{mat}}', 'b_{GMP}', 'g_{GMP}',  'b_{mat}', 'g_{mat}'};
    case 'model_G'
        opt.rates = {'a_{HSC_{MEP}}', 'a_{HSC_{MPP}}', 'b_{HSC}', 'g_{HSC}', 'a_{MEP_{mat}}', 'b_{MEP}', 'g_{MEP}', 'a_{MPP_{CMP}}', 'a_{MPP_{MLP}}' , 'b_{MPP}', 'g_{MPP}', 'a_{CMP_{GMP}}', 'b_{CMP}', 'g_{CMP}', 'a_{MLP}', 'b_{MLP}', 'a_{GMP_{mat}}', 'b_{GMP}', 'g_{GMP}', 'b_{mat}', 'g_{mat}'};            
    case 'model_H'
        opt.rates = {'a_{HSC_{CMP}}', 'a_{HSC_{MPP}}','b_{HSC}', 'g_{HSC}', 'a_{CMP_{MEP}}', 'a_{CMP_{GMP}}', 'b_{CMP}', 'g_{CMP}', 'a_{MPP_{GMP}}', 'a_{MPP_{MLP}}', 'a_{MPP_{MEP}}', 'b_{MPP}', 'g_{MPP}', 'a_{MLP}', 'b_{MLP}', 'a_{MEP_{mat}}', 'b_{MEP}', 'g_{MEP}', 'a_{GMP_{mat}}', 'b_{GMP}', 'g_{GMP}', 'b_{mat}', 'g_{mat}'};
    case 'model_I'
        opt.rates = {'a_{HSC_{MPP}}', 'a_{HSC_{MEP}}', 'b_{HSC}', 'g_{HSC}', 'a_{MPP_{CMP}}', 'a_{MPP_{MLP}}', 'b_{MPP}', 'g_{MPP}', 'a_{CMP_{GMP}}', 'b_{CMP}', 'g_{CMP}', 'a_{MLP}', 'a_{MLP_{GMP}}', 'b_{MLP}', 'a_{MEP_{mat}}', 'b_{MEP}', 'g_{MEP}', 'a_{GMP_{mat}}', 'b_{GMP}', 'g_{GMP}', 'b_{mat}', 'g_{mat}'};
    case 'model_J'
        opt.rates = {'a_{HSC_{MPP}}', 'a_{HSC_{CMP}}', 'a_{HSC_{MEP}}', 'a_{HSC_{mat}}', 'b_{HSC}', 'g_{HSC}', 'a_{MPP_{CMP}}', 'a_{MPP_{MLP}}', 'a_{MPP_{MEP}}', 'a_{MPP_{GMP}}', 'b_{MPP}', 'g_{MPP}', 'a_{CMP_{MEP}}', 'a_{CMP_{GMP}}', 'b_{CMP}', 'g_{CMP}', 'a_{MLP}', 'a_{MLP_{GMP}}', 'b_{MLP}', 'a_{MEP_{mat}}', 'b_{MEP}', 'g_{MEP}', 'a_{GMP_{mat}}', 'b_{GMP}', 'g_{GMP}', 'b_{mat}', 'g_{mat}'};
%         p_test=[a_HSC_MPP a_HSC_CMP a_HSC_MEP a_HSC_mat b_HSC g_HSC a_MPP_CMP a_MPP_MLP a_MPP_MEP a_MPP_GMP b_MPP g_MPP a_CMP_MEP a_CMP_GMP b_CMP g_CMP a_MLP a_MLP_GMP b_MLP a_MEP_mat b_MEP g_MEP a_GMP_mat b_GMP g_GMP b_mat g_mat];
    otherwise
        error('this model scheme is not implemented. Go to getModelParameters()!')
end

if opt.fitDeadCells
    %add degradation rate
    opt.rates = [opt.rates, {'deg'}];
end

if opt.realdata==false && opt.structuralIdentifiability==false
    par_test_lin = [];
    for i=1:length(opt.rates)
        par_test_lin=[par_test_lin,P_test(strcmp(rates_test_str,opt.rates{i}))];
    end
    if opt.applyParConstraints
        [A,b] = getConstraints(opt.modelStates,opt.rates);
        par_check = ((isempty(A)&&isempty(b)) || (sum(A*par_test_lin'<=b)==length(b)));
        if ~par_check
            error('test parameter does not fullfill constraints')
        end
    end
    if length(par_test_lin) ~= length(opt.rates)
        error('test parameter has not the appropriate size!');
    end
end

%% add sigma to test parameter, legend_str and opt.rates
if opt.realdata==false && opt.structuralIdentifiability==false && strcmp(opt.optimizationMode,'standard')
    par_test_lin=[par_test_lin opt.sigma];
end
if ~strcmp(opt.optimizationMode,'hierarchical')
    if sum(strwcmp(opt.rates,'*s*'))==0
        opt.rates{end+1}='s';
    end
end

%% initial Conditions part of the parameter vector or assumed to be known?
x0_str=[];
x0_str1=[];
x0_str2=[];
num_states = length(opt.modelStates);

if opt.fitInitialConds==true %fit initial conditions (part of parameter vector)
    for l=opt.n_initialConds_N:-1:1
        x0_cellstr = cellstr(strcat('x0_',num2str(l),'_',num2str((1:num_states)')));
        x0_str = strjoin(x0_cellstr,' ');
        if l==1
            x0_cellstr1 = cellstr(strcat('x0_',num2str((1:num_states)')));
            x0_str1 = strjoin(x0_cellstr1,' ');
            x0_cellstr2 = cellstr(strcat('x0_',num2str((1:num_states)')));
            x0_str2 = strjoin(x0_cellstr2,', ');
        end
        opt.rates = {x0_cellstr{:}, opt.rates{:}};
%         x0_test=unidrnd(100,1,num_states);
%         x0_test(1)=250+unidrnd(250,1,1);
        x0_test=unidrnd(5,1,num_states);
        x0_test(1)=500;
%         x0_test=unidrnd(2000,1,n_states); % initial values for first piece of ODE
%         x0_test(1) = 2000;
        if opt.realdata==false && opt.structuralIdentifiability==false
            par_test_lin = [x0_test, par_test_lin];
        end
    end
end
n_x=length(opt.modelStates);
n_p=length(opt.rates);  
   
%% transform test parameter &  set ami options
%pscale = 0 --> lin, 1 --> log10, 2 --> log10
switch opt.parScale
    case 'none'
        opt.scaleVec = zeros(1,n_p);
        pscale_vec=zeros(1,n_p);
    case 'log10'
        opt.scaleVec = ones(1,n_p);
        pscale_vec = [ones(1,num_states), 2.*ones(1,n_p-num_states)];
    case 'partly_log10'
        opt.scaleVec = (~strwcmp(opt.rates,'x0_*'));
        if opt.fitInitialConds
            scaleVec_red = [opt.scaleVec(1:num_states),opt.scaleVec(opt.n_initialConds_N*num_states+1:end)];
        else
            scaleVec_red = opt.scaleVec;
        end
        pscale_vec = ones(size(scaleVec_red));
        pscale_vec(scaleVec_red==0) = zeros(1,sum(scaleVec_red==0));
        pscale_vec(scaleVec_red==1) = 2*ones(1,sum(scaleVec_red==1));
end
opt.amiOptions.pscale = pscale_vec;

%% transform test parameter
if opt.realdata==false && opt.structuralIdentifiability==false
    par_test = transformPar(par_test_lin,opt);
end

end

function [P_test,rates_test_str] = loadTestPar(opt,option,model)
    c_dir = cd();
    cd('../')
    cd('./model_comparison_analysis/')
    r_dir = cd();

    HO_str = '';
    if strwcmp(opt.optimizationMode,'hierarchical')
        HO_str = '_HO';
    end
    path = [r_dir,'/results_',num2str(opt.n_divStates),'divs_',num2str(opt.n_intermediateStates(opt.iS_ID)),'iS',HO_str,'_',opt.noiseType];

    if opt.fitInitialConds && ~strwcmp(path,'*_fit_iC*')
       path = [path,'_fit_iC'];  
    end
    path = [path,'/',model,'_model'];

    rates_test_str = {'b_{HSC}','b_{MPP}','b_{MLP}','b_{CMP}','b_{GMP}','b_{MEP}','b_{mat}','g_{HSC}','g_{MPP}','g_{CMP}','g_{GMP}','g_{MEP}','g_{mat}','a_{HSC_{MPP}}','a_{HSC_{CMP}}','a_{HSC_{MEP}}','a_{HSC_{mat}}','a_{MPP_{MLP}}','a_{MPP_{MEP}}','a_{MPP_{CMP}}','a_{MPP_{GMP}}','a_{MLP}','a_{MLP_{GMP}}','a_{CMP_{GMP}}','a_{CMP_{MEP}}','a_{GMP_{mat}}','a_{MEP_{mat}}','deg'};
    % get rid of brackets in rate_test_str
    %% rates string without brackets
    for id=1:length(rates_test_str)
        rates_test_str_new{id} = strrep(rates_test_str{id},'{','');
        rates_test_str_new{id} = strrep(rates_test_str_new{id},'}','');
        rates_test_str_new{id} = rates_test_str_new{id}(~isspace(rates_test_str_new{id}));
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
        last_individual = opt.individuals{length(opt.individuals)};
        cd(['./individual_',last_individual]);
        if opt.fit_repetitions_seperately==true
            load('ws_parameters_rep_sep.mat')
        else
            load('ws_parameters.mat')
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
    cd(c_dir)
end