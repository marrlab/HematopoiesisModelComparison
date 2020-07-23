function [parameters,opt,options_par] = performParameterEstimation(opt,theta_test,data,i_ID)
    [options_par, parameters, opt] = getOptimizationSettings(opt,theta_test,data);
    logL = @(theta) logLH(theta,data,opt,i_ID);

    % define logL for storing values of sigma for optimal parameter:
    if strcmp(opt.optimizationMode,'hierarchical')
        opt.HO.save = true;
        logL_final = @(theta) logLH(theta,data,opt,i_ID);
        opt.HO.save = false;
    end

    % test gradient
    testAndPlotGradient(parameters,logL,opt,i_ID)

    [parameters] = optimizationProc(options_par,parameters,logL,logL_final,opt,i_ID);
    
    
    
    function [varargout] = logLH(varargin)
    % logL__N.m provides the log-likelihood, its gradient and an 
    % approximation of the Hessian matrix based on Fisher information matrix
    % for the conversion reaction process.

        %% CHECK AND ASSIGN INPUTS
        if nargin >= 1
            par = varargin{1};
        else
            error('logLH requires a parameter object as input.');
        end
        if nargin >= 2
            data = varargin{2};
        else
            error('logLH requires a data object as input.');
        end
        % Check and assign options
        if nargin >= 3
            opt = varargin{3};
        else
            error('logLH requires an opt object as input.');
        end
        if nargin >= 4
            sample_ID = varargin{4};
        else
            error('logLH requires a sample_ID object as input.');
        end
        if nargin == 5
            lambda = varargin{5};
        end
        %bounds for indices:
        nPar = length(par);% parameters

        %need par as column vector
        [a,b]=size(par);
        if a<b
            par=par';
        end

        if opt.applyParConstraints
            % check constraints
            par_lin=transformParBack(par,opt);
            par_check = ((isempty(opt.A)&&isempty(opt.b)) || (sum(opt.A*par_lin<=opt.b)==length(opt.b)));
        else
            par_check = true;
        end

        if par_check % all constraints fullfilled
            switch opt.optimizationMode 
                case 'hierarchical'
                    %get Data in right format/ shape
                    %set options
                    %simulate model
                   [simulation,D] = simulateAllExperiments(data,opt,par);
                   if strcmp(opt.HO.distribution,'laplace')
                       [LOGL,LOGL_D] = logLikelihoodHierarchical(simulation,D,opt.HO);
                   elseif strcmp(opt.HO.distribution,'normal')
                       [LOGL,LOGL_D,FIM] = logLikelihoodHierarchical(simulation,D,opt.HO);
                   end
                case 'standard'
                    [LOGL,LOGL_D,FIM] = logLikelihoodStandard(par,data,nPar,opt);
            end
            if strcmp(opt.RUN,'topology_comparison_L1')
               v=zeros(size(par));
               v(strwcmp(opt.rates,'a_*'))=1;
               LOGL = LOGL+lambda*sum(abs(par(strwcmp(opt.rates,'a_*'))));
               LOGL_D = LOGL_D+lambda*v;
            end
        else
            LOGL = opt.par_init_TH;%very small number such that set of parameter values is rejected
            LOGL_D = zeros(nPar,1);
            FIM = zeros(nPar);
        end

        assert(~isnan(LOGL) && imag(LOGL)==0 && ~isinf(LOGL), 'improper logL value')

        switch nargout
            case 1
                varargout{1} = LOGL;  
            case 2 
                varargout{1} = LOGL;
                varargout{2} = LOGL_D;
            case 3
                varargout{1} = LOGL;
                varargout{2} = LOGL_D;
                varargout{3} = FIM;
        end


        function [simulation,Data] = simulateAllExperiments(data,opt,par)
            simulation = struct([]);
            Data = struct([]);

            nRepetitions = opt.n_initialConds_N;% matches the array size no matter if repetitions are fit together or not

            %   D: (1 x #experiments) struct containing data with two fields
            %       * t: time points
            %       * my: # time points x # observables x # replicates
            j=0;
            for i_repe=1:nRepetitions %size(data.sample,2) %index for data sets/ fits
                if opt.fit_repetitions_seperately
                    n_replicates = max(data.replicate);
                else
                    n_replicates = max(data.replicate(data.repetition==i_repe));
                end
                for i_repl=1:n_replicates 
                    j=j+1;
                    if opt.n_divStates>1
                        Data(j).my(:,:,1) = data.NumCellDiv_ALL{i_repe,i_repl};
                        Data(j).t = data.timeDiv{i_repe,i_repl};%-min(data.timeDiv{i_repe,i_repl});
                        if opt.n_initialConds_N==0
                            Data(j).y0 = data.NumCellDiv_ALL_Y0{i_repe,i_repl};
                        else
                            Data(j).y0 = [];
                        end
                        Data(j).DL = data.detectionLimit_correctedDiv{i_repe,i_repl};
                    else
                        Data(j).my(:,:,1) = data.ym{i_repe,i_repl};
                        if opt.n_initialConds_N==0
                            Data(j).y0 = data.y0{i_repe};
                        else
                            Data(j).y0 = [];
                        end
                        Data(j).t = data.t{i_repe,i_repl};%-min(data.t{i_repe,i_repl});
                        Data(j).DL = data.detectionLimit_corrected{i_repe,i_repl};
                    end
                    if isempty(Data(j).my(:,:,1))
                        continue;
                    end

                    if opt.fitInitialConds==true
                        ny0 = length(opt.modelStates); %number of parameters for initial per repetition and replicate
                    else
                        ny0=0;
                    end
                    % Data is a matrix of dimension nTime * nObs
                    %initial conditions for this repetition available??
                    if opt.fitInitialConds
                        par_sim = [par(1+ny0*(i_repe-1):i_repe*ny0);par(opt.n_initialConds_N*ny0+1:end)]';
                    else
                        par_sim = par';
                    end

                    % parameter vector for simulation always contains current set of
                    % initial conditions --> model output shou
                    [sol] = simH(Data(j).y0,Data(j).t,par_sim,opt.model,opt,false,[],[]);
                    simulation(j).y = sol.y;
                    simulation(j).sy = zeros(length(Data(j).t),size(Data(j).my,2),length(par));
                    simulation(j).sy(:,:,1+ny0*(i_repe-1):i_repe*ny0) = sol.sy(:,:,1:ny0);
                    simulation(j).sy(:,:,nRepetitions*ny0+1:end) = sol.sy(:,:,ny0+1:end);
                end
            end
        end
    end

    function [LOGL,LOGL_D,FIM] = logLikelihoodStandard(par,data,nPar,opt)

        % % Simulation options
        nRepetitions = opt.n_repetitions;

        res=cell(nRepetitions);
        LOGL = 0;
        LOGL_D = zeros(nPar,1);
        FIM = zeros(nPar);  % Preallocation

        %fit every patient independently
        %fit several replicates (same initial values) and repetitions (different initial values) at once
        for i_repe=1:nRepetitions %size(data.sample,2) %index for data sets/ fits
            n_replicates = max(data.replicate(data.repetition==i_repe));
            for i_repl=1:n_replicates 
                if opt.n_divStates>1
                    D.Y = data.NumCellDiv_ALL{i_repe,i_repl};
                    D.t = data.timeDiv{i_repe,i_repl};
                    if opt.n_initialConds==0
                        D.Y0 = data.NumCellDiv_ALL_Y0{i_repe,i_repl};
                    else
                        D.Y0 = [];
                    end
                    D.DL = data.detectionLimit_correctedDiv{i_repe,i_repl};
                else
                    D.Y = data.ym{i_repe,i_repl};
                    if opt.n_initialConds==0
                        D.Y0 = data.y0{i_repe};
                    else
                        D.Y0 = [];
                    end
                    D.t = data.t{i_repe,i_repl};
                    D.DL = data.detectionLimit_corrected{i_repe,i_repl};
                end
                if isempty(D.Y)
                    continue;
                end

                nTime = length(D.t); %number of time points
                nObs = size(D.Y,2);% dimension of output (number of states in model)
                if opt.fitInitialConds==true
                    ny0 = length(opt.modelStates); %number of parameters for initial per repetition and replicate
                else
                    ny0=0;
                end
                % Data is a matrix of dimension nTime * nObs
                % initial conditions for this repetition available?
                if opt.fitInitialConds
                    par_sim = [par(1+ny0*(i_repe-1):i_repe*ny0);par(opt.n_initialConds*ny0+1:end)]';
                else
                    par_sim = par';
                end
                nPar_sim = length(par_sim);

                % parameter vector for simulation always contains current set of
                % initial conditions --> model output shou
                [sol] = simH(D.Y0,D.t,par_sim,opt.model,opt,false,D,[]);
                M.Y = sol.y;

                %% correct dimension of sensititvities, derivative of logL, ssigmay (in case of multiple initial conditions)
                Sy_red = sol.sy;
                %sol.sllh is not equal to gradient we are interested in because
                %sigma is provided as sigma^2
                sigmay = sol.sigmay;
                ssigmay_red = sol.ssigmay;
                % expand size of sensitivity matrix for initial conditions
                if nPar_sim<nPar
                    Sy_all=zeros(size(Sy_red,1),size(Sy_red,2),nPar);
                    Sy_all(:,:,1+ny0*(i_repe-1):i_repe*ny0) = Sy_red(:,:,1:ny0);
                    Sy_all(:,:,opt.n_initialConds*ny0+1:end) = Sy_red(:,:,ny0+1:end);
                    ssigmay_all = zeros(size(ssigmay_red,1),size(ssigmay_red,2),nPar);
                    ssigmay_all(:,:,1+ny0*(i_repe-1):i_repe*ny0) = ssigmay_red(:,:,1:ny0);
                    ssigmay_all(:,:,opt.n_initialConds*ny0+1:end) = ssigmay_red(:,:,ny0+1:end);
                else
                    Sy_all = Sy_red;
                    ssigmay_all = ssigmay_red;
                end

                %% residuals
                res{i_repe,i_repl} = (D.Y - M.Y);% Residuals
                res{i_repe,i_repl}(isnan(res{i_repe,i_repl})) = 0;% Disregard failed/missing measurements

                %% Objective function evaluation
                if opt.correctObsBelowDL
                    DL_mat = repmat(D.DL,1,size(M.Y,2));
                    D.Y((M.Y>DL_mat)&(D.Y<repmat(D.DL,1,size(M.Y,2)))) = DL_mat((M.Y>DL_mat)&(D.Y<repmat(D.DL,1,size(M.Y,2))));
                end
                if opt.weightObsBelowDL
                    w = min((1./repmat(D.DL,1,size(D.Y,2))).*D.Y,1);
                else
                    w = ones(size(D.Y));
                end
                LOGL = LOGL -(1/2)*sum(sum(log(2*pi*sigmay) + ((w.*res{i_repe,i_repl}).^2)./(sigmay)));
                for par_id=1:nPar_sim
                    LOGL_D_Term1 = (1./(sigmay)).*(1-((w.*res{i_repe,i_repl}).^2)./(sigmay)).*ssigmay_red(:,:,par_id);
                    LOGL_D_Term2 = -(2.*(res{i_repe,i_repl}.*w)./(sigmay)).*Sy_red(:,:,par_id);
                    LOGL_D(par_id) = LOGL_D(par_id) + (-1/2)*sum(sum((LOGL_D_Term1 + LOGL_D_Term2)));
                end

                if nargout==3
                    %% Approximation of Hessian 
                    Sum1 = (repmat(((1./sigmay(:).^2).*(1-2.*(w(:).*res{i_repe,i_repl}(:).^2./sigmay(:))))',nPar,1).*reshape(ssigmay_all(:),nTime*nObs,nPar)')*reshape(ssigmay_all(:),nTime*nObs,nPar);
                    Sum2 = ((1./repmat(reshape(sigmay(:),nTime*nObs,1)',nPar, 1))'.*reshape(Sy_all, nTime*nObs, nPar))'*reshape(Sy_all, nTime*nObs, nPar);
                    Sum3 = (repmat(reshape((w(:).*res{i_repe,i_repl}(:)./sigmay(:).^4),nTime*nObs,1)',nPar, 1).*(reshape(ssigmay_all(:),nTime*nObs, nPar))'*reshape(Sy_all, nTime*nObs, nPar))'... 
                           + (repmat(reshape((w(:).*res{i_repe,i_repl}(:)./sigmay(:).^4),nTime*nObs,1)',nPar, 1).*reshape(ssigmay_all(:),nTime*nObs, nPar)'*reshape(Sy_all, nTime*nObs, nPar));
                    Term = -(1/2)*Sum1+Sum2+Sum3;
                    FIM = FIM + Term;
                end
            end
        end
    end
    
    function [] = testAndPlotGradient(parameters,logL,opt,i_ID)
        if opt.testGradient == true
            xi = (parameters.max+parameters.min).*2./3;
            [g,g_fd_f,g_fd_b,g_fd_c] = testGradient(xi,@(xi) logL(xi),1e-10);
            disp([g_fd_f,g_fd_b,g_fd_c,g]);
            figure()
            plot(g_fd_c-g,'-ob','LineWidth',2); hold on;
            plot(g_fd_f-g,':og'); hold on;
            plot(g_fd_b-g,':og'); hold on;
            plot(0:length(g)+1,zeros(1,length(g)+2),'k--');
            fig_str = strcat('Gradient_check_individual_',opt.individuals{i_ID});
            saveFigures(opt,fig_str);
        end
    end

    function [parameters] = optimizationProc(options_par,parameters,logL,logL_final,opt,individual_i)
        num_individual = opt.individuals{individual_i};
        if strcmp(options_par.comp_type,'parallel') && (opt.n_workers >= 2)
            parpool(opt.n_workers);
        end
        % set seed
        rng(1256);
        parameters = getMultiStarts(parameters,logL,options_par);

        % for storing values of sigma for optimal parameter:
        if strcmp(opt.optimizationMode,'hierarchical')
            logL_final(parameters.MS.par(:,1))
        end
        if opt.save
            saveFigures(opt,['MS_optimization_individual_',num_individual])
            cd(opt.c_path)
            cd(['./',opt.foldername,'/',opt.subfoldername,'/',opt.subsubfoldername])
            save(['WS_MSopt_individual_',num_individual,'.mat'])
            cd(opt.c_path)
        else
            close all;
        end
        if strcmp(options_par.comp_type,'parallel') && (opt.n_workers >= 2)
            delete(gcp);
            options_par.comp_type = 'sequential'; options_par.mode = 'visual'; opt.n_workers = 1;
        end
        if opt.PLcalculation == true
            %% parameters describing initial conditions
            for i=1:length(parameters.min)
                options_par.parameter_index = i;
                options_par.options_getNextPoint.min = (parameters.max(i)-parameters.min(i))/100;
                options_par.options_getNextPoint.max = (parameters.max(i)-parameters.min(i))/50;
                options_par.options_getNextPoint.guess = (parameters.max(i)-parameters.min(i))/75;
                parameters = getParameterProfiles(parameters,logL,options_par);
                if opt.save
                    saveFigures(opt,['Profile_Likelihood_individual_',num_individual,'_',parameters.name{i}]);
                else
                    close all;
                end
            end

            if opt.save
                cd(opt.c_path)
                cd(['./',opt.foldername,'/',opt.subfoldername,'/',opt.subsubfoldername])
                save(['WS_PL_individual_',num_individual,'.mat'])
                cd(opt.c_path)
            end

        end
        parameters = getParameterConfidenceIntervals(parameters,opt.CI_levels);
        if opt.save
            saveFigures(opt,['CI_individual_',num_individual]);
        else
            close all;
        end
    end

end