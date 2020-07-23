function [opt] = updatePaths(opt,i_ID)
    if (opt.applyNoise && iscell(opt.noiseLevel))
        opt.subsubfoldername = ['individual_',opt.individuals{i_ID},'_',opt.nL,'_noise'];
    else
        opt.subsubfoldername = ['individual_',opt.individuals{i_ID}];
    end
    createResultDirs(opt.c_path,opt.foldername,opt.subfoldername,opt.subsubfoldername);

    function [] = createResultDirs(c_path,foldername,subfoldername,subsubfoldername)
        cd(c_path)
        %% add subfolder path
        if exist(foldername, 'dir')==0 
            mkdir(foldername);
        end
        % make sure path for results exists

        if ~isempty(subfoldername)
            cd(['./',foldername]);
            if exist(subfoldername, 'dir')==0 
                mkdir(subfoldername);
            end
            cd(['./',subfoldername]);
            if ~isempty(subsubfoldername)
                if exist(subsubfoldername, 'dir')==0 
                    mkdir(subsubfoldername);
                end
            end
        end
        cd(c_path)
    end
end