function [] = test_and_plot_Gradient(parameters,logL,opt,i_ID)
    xi = (parameters.max+parameters.min).*2./3;
    [g,g_fd_f,g_fd_b,g_fd_c] = testGradient(xi,@(xi) logL(xi),1e-10);
    disp([g_fd_f,g_fd_b,g_fd_c,g]);
    figure()
    plot(g_fd_c-g,'-ob','LineWidth',2); hold on;
    plot(g_fd_f-g,':og'); hold on;
    plot(g_fd_b-g,':og'); hold on;
    plot(0:length(g)+1,zeros(1,length(g)+2),'k--');
    fig_str = strcat('Gradient_check_',opt.group,'_individual',opt.individuals{i_ID});
    saveFigures(opt,false,fig_str);
end
     