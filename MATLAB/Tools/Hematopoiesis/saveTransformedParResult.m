function [par_min,par_max,CI_lower,CI_upper,PAR_OPT_T,PAR_TEST_T] = saveTransformedParResult(parameters,par_min,par_max,CI_lower,CI_upper,individuals_str,PAR_OPT_T,PAR_TEST_T,transformation_str,opt,theta_test,i_ID,rate_names_test)
    for ts_ID=1:length(transformation_str)
        if ~opt.realdata && strcmp(opt.model_sim,opt.model)
            [par_min(ts_ID,:,i_ID), par_max(ts_ID,:,i_ID), CI_lower(ts_ID,:,i_ID), CI_upper(ts_ID,:,i_ID), PAR_OPT_T(ts_ID,:,i_ID), PAR_TEST_T(ts_ID,:,i_ID), rate_names_opt] = getTransformedResults(parameters,theta_test,opt,transformation_str{ts_ID});
        else
            [par_min(ts_ID,:,i_ID), par_max(ts_ID,:,i_ID), CI_lower(ts_ID,:,i_ID), CI_upper(ts_ID,:,i_ID), PAR_OPT_T(ts_ID,:,i_ID), ~ , rate_names_opt] = getTransformedResults(parameters,[],opt,transformation_str{ts_ID});
        end
    end
    cd(['./',opt.foldername,'/',opt.subfoldername,'/',opt.subsubfoldername]);
    if opt.realdata==false
        f_str = '';
    else
        f_str = opt.group;
    end
    save(['ws_parameters_',f_str,'.mat'],'par_min','par_max','CI_lower','CI_upper','PAR_OPT_T','PAR_TEST_T','rate_names_opt','rate_names_test','transformation_str','individuals_str');
    cd(opt.c_path);
end

function [par_min, par_max, CI_lower, CI_upper, PAR_OPT, PAR_TEST, rate_names_opt] = getTransformedResults(parameters,theta_test,opt,opt_parScalePlot)
    if opt.PLcalculation
        CI_lower = parameters.CI.PL(:,1,parameters.CI.alpha_levels==0.95);
        CI_upper = parameters.CI.PL(:,2,parameters.CI.alpha_levels==0.95);
    else
        CI_lower = parameters.CI.local_PL(:,1,parameters.CI.alpha_levels==0.95);
        CI_upper = parameters.CI.local_PL(:,2,parameters.CI.alpha_levels==0.95);
    end
    
    if strcmp(opt.parScale,'none')
       par_opt_lin = parameters.MS.par(:,1);
       if opt.realdata==false && ~isempty(theta_test)
            par_test_lin = theta_test;
       end
       parameters_min=parameters.min;
       parameters_max=parameters.max;
    else
       par_opt_lin = transformParBack(parameters.MS.par(:,1),opt);
       if opt.realdata==false && ~isempty(theta_test)
            par_test_lin = transformParBack(theta_test,opt);
       end
       ci_lower=transformParBack(CI_lower,opt);
       ci_upper=transformParBack(CI_upper,opt);
       parameters_min=transformParBack(parameters.min,opt);
       parameters_max=transformParBack(parameters.max,opt);
    end
    switch opt_parScalePlot
        case 'lin'
            par_min = parameters_min(~strwcmp(opt.rates,'x0_*'));
            par_max = parameters_max(~strwcmp(opt.rates,'x0_*'));
            CI_upper = min(parameters_max(~strwcmp(opt.rates,'x0_*')),ci_upper(~strwcmp(opt.rates,'x0_*')));
            CI_lower = max(parameters_min(~strwcmp(opt.rates,'x0_*')),ci_lower(~strwcmp(opt.rates,'x0_*')));
            PAR_OPT = par_opt_lin(~strwcmp(opt.rates,'x0_*'));
            if opt.realdata==false && ~isempty(theta_test)
                PAR_TEST = par_test_lin(~strwcmp(opt.rates,'x0_*'));
            else
                PAR_TEST = nan*ones(size(PAR_OPT));
            end
        case 'log10'
            par_min = log10(parameters_min(~strwcmp(opt.rates,'x0_*')));
            par_max = log10(parameters_max(~strwcmp(opt.rates,'x0_*')));
            CI_upper = log10(min(parameters_max(~strwcmp(opt.rates,'x0_*')),ci_upper(~strwcmp(opt.rates,'x0_*'))));
            CI_lower = log10(max(parameters_min(~strwcmp(opt.rates,'x0_*')),ci_lower(~strwcmp(opt.rates,'x0_*'))));
            PAR_OPT = log10(par_opt_lin(~strwcmp(opt.rates,'x0_*')));
            if opt.realdata==false && ~isempty(theta_test)
                PAR_TEST = log10(par_test_lin(~strwcmp(opt.rates,'x0_*')));
            else
                PAR_TEST = nan*ones(size(PAR_OPT));
            end
        case 'ratio'
            par_min=1./parameters_max(~strwcmp(opt.rates,'x0_*'));
            par_max=1./parameters_min(~strwcmp(opt.rates,'x0_*'));
            CI_upper = 1./max(parameters_min(~strwcmp(opt.rates,'x0_*')),ci_lower(~strwcmp(opt.rates,'x0_*')));
            CI_lower = 1./min(parameters_max(~strwcmp(opt.rates,'x0_*')),ci_upper(~strwcmp(opt.rates,'x0_*')));
            PAR_OPT = 1./par_opt_lin(~strwcmp(opt.rates,'x0_*'));
            if opt.realdata==false && ~isempty(theta_test)
                PAR_TEST = 1./par_test_lin(~strwcmp(opt.rates,'x0_*'));
            else
                PAR_TEST = nan*ones(size(PAR_OPT));
            end
        otherwise
            error('the required setting for opt_parScalePlot is not implemented!')
    end   
    rate_names_opt=strtrim(opt.rates(~strwcmp(opt.rates,'x0_*')));
end