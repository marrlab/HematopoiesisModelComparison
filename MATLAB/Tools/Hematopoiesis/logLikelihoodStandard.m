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
        [sol] = sim_H(D.Y0,D.t,par_sim,opt.model,opt,false,D,[]);
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