function [] = saveFigures(opt,filename)
    cd(opt.c_path);
    cd(['./',opt.foldername,'./',opt.subfoldername,'./',opt.subsubfoldername]);
    h = get(0,'children');
    for i3=1:length(h)
      savefig(h(i3), [filename '_' num2str(i3)],'compact');
      saveas(h(i3), [filename '_' num2str(i3)], 'png');
    end
    close all;
    cd(opt.c_path)
end