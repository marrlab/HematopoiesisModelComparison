
%%
% COMPILATION

[exdir,~,~]=fileparts(which('model_H_2.m'));
% compile the model
amiwrap('model_H_2','model_H_2_syms',exdir)
% add the model to the path
addpath(genpath([strrep(which('amiwrap.m'),'amiwrap.m','') 'models/model_H_2']))

