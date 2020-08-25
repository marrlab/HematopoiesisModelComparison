    function [AIC,AIC_corrected,BIC,logL] = calculateModelSelectionScores(npar,logL_vec,opt,obj_type,ListOfIndividuals,individual_ID,opt_individuals)

        AIC=[];
        AIC_corrected=[]; 
        BIC=[];

        nobs = 0;
        switch opt_individuals
            case 'all individuals'
               for individual_i = 1:length(ListOfIndividuals) 
                   [nobs] = getNobsForListOfIndividuals(nobs,opt,ListOfIndividuals,individual_i);
               end
               np = npar*length(ListOfIndividuals);
               logL=sum(logL_vec);
            case 'single individuals'
               [nobs] = getNobsForListOfIndividuals(nobs,opt,ListOfIndividuals,individual_ID);
               np=npar;
               logL=logL_vec;
        end

        if strcmp(obj_type,'log-posterior')
            AIC= -2*logL+2*np;
            BIC= -2*logL+np*log(nobs);
        elseif strcmp(obj_type,'negative log-posterior')
            AIC= 2*logL+2*np;
            BIC= 2*logL+np*log(nobs);
        else
            error('Go to getModelSelectionScores() and implement score calculation for specified obj_type!')
        end
        AIC_corrected= AIC+(2*np^2+2*nobs)/(nobs-np-1);

        function [nobs] = getNobsForListOfIndividuals(nobs,opt,ListOfIndividuals,individual_ID)
            if opt.realdata == true
                [data] = getExperimentalData(individual_ID,opt);
            else
                cd(opt.foldername)
                load(['insilico_data_',opt.model_sim,'_',opt.noiseType,'_',opt.nL,'_individual_',ListOfIndividuals{individual_ID},'.mat'],'data');
                cd('../')
            end
            if opt.n_divStates>1
                yd = data.NumCellDiv_ALL;
            else
                yd = data.ym;
            end
            [a,b]=size(yd);
            for a_idx=1:a
                for b_idx=1:b
                    [r,c]=size(yd{a_idx,b_idx});
                    nobs =nobs+r*c;
                end
            end
        end
    end