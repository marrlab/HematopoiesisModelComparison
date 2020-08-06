function [par_min,par_max,CI_lower,CI_upper,PAR_OPT_T,PAR_TEST_T,logL_List] = initializeParameterResultMatrices(opt)
    par_min = zeros(length(opt.parTransformationStr),length(opt.rates(~strwcmp(opt.rates,'x0_*'))),opt.n_individuals);
    par_max = zeros(length(opt.parTransformationStr),length(opt.rates(~strwcmp(opt.rates,'x0_*'))),opt.n_individuals);
    CI_lower = zeros(length(opt.parTransformationStr),length(opt.rates(~strwcmp(opt.rates,'x0_*'))),opt.n_individuals);
    CI_upper = zeros(length(opt.parTransformationStr),length(opt.rates(~strwcmp(opt.rates,'x0_*'))),opt.n_individuals);
    PAR_OPT_T = zeros(length(opt.parTransformationStr),length(opt.rates(~strwcmp(opt.rates,'x0_*'))),opt.n_individuals);
    if ~opt.realdata && strcmp(opt.model_sim,opt.model)
        PAR_TEST_T = zeros(length(opt.parTransformationStr),length(opt.rates(~strwcmp(opt.rates,'x0_*'))),opt.n_individuals);
    else
        PAR_TEST_T = [];
    end
    logL_List = zeros(1,opt.n_individuals);
end