function [sol] = simH(y0,t,p,model,opt,applyNoise,Data,sigma)

k = y0; %first part empty if initial conditions are fit, 

if opt.fitInitialConds==true
    ny0=length(opt.modelStates);
else
    ny0=0;
end
nPar_sim = length(p);

if any(strcmp(model,opt.models_implemented))
    modelstr = ['simulate_',model,'_',num2str(opt.n_intermediateStates(opt.iS_ID)),'(t,p,k,Data,opt.amiOptions)'];
    sol = eval(modelstr);
else
    error('This model is not implemented. Go to sim_H()!')
end

if applyNoise
    if strcmp(opt.optimizationMode,'hierarchical')
        switch opt.noiseType 
            case 'LogLaplace'
                if max(size(opt.sigma))>1
                    noise=laprnd(size(sol.y,1),size(sol.y,2),zeros(size(sol.y)),opt.sigma.*ones(size(sol.y)));
                else
                    noise=laprnd(size(sol.y,1),size(sol.y,2),zeros(size(sol.y)),opt.sigma.*ones(size(sol.y)));
                end
                sol.y = sol.y+noise;
            case 'LogNormal'
                if max(size(opt.sigma))>1
%                     noise=normrnd(0,opt.sigma.*ones(size(sol.y,1),1),size(sol.y));
                    noise=lognrnd(0,opt.sigma.*ones(size(sol.y,1),1),size(sol.y));
                else
%                     noise=normrnd(0,opt.sigma,size(sol.y));
                    noise=lognrnd(0,opt.sigma,size(sol.y));
                end
%                 sol.y = max(zeros(size(sol.y)),sol.y+noise);
                sol.y = log((exp(sol.y)-1).*noise+1);
        end
    else
        if isempty(sigma)
            sigma = p(end);
        end
        switch opt.noiseType 
            case 'additiveNormal'
                noise=normrnd(0,sigma,size(sol.y));
                sol.y = max(sol.y+noise,zeros(size(sol.y)));
            case 'LogNormal'
                if max(size(opt.sigma))>1
%                     noise=normrnd(0,opt.sigma.*ones(size(sol.y,1),1),size(sol.y));
                    noise=lognrnd(0,opt.sigma.*ones(size(sol.y,1),1),size(sol.y));
                else
%                     noise=normrnd(0,opt.sigma,size(sol.y));
                    noise=lognrnd(0,opt.sigma,size(sol.y));
                end
%                 sol.y = max(zeros(size(sol.y)),sol.y+noise);
                sol.y = log((exp(sol.y)-1).*noise+1);
        end
    end
end

    function y  = laprnd(m, n, mu, sigma)
        %LAPRND generate i.i.d. laplacian random number drawn from laplacian distribution
        %   with mean mu and standard deviation sigma. 
        %   mu      : mean
        %   sigma   : standard deviation
        %   [m, n]  : the dimension of y.
        %   Default mu = 0, sigma = 1. 
        %   For more information, refer to
        %   http://en.wikipedia.org./wiki/Laplace_distribution

        %   Author  : Elvis Chen (bee33@sjtu.edu.cn)
        %   Date    : 01/19/07

        %Check inputs
        if nargin < 2
            error('At least two inputs are required');
        end

        if nargin == 2
            mu = 0; sigma = 1;
        end

        if nargin == 3
            sigma = 1;
        end

        % Generate Laplacian noise
        u = rand(m, n)-0.5;
        b = sigma ./ sqrt(2);
        y = mu - b .* sign(u).* log(1- 2* abs(u));
    end
end