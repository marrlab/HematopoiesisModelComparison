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