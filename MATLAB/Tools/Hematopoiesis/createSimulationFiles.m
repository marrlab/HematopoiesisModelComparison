function [] = createSimulationFiles(opt,bool_simulate,model)
    if bool_simulate
        currentDir = cd;
        %% adapt AMICI model file
        adaptModelFile_AMICI(model,opt,opt.iS_ID)
        %% run respective generating file 
        cd(fullfile(opt.a_path,'hematopoiesis'));
%          disp(strcat(opt.a_path,'hematopoiesis/'));
%          disp([model,'_',num2str(opt.n_intermediateStates(opt.iS_ID)),'()']);
         try
            eval([model,'_',num2str(opt.n_intermediateStates(opt.iS_ID)),'()']);
         catch
            error(['this model scheme(',model,'_',num2str(opt.n_intermediateStates(opt.iS_ID)),') is not implemented. Go to updateModelParams()!'])
         end
        cd(currentDir);
    end
end