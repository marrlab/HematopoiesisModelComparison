
%%
% COMPILATION

[exdir,~,~]=fileparts(which('model_I_4.m'));
% compile the model
amiwrap('model_I_4','model_I_4_syms',exdir)
% add the model to the path
addpath(genpath([strrep(which('amiwrap.m'),'amiwrap.m','') 'models/model_I_4']))

