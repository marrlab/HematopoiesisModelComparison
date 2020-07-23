
%%
% COMPILATION

[exdir,~,~]=fileparts(which('model_E_5.m'));
% compile the model
amiwrap('model_E_5','model_E_5_syms',exdir)
% add the model to the path
addpath(genpath([strrep(which('amiwrap.m'),'amiwrap.m','') 'models/model_E_5']))

