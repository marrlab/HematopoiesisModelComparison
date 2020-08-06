
%%
% COMPILATION

[exdir,~,~]=fileparts(which('model_J_3.m'));
% compile the model
amiwrap('model_J_3','model_J_3_syms',exdir)
% add the model to the path
addpath(genpath([strrep(which('amiwrap.m'),'amiwrap.m','') 'models/model_J_3']))

