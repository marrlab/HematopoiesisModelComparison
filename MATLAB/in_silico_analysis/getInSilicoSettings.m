function [opt,model_str,j_end,j_sim_end,nl_end] = getInSilicoSettings()

opt = setPaths();
opt.RUN = 'hierarchy_comparison_BIC'; 
opt.structuralIdentifiability=false;

%% model simulation settings:
opt.modelStates = {'HSC','MPP','MLP','CMP','GMP','MEP','mat'};
opt.models_implemented = {'model_A','model_B','model_C','model_D','model_E','model_F','model_G','model_H','model_I','model_J'};
opt.model = opt.models_implemented{1}; %updated later, only for initialization
model_str = opt.models_implemented;

opt.fitDeadCells = false;%true;
opt.fitInitialConds=true;%false;
% for fitting number of divisions:
opt.n_divStates = 7;
if opt.n_divStates>1
    opt.modelAccumulateInLastState = true;
else
    opt.modelAccumulateInLastState = false;
end

% AMICI options:
opt.amiOptions = amioption('sensi',1,...
                           'maxsteps',1e9,...
                           'atol', 1e-8, ...
                           'rtol', 1e-6);
                       
%% parameter inference settings:
opt.fit_repetitions_seperately = true; 

%transformation of parameters during optimization:
% opt.parScale ='log10'; 
opt.parScale ='partly_log10'; %everything log10 transformed except initital conditions
% opt.parScale='none';

%constraints on parameters:
opt.applyParConstraints = false;

%noise model of logLikelihood:
% opt.noiseType = 'LogLaplace'; %--> issues with convergence
opt.noiseType = 'LogNormal'; %--> most appropriate

%profile likelihood and confidence intervals
opt.PLcalculation = false;% %calculation of profile likelihoods
opt.CI_levels = [0.9,0.95,0.99]; %levels for PL-confidence intervals

opt.optimizationMode = 'hierarchical';%'standard';%
opt.testGradient = false;%true;%

%% data used for fit:
opt.realdata = false;
j_sim_end = length(model_str); %last index for model schemes
j_end = length(model_str); %last index for model schemes
opt.model_sim = opt.models_implemented{1}; %only initialization, updated later
opt.t = [1,2,3,5,7]*24;%times at which in silico data should be observed in hours
opt.applyNoise = true;
opt.noiseLevel = {'strong'};%,'middle','weak','realistic'};
nl_end=length(opt.noiseLevel);
opt.n_individuals=5;
opt.n_replicates=1; %determine nr of samples
opt.n_repetitions=1;%determine nr of repititions (different initial conditions, but same rates)
opt.individuals = cellstr(num2str([1:opt.n_individuals]'));
opt.n_intermediateStates = 3;
opt.iS_ID = length(opt.n_intermediateStates); %index for intermediate state

if opt.fitInitialConds
    if opt.fit_repetitions_seperately
        opt.n_initialConds_N=1;
    elseif opt.realdata == false
        opt.n_initialConds_N = opt.n_repetitions;
    else
        opt.n_initialConds_N=1; %updated later
    end
else
    opt.n_initialConds_N=0;
end

opt.validation=false;

%% storing restructured data/ adapted simulation files/ results
opt.save = true;   
opt.parTransformationStr = {'lin','log10','ratio'}; %transformation of parameters in results array
opt.modelFitResultsTransformation = 'log2TotalNumbers'; %only important for model fit plot; 
% opt.modelFitResultsTransformation = 'totalNumbers';
% opt.modelFitResultsTransformation = 'logTotalNumbers';
% opt.modelFitResultsTransformation = 'log2TotalNumbers';
% opt.modelFitResultsTransformation = 'log10TotalNumbers';
% opt.modelFitResultsTransformation = 'percentages';

    function [opt] = setPaths()
        opt.c_path = cd;
        cd('../');
        path1=cd;
        addpath(genpath(fullfile(path1,'utils')));
        addpath(genpath(fullfile(path1,'toolboxes')));
        addpath(genpath(fullfile(path1,'toolboxes','AMICI-master')));
        opt.a_path = fullfile(path1,'toolboxes','AMICI-master','matlab','examples');
        opt.pythonDataVisualization_path = fullfile(opt.c_path);
        cd(opt.c_path);
    end

end

