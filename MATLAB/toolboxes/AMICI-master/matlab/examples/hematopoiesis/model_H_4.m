
%%
% COMPILATION

[exdir,~,~]=fileparts(which('model_H_4.m'));
% compile the model
amiwrap('model_H_4','model_H_4_syms',exdir)
% add the model to the path
addpath(genpath([strrep(which('amiwrap.m'),'amiwrap.m','') 'models/model_H_4']))

