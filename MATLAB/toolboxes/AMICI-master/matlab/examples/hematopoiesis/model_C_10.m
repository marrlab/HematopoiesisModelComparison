
%%
% COMPILATION

[exdir,~,~]=fileparts(which('model_C_10.m'));
% compile the model
amiwrap('model_C_10','model_C_10_syms',exdir)
% add the model to the path
addpath(genpath([strrep(which('amiwrap.m'),'amiwrap.m','') 'models/model_C_10']))

