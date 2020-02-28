function [sol] = sim_H(y0,t,p,model,opt,applyNoise,Data,sigma)

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

end