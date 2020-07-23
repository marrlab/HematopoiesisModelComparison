function [data,theta_test,rate_names_test] = getSimulatedData(opt,i_ID)

        %a) simulate from model
        cd(opt.foldername)
        load(['insilico_data_',opt.model_sim,'_',opt.noiseType,'_',opt.nL,'_individual_',opt.individuals{i_ID}],'data','theta_test','rate_names_test');
        cd(opt.c_path);

end