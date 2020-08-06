

%%
% COMPILATION

[exdir,~,~]=fileparts(which('model_B_5.m'));
% compile the model
amiwrap('model_B_5','model_B_5_syms',exdir)
% add the model to the path
addpath(genpath([strrep(which('amiwrap.m'),'amiwrap.m','') 'models/model_B_5']))

