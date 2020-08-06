

%%
% COMPILATION

[exdir,~,~]=fileparts(which('model_D_5.m'));
% compile the model
amiwrap('model_D_5','model_D_5_syms',exdir)
% add the model to the path
addpath(genpath([strrep(which('amiwrap.m'),'amiwrap.m','') 'models/model_D_5']))

