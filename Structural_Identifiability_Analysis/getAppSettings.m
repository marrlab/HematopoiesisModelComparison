function [opt,model_str] = getAppSettings(opt)

model_str={'model_A','model_B','model_C','model_D','model_E','model_F','model_G','model_H','model_I','model_J'};
opt.models_implemented = {'model_A','model_B','model_C','model_D','model_E','model_F','model_G','model_H','model_I','model_J'};

opt.n_intermediateStates = 1:5;
opt.iS_ID = find(opt.n_intermediateStates==3); %model with 3 intermediate states
% for fitting number of divisions:
opt.n_divStates = 7;
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

end