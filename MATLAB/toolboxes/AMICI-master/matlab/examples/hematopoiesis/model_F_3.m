
%%
% COMPILATION

[exdir,~,~]=fileparts(which('model_F_3.m'));
% compile the model
amiwrap('model_F_3','model_F_3_syms',exdir)
% add the model to the path
addpath(genpath([strrep(which('amiwrap.m'),'amiwrap.m','') 'models/model_F_3']))

