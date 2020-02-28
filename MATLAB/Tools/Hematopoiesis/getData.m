function [data,opt] = getData(opt,i_ID,possibleCompartments,str)
    if opt.realdata==true
        [data] = getObsData(opt.group,opt.modelStates,opt.individuals,i_ID,opt,possibleCompartments);
        % update opt as opt.rates might have changed due to
        % change in number of initial conditions
        opt = updateOptions(data,opt);
    else
        %a) simulate from model
        load(['insilico_data_',opt.model_sim,'_',opt.noiseType,'_',opt.nL,'_individual_',opt.individuals{i_ID},str],'data');
        %save for later under right directory
        cd(opt.foldername)
        save(['insilico_data_',opt.model_sim,'_',opt.noiseType,'_',opt.nL,'_individual_',opt.individuals{i_ID},str],'data');
        cd(opt.c_path);
    end
end