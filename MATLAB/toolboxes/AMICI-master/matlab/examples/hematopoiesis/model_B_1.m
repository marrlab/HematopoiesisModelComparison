

%%
% COMPILATION

[exdir,~,~]=fileparts(which('model_B_1.m'));
% compile the model
amiwrap('model_B_1','model_B_1_syms',exdir)
% add the model to the path
addpath(genpath([strrep(which('amiwrap.m'),'amiwrap.m','') 'models/model_B_1']))

