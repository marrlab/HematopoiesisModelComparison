
%%
% COMPILATION

[exdir,~,~]=fileparts(which('model_I_5.m'));
% compile the model
amiwrap('model_I_5','model_I_5_syms',exdir)
% add the model to the path
addpath(genpath([strrep(which('amiwrap.m'),'amiwrap.m','') 'models/model_I_5']))

