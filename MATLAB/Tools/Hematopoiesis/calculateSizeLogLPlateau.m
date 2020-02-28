function [percentage] = calculateSizeLogLPlateau(parameters)
    %calculates percentage of MSs which lie within 5%-deviation-from-best-logL-value-range
    percentage = 100*(sum(abs(parameters.MS.logPost-parameters.MS.logPost(1))<=0.05*abs(parameters.MS.logPost(1))))/length(parameters.MS.logPost);
end