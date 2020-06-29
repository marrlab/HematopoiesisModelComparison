function [opt] = getSimulationSettings(opt)
    %set rates, define times and initial conditions
%     T_min = 1;
%     T_max = 7;%latest time point (in days) for which system is simulated
%     t = T_min:1:T_max;
    t = [1,2,3,5,7];
    opt.t = t*24;%in hours
end