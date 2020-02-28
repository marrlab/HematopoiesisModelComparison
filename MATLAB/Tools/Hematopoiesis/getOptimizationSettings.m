function [options_par, parameters, opt] = getOptimizationSettings(opt,theta_test,data)


%% Options for Multi-start local optimization
%load default options for getMultistart() in PESTO and make changes
options_par = PestoOptions();

% TolX: step size tolerance
options_par.comp_type = 'sequential'; options_par.mode = 'visual'; opt.n_workers = 1;
% options_par.comp_type = 'parallel'; options_par.mode = 'visual'; opt.n_workers = 2;
% options_par.comp_type = 'parallel'; options_par.mode = 'visual'; opt.n_workers = 10;

% optimization settings
switch opt.RUN
    case 'fit_samples'
        options_par.n_starts = 1000;
    case 'hierarchy_comparison_BIC'
        if opt.realdata == true
            options_par.n_starts = 1;%1000;
        else
            options_par.n_starts = 1;%1000;
        end
    case 'test_inference_procedure'
        options_par.n_starts = 1000;
end

%% with Hessian
switch opt.noiseType 
    case 'LogLaplace'
        options_par.localOptimizerOptions = optimset(  'Algorithm','interior-point',... 
                                                       'GradObj','on',...   
                                                       'Hessian','off',...
                                                       'MaxIter',3500,...
                                                       'PrecondBandWidth',inf,...
                                                       'TolFun', 1e-5,...
                                                       'MaxFunEvals',4000,... %should be >'MaxIter'
                                                       'TolX',1e-4,... %1e-6, ...
                                                       'Display', 'iter', ...
                                                       'TolGrad', 1e-4);
    case 'LogNormal'
        if opt.applyParConstraints
            options_par.localOptimizerOptions = optimset(  'Algorithm','interior-point',... 
                                                           'GradObj','on',...   
                                                           'GradConstr','on',...
                                                           'MaxIter',3500,...
                                                           'TolCon',1e-6,...
                                                           'PrecondBandWidth',inf,...
                                                           'TolFun', 1e-10,...
                                                           'MaxFunEvals',4000,... %should be >'MaxIter'
                                                           'TolX',1e-5,... %1e-6, ...
                                                           'Display', 'iter', ...
                                                           'TolGrad', 1e-5);
        else
            options_par.localOptimizerOptions = optimset( 'Algorithm','trust-region-reflective',...
                                                       'GradObj','on',...   
                                                       'Hessian','user-supplied',...  
                                                       'HessFcn','objective',... 
                                                       'Hessian','on',...
                                                       'MaxIter',3500,...
                                                       'PrecondBandWidth',inf,...
                                                       'TolFun',1e-10,... %1e-6,...
                                                       'MaxFunEvals',4000,... %should be >'MaxIter'
                                                       'TolX',1e-5, ...
                                                       'Display', 'iter', ...
                                                       'TolGrad', 1e-5);
        end
end
options_par.init_threshold=-1e6;     
opt.par_init_TH = options_par.init_threshold;
options_par.obj_type = 'log-posterior';

parameters.name = opt.rates;  
parameters.number = length(opt.rates);

idx_x0 = find(strwcmp(opt.rates,'x0*'));

if strcmp(opt.optimizationMode,'hierarchical')
    par_min=1/500*ones(1,length(parameters.name)-length(idx_x0));
    par_max=ones(1,length(parameters.name)-length(idx_x0));
else
    par_min=1/500*ones(1,length(parameters.name)-length(idx_x0)-1);
    par_max=ones(1,length(parameters.name)-length(idx_x0)-1);
end
if strcmp(opt.optimizationMode,'standard')
    switch opt.noiseType 
        case 'LogLaplace'
            par_min=[par_min,0.01/sqrt(2)];
            par_max=[par_max,2/sqrt(2)];    
        case 'LogNormal'
            par_min=[par_min,0.01];
            par_max=[par_max,2];   
    end
end

if opt.fitInitialConds
    if opt.realdata==false
        if strwcmp(opt.noiseType,'Log*')
            IC_test_vec = exp(theta_test(1:length(opt.modelStates)*opt.n_initialConds_N))-1;
        else
            IC_test_vec = theta_test(1:length(opt.modelStates)*opt.n_initialConds_N);        
        end
        par_min = [IC_test_vec-0.1*IC_test_vec,par_min];
        par_max = [IC_test_vec+0.1*IC_test_vec,par_max];
    else
        for i=opt.n_initialConds_N:-1:1 %repetitions
            Y0=[];
            Y0_lower=[];
            Y0_upper=[];
            Y0_l_S=[];
            for j=1:size(data.ym,2) %replicates
                if opt.n_divStates>1 && opt.n_divStates<=12
                    if ~isempty(data.NumCellDiv_ALL_Y0{i,j})
                        if strwcmp(opt.noiseType,'Log*')
                            Y0 = [Y0; exp(data.NumCellDiv_ALL_Y0{i,j}(opt.n_divStates+1:opt.n_divStates:end))-1];
                            %for stem cells:
                            Y0_l_S = min([Y0_l_S,exp(data.NumCellDiv_ALL_Y0{i,j}(1))-1]);%HSCs day 0
                        else
                            Y0 = [Y0; data.NumCellDiv_ALL_Y0{i,j}(opt.n_divStates+1:opt.n_divStates:end)];
                            %for stem cells:
                            Y0_l_S = min([Y0_l_S,data.NumCellDiv_ALL_Y0{i,j}(1)]);%HSCs day 0
                        end
                    end
                elseif opt.n_divStates==1
                    if ~isempty(data.y0{i,j})
                        if strcmp(opt.noiseType,'Log*')
                            Y0 = [Y0; exp(data.y0{i,j}(2:end))-1];
                            %for stem cells:
                            Y0_l_S = min([Y0_l_S,exp(data.y0{i,j}(1))-1]);%HSCs day 0
                        else
                            Y0 = [Y0; data.y0{i,j}(2:end)];
                            %for stem cells:
                            Y0_l_S = min([Y0_l_S,data.y0{i,j}(1)]);%HSCs day 0
                        end
                    end
                else
                    error('data not available for more than 12 divisions')
                end
            end
            %for stem cells:
            if strwcmp(opt.noiseType,'Log*')
                Y0_u_S = exp(data.inputCells{i})-1;%max(Y0(:,1))+0.1*max(Y0(:,1));
            else
                Y0_u_S = data.inputCells{i};
            end
            Y0_lower = [Y0_lower Y0_l_S];
            Y0_upper = [Y0_upper Y0_u_S];
            %other compartments:
            if size(Y0,1)>1
                Y0_upper = [Y0_upper max(Y0)+0.1*max(Y0)];
                Y0_lower = [Y0_lower zeros(1,size(Y0,2))];
            else
                Y0_upper = [Y0_upper Y0+0.1*Y0];
                Y0_lower = [Y0_lower zeros(1,size(Y0,2))];
            end
            par_min = [Y0_lower,par_min];
            par_max = [max(Y0_upper,ones(size(Y0_upper))),par_max];
        end
    end
