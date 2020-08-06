
%%
% COMPILATION

[exdir,~,~]=fileparts(which('model_H_3.m'));
% compile the model
amiwrap('model_H_3','model_H_3_syms',exdir)
% add the model to the path
addpath(genpath([strrep(which('amiwrap.m'),'amiwrap.m','') 'models/model_H_3']))

