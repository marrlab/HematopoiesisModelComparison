function [par_test,n_x,opt] = getModelParams(opt,model)
par_test=[];
%path which is checked for optimized parameters --> if values can be found
%there, the test parameter will be the mean
if opt.realdata==false && opt.structuralIdentifiability==false
    [P_test,rates_test_str] = loadTestPar(opt,'calculateFromRealDataFit',model);
end

opt.modelStates = {'HSC','MPP','MLP','CMP','GMP','MEP','mat'};

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
        x0_test=unidrnd(100,1,num_states);
        x0_test(1)=250+unidrnd(250,1,1);
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