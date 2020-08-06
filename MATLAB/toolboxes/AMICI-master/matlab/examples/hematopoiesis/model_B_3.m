

%%
% COMPILATION

[exdir,~,~]=fileparts(which('model_B_3.m'));
% compile the model
amiwrap('model_B_3','model_B_3_syms',exdir)
% add the model to the path
addpath(genpath([strrep(which('amiwrap.m'),'amiwrap.m','') 'models/model_B_3']))

