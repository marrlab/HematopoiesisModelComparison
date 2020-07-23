
%%
% COMPILATION

[exdir,~,~]=fileparts(which('model_F_10.m'));
% compile the model
amiwrap('model_F_10','model_F_10_syms',exdir)
% add the model to the path
addpath(genpath([strrep(which('amiwrap.m'),'amiwrap.m','') 'models/model_F_10']))

