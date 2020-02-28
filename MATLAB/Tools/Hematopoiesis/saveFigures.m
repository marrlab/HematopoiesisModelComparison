function [] = saveFigures(opt,saveVars,filename)

    cd(opt.c_path);
    if ~exist(opt.foldername, 'dir')
        mkdir(opt.foldername);
    end
    cd(strcat('./',opt.foldername));
    if ~isempty(opt.subfoldername)
        if ~exist(opt.subfoldername, 'dir')
            mkdir(opt.subfoldername);
        end
        cd(strcat('./',opt.subfoldername));
        if ~isempty(opt.subsubfoldername)
            if ~exist(opt.subsubfoldername, 'dir')
                mkdir(opt.subsubfoldername);
            end
            cd(strcat('./',opt.subsubfoldername));
        end
    end
    h = get(0,'children');
    for i3=1:length(h)
      savefig(h(i3), [filename '_' num2str(i3)],'compact');
      saveas(h(i3), [filename '_' num2str(i3)], 'png');
    end
    close all;
    cd(opt.c_path)
end