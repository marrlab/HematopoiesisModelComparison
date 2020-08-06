
%%
% COMPILATION

[exdir,~,~]=fileparts(which('model_I_10.m'));
% compile the model
amiwrap('model_I_10','model_I_10_syms',exdir)
% add the model to the path
addpath(genpath([strrep(which('amiwrap.m'),'amiwrap.m','') 'models/model_I_10']))

