
%%
% COMPILATION

[exdir,~,~]=fileparts(which('model_J_5.m'));
% compile the model
amiwrap('model_J_5','model_J_5_syms',exdir)
% add the model to the path
addpath(genpath([strrep(which('amiwrap.m'),'amiwrap.m','') 'models/model_J_5']))

