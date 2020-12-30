clear;
clc;
close all;

%% 1. specify settings
[opt,model_str] = getSISettings();

for i = 1:length(model_str)
    [~,~,opt] = getModelParams(opt,model_str{i}); 
    opt.n_initialConds = 1;
    adaptModelFile_SI(model_str{i},opt)
end

cd(opt.structIdent_path)
cd('../')
clearvars -except i model_str opt;

for i = 1:length(model_str)
    %% 2. Modify file options.m
    % make sure 'modelname = 'hematopoiesis_model_X';' is the specified option.
    current_dir = cd();
    adaptOptionsFile(model_str{i},opt);
    %% 3. run sim file
    eval(['z_create_hematopoiesis_',model_str{i}]);
    %% 4. run structural identifiability analysis STRIKE_GOLDD.m
    STRIKE_GOLDD
    %results will be printed to console and stored in results folder
    cd(current_dir);
end

function [opt,model_str] = getSISettings()
    opt = setPaths();
    opt.modelStates = {'HSC','MPP','MLP','CMP','GMP','MEP','mat'};
    model_str={'model_J'};%'model_A','model_B','model_C','model_D','model_E','model_F','model_G','model_H','model_I',
    opt.models_implemented = {'model_A','model_B','model_C','model_D','model_E','model_F','model_G','model_H','model_I','model_J'};
    opt.n_intermediateStates = 3;%1;%
    opt.iS_ID = 1;
    % for fitting number of divisions:
    opt.n_divStates = 1;%7;
    if opt.n_divStates>1
        opt.modelAccumulateInLastState = true;
    else
        opt.modelAccumulateInLastState = false;
    end
    opt.n_repetitions=1;

    opt.structuralIdentifiability=true;
    opt.realdata=false;
    opt.optimizationMode = 'hierarchical';
    opt.parScale='log10';
    opt.fitDeadCells=false;
    opt.fitInitialConds=true;
    opt.n_initialConds_N=1;
    
    function [opt] = setPaths()
        opt.c_path = cd;
        cd('../');
        path1=cd;
        addpath(genpath(fullfile(path1,'utils')));
        addpath(genpath(fullfile(path1,'toolboxes')));
        addpath(genpath(fullfile(path1,'toolboxes','AMICI-master')));
        opt.a_path = fullfile(path1,'toolboxes','AMICI-master','matlab','examples');
        opt.structIdent_path = fullfile(path1,'toolboxes','STRIKEGOLDD','STRIKE-GOLDD','models');
        opt.pythonDataVisualization_path = fullfile(opt.c_path);
        cd(opt.c_path);
    end
end

function [CD] = adaptOptionsFile(m_str,opt)
    cd(opt.structIdent_path);
    cd('../')
    FileName = 'options.m';
    str = fileread(FileName);
    T2 = textread(FileName, '%s', 'delimiter', '\n','bufsize', max(size(str)));
    modelname = ['hematopoiesis_',m_str];
    T2(8) = { ['modelname = ','"',modelname,'";'] };
    FID = fopen(FileName, 'wb');
    if FID < 0 
        error('Cannot open file.'); 
    end
    fprintf(FID, '%s\n', T2{:});
    fclose(FID);
end


