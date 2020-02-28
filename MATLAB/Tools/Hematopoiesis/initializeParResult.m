function [par_min,par_max,CI_lower,CI_upper,PAR_OPT_T,PAR_TEST_T] = initializeParResult(transformation_str,opt,theta_test)
    par_min = zeros(length(transformation_str),length(opt.rates(~strwcmp(opt.rates,'x0_*'))),opt.n_individuals);
    par_max = zeros(length(transformation_str),length(opt.rates(~strwcmp(opt.rates,'x0_*'))),opt.n_individuals);
    CI_lower = zeros(length(transformation_str),length(opt.rates(~strwcmp(opt.rates,'x0_*'))),opt.n_individuals);
    CI_upper = zeros(length(transformation_str),length(opt.rates(~strwcmp(opt.rates,'x0_*'))),opt.n_individuals);
    PAR_OPT_T = zeros(length(transformation_str),length(opt.rates(~strwcmp(opt.rates,'x0_*'))),opt.n_individuals);
    if ~opt.realdata && strcmp(opt.model_sim,opt.model)
            PAR_TEST_T = zeros(length(transformation_str),length(theta_test)-opt.n_initialConds_N*length(opt.modelStates),opt.n_individuals);
    else
        PAR_TEST_T = [];
    end
end