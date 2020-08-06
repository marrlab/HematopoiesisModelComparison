
%%
% COMPILATION

[exdir,~,~]=fileparts(which('model_A_5.m'));
% compile the model
amiwrap('model_A_5','model_A_5_syms',exdir)
% add the model to the path
addpath(genpath([strrep(which('amiwrap.m'),'amiwrap.m','') 'models/model_A_5']))

