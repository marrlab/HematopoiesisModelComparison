function [theta_t] = transformPar(theta,opt)

theta_t=theta;
if (opt.fitInitialConds && strwcmp(opt.noiseType,'Log*'))
    if length(theta_t)==length(opt.rates)
        theta_t(strwcmp(opt.rates,'x0_*')==1) = log(theta(strwcmp(opt.rates,'x0_*')==1)+1);
    else
        theta_t(1:length(opt.modelStates)) = log(theta(1:length(opt.modelStates))+1);
    end
end

if strcmp(opt.parScale,'log10')
    theta_t = log10(theta);
elseif strcmp(opt.parScale,'partly_log10')
    theta_t(opt.scaleVec==1) = log10(theta(opt.scaleVec==1));
end

end