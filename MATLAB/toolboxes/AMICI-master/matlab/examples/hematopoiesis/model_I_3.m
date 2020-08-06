
%%
% COMPILATION

[exdir,~,~]=fileparts(which('model_I_3.m'));
% compile the model
amiwrap('model_I_3','model_I_3_syms',exdir)
% add the model to the path
addpath(genpath([strrep(which('amiwrap.m'),'amiwrap.m','') 'models/model_I_3']))

