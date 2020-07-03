function [parameters] = optimizationProc(options_par,parameters,logL,logL_final,opt,individual_i)
    num_individual = opt.individuals{individual_i};
    if strcmp(options_par.comp_type,'parallel') && (opt.n_workers >= 2)
        parpool(opt.n_workers);
    end
    % set seed
    rng(1256);
    parameters = getMultiStarts(parameters,logL,options_par);
    
    % for storing values of sigma for optimal parameter:
    if strcmp(opt.optimizationMode,'hierarchical')
        logL_final(parameters.MS.par(:,1))
    end
    if opt.save
        saveFigures(opt,false,['MS_optimization_',opt.group,'_individual_',num_individual])
        cd(opt.c_path)
        cd(['./',opt.foldername,'/',opt.subfoldername,'/',opt.subsubfoldername])
        save(['WS_MSopt_',opt.group,'_individual_',num_individual,'.mat'])
        cd(opt.c_path)
    else
        close all;
    end
    if strcmp(options_par.comp_type,'parallel') && (opt.n_workers >= 2)
        delete(gcp);
        options_par.comp_type = 'sequential'; options_par.mode = 'visual'; opt.n_workers = 1;
    end
    if opt.PLcalculation == true
        %% parameters describing initial conditions
        for i=1:length(parameters.min)
            options_par.parameter_index = i;
            options_par.options_getNextPoint.min = (parameters.max(i)-parameters.min(i))/100;
            options_par.options_getNextPoint.max = (parameters.max(i)-parameters.min(i))/50;
            options_par.options_getNextPoint.guess = (parameters.max(i)-parameters.min(i))/75;
            parameters = getParameterProfiles(parameters,logL,options_par);
            if opt.save
                saveFigures(opt,'false',['Profile_Likelihood_individual_',num_individual,'_',parameters.name{i}]);
            else
                close all;
            end
        end

        if opt.save
            cd(opt.c_path)
            cd(['./',opt.foldername,'/',opt.subfoldername,'/',opt.subsubfoldername])
            save(['WS_PL_',opt.group,'_individual_',num_individual,'.mat'])
            cd(opt.c_path)
        end
        
    end
    parameters = getParameterConfidenceIntervals(parameters,opt.CI_levels);
    if opt.save
        saveFigures(opt,'false',['CI_individual_',num_individual]);
    else
        close all;
    end
end