
%%
% COMPILATION

[exdir,~,~]=fileparts(which('model_E_3.m'));
% compile the model
amiwrap('model_E_3','model_E_3_syms',exdir)
% add the model to the path
addpath(genpath([strrep(which('amiwrap.m'),'amiwrap.m','') 'models/model_E_3']))

