function [theta_lin] = transformParBack(theta,opt)

theta_lin=theta;
if strcmp(opt.parScale,'log10')
    theta_lin = 10.^theta;
elseif strcmp(opt.parScale,'partly_log10')
    theta_lin(opt.scaleVec==1) = 10.^theta(opt.scaleVec==1);
end

if (opt.fitInitialConds && strwcmp(opt.noiseType,'Log*'))
    if length(theta)==length(opt.rates)
        theta_lin(strwcmp(opt.rates,'x0_*')==1) = exp(theta(strwcmp(opt.rates,'x0_*')==1))-1;
    else
        theta_lin(1:length(opt.modelStates)) = exp(theta(1:length(opt.modelStates)))-1;
    end
end