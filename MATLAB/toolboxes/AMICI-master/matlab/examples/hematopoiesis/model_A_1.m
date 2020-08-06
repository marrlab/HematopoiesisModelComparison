
%%
% COMPILATION

[exdir,~,~]=fileparts(which('model_A_1.m'));
% compile the model
amiwrap('model_A_1','model_A_1_syms',exdir)
% add the model to the path
addpath(genpath([strrep(which('amiwrap.m'),'amiwrap.m','') 'models/model_A_1']))

