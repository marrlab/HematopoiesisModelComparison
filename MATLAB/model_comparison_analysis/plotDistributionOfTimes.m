function [t] = plotDistributionOfTimes()
n=100;
%% plot distribution of times according to resulting rates:
time_means=20;
t=zeros(length(time_means),n);
F=5;
Y=0.05;
colors = [0 128 128; 128 0 128; 0 128 0; 255 69 0; 0 0 128]./255;
for n_is=1:5
    lambda=time_means;
    lambda_n = n_is/lambda;
    switch n_is
        case 1
            legend_str = ['PDF of exp(',num2str(time_means),') distribution'];
            t(n_is,:) = exprnd(lambda,1,n);
        otherwise
            legend_str = ['PDF of erlang(',num2str(n_is),',',num2str(n_is),'*',num2str(time_means),') distribution'];
            optDistr = 'erlang';
            rn_unif = unifrnd(0,1,n_is,n);
            t(n_is,:) = (-1/lambda_n)*log(prod(rn_unif,1));
    end
    figure(2)
    x=0:0.1:F*lambda;
    plot(x,(lambda_n^n_is.*x.^(n_is-1).*exp(-lambda_n.*x))./factorial(n_is-1),'color',colors(n_is,:),'LineWidth',2,'Displayname',legend_str);
    hold on;
    if n_is==5
        plot([lambda lambda],[0 Y],'k--','LineWidth',2,'Displayname',['mean = ',num2str(time_means)])
    end
end
L = legend('show');
L.FontSize = 17;

end