end
 
parameters.min = transformPar(par_min,opt);
parameters.max = transformPar(par_max,opt);

if (~opt.realdata) && strcmp(opt.model_sim,opt.model)
    if ~(all(theta_test<=parameters.max) && all(theta_test>=parameters.min))
        error('chosen test parameter is out of parameter boundaries. Change either test parameter or boundary definiton!')
    end
end

if opt.applyParConstraints
    %% constraints settings:
    %A*theta<=b
    [opt.A,opt.b] = getConstraints(opt.modelStates,parameters.name);
    parameters.constraints.A = opt.A;
    parameters.constraints.b = opt.b;
    parameters.constraints.Aeq = [];
    parameters.constraints.beq = [];

    scaleVec = zeros(size(opt.scaleVec));
    scaleVec(opt.scaleVec) = 1;
    scaleVec(strwcmp(opt.rates,'x0_*')==1) = -1;


    switch opt.parScale
        case {'log10','partly_log10'} 
            options_par.proposal='user-supplied';
            parameters.nonlin_constraints = @(theta) nonlincon(theta,parameters.constraints.A,parameters.constraints.b,opt.parScale,scaleVec);
            parameters.init_fun = @(par_guess,par_min,par_max,n_starts) LHS_constraint(par_guess,par_min,par_max,n_starts,parameters.constraints,opt.parScale,scaleVec);
        case 'none'
            parameters.nonlin_constraints=[];
            options_par.proposal='user-supplied';
            parameters.init_fun = @(par_guess,par_min,par_max,n_starts) LHS_constraint(par_guess,par_min,par_max,n_starts,parameters.constraints,opt.parScale,scaleVec);
    end
end
%% hierarchical optimization settings
if strcmp(opt.optimizationMode,'hierarchical')
    dS = sum(strcmp(opt.modelStates,'D'));
    Nobs = opt.n_divStates*(length(opt.modelStates)-dS)+dS;%dimension of output
    opt.HO.noise=repmat({'single'},1,Nobs);
    switch opt.noiseType
        case 'LogNormal'
            opt.HO.distribution = 'normal';
        case 'LogLaplace'
            opt.HO.distribution = 'laplace';
    end
    opt.HO.n_obs = Nobs;
    opt.HO.n_exp = length(data.repetition);
    opt.HO.max_repl = 1;
    opt.HO.save = false;%true;
    opt.HO.foldername = [opt.foldername,'/',opt.subfoldername,'/',opt.subsubfoldername];
    Obs_Noise_str = '{';
    for i=1:floor(Nobs/opt.n_divStates)
        v = (opt.n_divStates*(i-1)+1:opt.n_divStates*i);
        if i==floor(Nobs/opt.n_divStates) && mod(Nobs,opt.n_divStates)==0
            Obs_Noise_str = [Obs_Noise_str,'[',num2str(v),']}'];
        else
            Obs_Noise_str = [Obs_Noise_str,'[',num2str(v),'],'];
        end
    end
    if mod(Nobs,opt.n_divStates)~=0
        v = (opt.n_divStates*floor(Nobs/opt.n_divStates)+1);
        Obs_Noise_str = [Obs_Noise_str,'[',num2str(v),']}'];
    end
    opt.HO.obsgroups_noise = eval(Obs_Noise_str);
    
    Exp_Noise_str = '{';
    idx=1;
    for i=1:opt.n_initialConds_N %repetitions
        w=[];
        for j=1:size(data.ym,2) %replicates
            if ~isempty(data.ym{i,j})
                w=[w,idx];
                idx=idx+1;
            end
        end
        if i==opt.n_initialConds_N
            Exp_Noise_str = [Exp_Noise_str,'[',num2str(w),']}'];
        else
            Exp_Noise_str = [Exp_Noise_str,'[',num2str(w),'],'];
        end
    end
    opt.HO.expgroups_noise = eval(Exp_Noise_str);
%     for ie = 1:numel(opt.HO.expgroups_noise)
%         disp(opt.HO.expgroups_noise{ie});
%     end
    opt.HO.scale = repmat({'lin'},1,Nobs);
    opt.HO.expgroups_scaling = {};%opt.HO.expgroups_noise;
    opt.HO.obsgroups_scaling = {};%opt.HO.obsgroups_noise;
    opt.HO.scaling = repmat({'absolute'},1,Nobs);
end

end

