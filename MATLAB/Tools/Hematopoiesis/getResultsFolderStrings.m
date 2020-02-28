function [opt] = getResultsFolderStrings(opt)

%opt.foldername and opt.subfoldername are changed in case option is set to
%initialize

%j_sim: model scheme used for simulations index
%j: model scheme used for fit index

HO_str = '';
if strwcmp(opt.optimizationMode,'hierarchical')
    HO_str = '_HO';
end        
if opt.realdata==false && strcmp(opt.RUN,'hierarchy_comparison_BIC')
    test_str = '_test';
else
    test_str = '';
end
opt.foldername = [strcat('results_',opt.RUN),test_str,'_',num2str(opt.n_divStates),'divs_',num2str(opt.n_intermediateStates(opt.iS_ID)),'iS',HO_str,'_',opt.noiseType];

if opt.applyNoise
    if iscell(opt.noiseLevel)
        noiseLevel = strjoin(opt.noiseLevel,'_');
    else
        noiseLevel = opt.noiseLevel;
    end
else
    noiseLevel = '';
end
if ~opt.realdata 
    if strcmp(opt.RUN,'hierarchy_comparison_BIC')
        opt.foldername = [opt.foldername,'_simulatedFrom_',opt.model_sim,'_',noiseLevel];
    else
        opt.foldername = [opt.foldername,'_',noiseLevel];
    end
end
if opt.fitInitialConds && ~strwcmp(opt.foldername,'*_fit_iC*')
   opt.foldername = [opt.foldername,'_fit_iC'];  
end
opt.subfoldername = [opt.model,'_model'];

end