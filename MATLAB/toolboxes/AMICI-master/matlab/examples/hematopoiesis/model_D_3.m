
%%
% COMPILATION

[exdir,~,~]=fileparts(which('model_D_3.m'));
% compile the model
amiwrap('model_D_3','model_D_3_syms',exdir)
% add the model to the path
addpath(genpath([strrep(which('amiwrap.m'),'amiwrap.m','') 'models/model_D_3']))

