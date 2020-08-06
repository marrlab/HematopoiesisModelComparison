
%%
% COMPILATION

[exdir,~,~]=fileparts(which('model_G_4.m'));
% compile the model
amiwrap('model_G_4','model_G_4_syms',exdir)
% add the model to the path
addpath(genpath([strrep(which('amiwrap.m'),'amiwrap.m','') 'models/model_G_4']))

