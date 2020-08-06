%% critical values for model selection criteria
clear;
clc;
close all;
% % 1) LRT
% LS = {'--','-',':'};
% p = [0.01, 0.05, 0.1]; %// probability (i.e. quantile)
d_npar = 1:6; %difference in number of parameters %// degrees of freedom (difference in number of parameters)
% n = 0; %// non-centrality parameter. Set to 0 to generate the provided table
% for i=1:length(p)
%     for j=1:length(d_npar)
%         crit_LRT(i,j) = ncx2inv(1-p(i), d_npar(j), n);
%     end
%     plot([1:length(d_npar)],crit_LRT(i,:),'k','LineStyle',LS{i},'Marker','o','Displayname',['LRT for \alpha = ',num2str(p(i))],'LineWidth',2);
%     hold on;
% end

% 2) AIC
for j=1:length(d_npar)
    crit_AIC(j) = 10+2*d_npar(j); 
end
plot([1:length(d_npar)],crit_AIC,'color',[0 0.05 0.7],'LineStyle','-','Marker','o','Displayname','AIC','LineWidth',2);
hold on;


% 2) AIC_c
n_par_1 =[21,27]; % the more parameter the more conservative
n_obs = [49*3, 49*7];
LS = {'--','-'};
C = {'indian red','deep carrot orange'};
for id_i = 1:length(n_par_1)
    for id_k = 1:length(n_obs)
        for id_j=1:length(d_npar)
            n_par_2(id_i,id_j) = n_par_1(id_i)+d_npar(id_j);
            crit_AIC_c(n_par_2(id_i,id_j)-n_par_1(id_i),(id_k-1)*length(n_obs)+id_i) = 10+2*(n_par_2(id_i,id_j)+((n_par_2(id_i,id_j)*(n_par_2(id_i,id_j)-1))/(n_obs(id_k)-n_par_2(id_i,id_j)-1)) - n_par_1(id_i)-((n_par_1(id_i)*(n_par_1(id_i)-1))/(n_obs(id_k)-n_par_1(id_i)-1)));
            if id_j==length(d_npar)
                DN = ['AIC_c for ', num2str(n_obs(id_k)),' observations and ',num2str(n_par_1(id_i)),' parameters'];
                plot(1:length(d_npar),crit_AIC_c(:,(id_k-1)*length(n_obs)+id_i),'color',rgb(C{id_i}),'LineStyle',LS{id_k},'Marker','o','Displayname',DN,'LineWidth',2);
            end
        end
    end
end

% 3) BIC
for i=1:length(n_obs)
    for j=1:length(d_npar)
        crit_BIC(i,j) = 10+log(n_obs(i))*d_npar(j); 
    end
    plot([1:length(d_npar)],crit_BIC(i,:),'color',[0,0.7,0.7],'LineStyle',LS{i},'Marker','o','Displayname',['BIC for ', num2str(n_obs(i)),' observations'],'LineWidth',2);
    hold on;
end
xlabel('Difference in number of parameters','FontSize',22)
ylabel('Critical value','FontSize',22)
set(gca,'FontSize',17);
L = legend('show');
L.FontSize = 17;