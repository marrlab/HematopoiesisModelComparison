function [AIC,AIC_corrected,BIC,logL] = getModelSelectionScores(npar,logL_vec,opt,obj_type,ListOfIndividuals,individual,opt_individuals,group_str)

AIC=[];
AIC_corrected=[]; 
BIC=[];

possibleCompartments = opt.modelStates;

nobs = 0;
switch opt_individuals
    case 'all'
       for individual_i = 1:length(ListOfIndividuals) 
           [nobs] = getNobsForListOfIndividuals(nobs,opt,ListOfIndividuals,individual_i,possibleCompartments,group_str{individual_i});
       end
       np = npar*length(ListOfIndividuals);
       logL=sum(logL_vec);
    case 'single'
       [nobs] = getNobsForListOfIndividuals(nobs,opt,ListOfIndividuals,individual,possibleCompartments,group_str);
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
end
       
function [nobs] = getNobsForListOfIndividuals(nobs,opt,ListOfIndividuals,individual,possibleCompartments,group_str)
    if opt.realdata == true
        opt.exportData4Monolix=false;
        [data] = getObsData(group_str,opt.modelStates,ListOfIndividuals,individual,opt,possibleCompartments);
    else
        switch opt.RUN
            case 'test_inference_procedure'
                load(['insilico_data_',opt.model_sim,'_',opt.noiseType,'_',opt.nL,'_individual_',ListOfIndividuals{individual},'_test.mat'],'data');
            case 'topology_comparison_BIC'
                load(['insilico_data_',opt.model_sim,'_',opt.noiseType,'_',opt.nL,'_individual_',ListOfIndividuals{individual},'_topology_BIC.mat'],'data');
            case 'topology_comparison_L1'
                load(['insilico_data_',opt.model_sim,'_',opt.noiseType,'_',opt.nL,'_individual_',ListOfIndividuals{individual},'_topology_L1.mat'],'data');
        end
    end
    if opt.n_divStates>1
%         disp(ListOfIndividuals{individual})
%         disp(opt.model)
%         disp(group_str)
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