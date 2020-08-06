
%%
% COMPILATION

[exdir,~,~]=fileparts(which('model_C_5.m'));
% compile the model
amiwrap('model_C_5','model_C_5_syms',exdir)
% add the model to the path
addpath(genpath([strrep(which('amiwrap.m'),'amiwrap.m','') 'models/model_C_5']))

