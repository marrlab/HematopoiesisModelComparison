opt = setPaths();

%% 1. specify settings
[opt,model_str] = getAppSettings(opt);

for i = 1:length(model_str)
    [~,~,opt] = getModelParams(opt,model_str{i}); 
    opt.n_initialConds = 1;
    adaptModelFile_SI(model_str{i},opt)
end

cd(opt.structIdent_path)

z_create_hematopoiesis_model_A
z_create_hematopoiesis_model_B
z_create_hematopoiesis_model_C
z_create_hematopoiesis_model_D
z_create_hematopoiesis_model_E
z_create_hematopoiesis_model_F
z_create_hematopoiesis_model_G
z_create_hematopoiesis_model_H
z_create_hematopoiesis_model_I
z_create_hematopoiesis_model_J

cd('../')

%% 2. Open file options.m
% make sure 'modelname = 'hematopoiesis_model_X';' is the specified option.

%% 3. Open and run file STRIKE_GOLDD.m
STRIKE_GOLDD
%results will be printed to console and stored in results folder





