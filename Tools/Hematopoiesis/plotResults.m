function [] = plotResults(theta_test,theta_opt,data,opt,n_y,individualID,sigma_HO)
%plot QQ plot of residuals:
% y=data.ym{idx};
% [sol] = sim_H(y0,time_events,data.t{idx},par(1,:),'false',' ',opt.model,opt.scale);
% ym=sol.y;
% res=(y-ym)./par(1,end);
% figure(4); 
% qqplot(reshape(res,size(res,1)*size(res,2),1));
bool_figAlreadyExists = false;

if opt.fit_repetitions_seperately
    i_repe_start = opt.n_repetitions;
    i_repe_end = opt.n_repetitions;
else
    i_repe_start = 1;
    i_repe_end = opt.n_repetitions;
end
if ~isempty(theta_test)
    %% 1) overview figure
    h1=[];
    ind_e=1;
    for i_repe=i_repe_start:i_repe_end %index for data sets/ fits
        %figure('units','normalized','position',[0 0 1 0.8])
        counter=1;
        n_replicates = max(data.replicate(data.repetition==i_repe));
        for i_repl=1:n_replicates 
            D = getAndTransformDataSelection(data,opt,i_repe,i_repl);
            T_min=min(min(D.t));
            T_max=max(max(D.t))+24;
            t=T_min:1:T_max;
            %initial conditions for this repetition available??
            if opt.fitInitialConds %initial conditions were fit
                if opt.fit_repetitions_seperately
                    [sol_test_points] = sim_H([],D.t,[theta_test(1:n_y),theta_test(n_y+1:end)],opt.model_sim,opt,false,[],[]);
                    [sol_test] = sim_H([],t,[theta_test(1:n_y),theta_test(n_y+1:end)],opt.model_sim,opt,false,[],[]);
                    [sol_opt] = sim_H([],t,[theta_opt(1:n_y);theta_opt(n_y+1:end)]',opt.model,opt,false,[],[]);
                else
                    [sol_test_points] = sim_H([],D.t,[theta_test(1+n_y*(i_repe-1):i_repe*n_y),theta_test(opt.n_initialConds_N*n_y+1:end)],opt.model_sim,opt,false,[],[]);
                    [sol_test] = sim_H([],t,[theta_test(1+n_y*(i_repe-1):i_repe*n_y),theta_test(opt.n_initialConds_N*n_y+1:end)],opt.model_sim,opt,false,[],[]);
                    [sol_opt] = sim_H([],t,[theta_opt(1+n_y*(i_repe-1):i_repe*n_y);theta_opt(opt.n_initialConds_N*n_y+1:end)]',opt.model,opt,false,[],[]);
                end
            else 
                [sol_test_points] = sim_H(D.Y0,D.t,theta_test(:),opt.model_sim,opt,false,[],[]);
                [sol_test] = sim_H(D.Y0,t,theta_test,opt.model_sim,opt,false,[],[]);
                [sol_opt] = sim_H(D.Y0,t,theta_opt,opt.model,opt,false,[],[]);
            end
            switch opt.optimizationMode
                case 'hierarchical'
                    sigma_vec = sigma_HO(ind_e,:);%sigma_HO: repetition*replicates x n_observables 
                    if opt.plotCompartmentSum && opt.n_divStates>1
                        sigma = sigma_vec(1:opt.n_divStates:length(sigma_vec));
                    else 
                        sigma = sigma_vec;
                    end
                case 'standard'
                    theta_lin = transformParBack(theta_opt,opt);
                    sigma = sqrt(theta_lin(strcmp(opt.rates,'s')));
            end
            [counter,bool_figAlreadyExists] = plotModelVsData(opt,sol_test,sol_opt,t,D,sigma,counter,bool_figAlreadyExists,i_repe,i_repl,individualID);
        end
        ind_e = ind_e + 1;
    end
else
    ind_e = 1;
    for i_repe=i_repe_start:i_repe_end %index for data sets/ fits
        counter=1;
        n_replicates = max(data.replicate(data.repetition==i_repe));
        for i_repl=1:n_replicates 
            title_str = {['for \theta_{opt}, repetition:',num2str(i_repe),', replicate:',num2str(i_repl)]};
            [D] = getAndTransformDataSelection(data,opt,i_repe,i_repl);
            T_max=max(max(D.t))+24;
            t=0:0.1:T_max;
            %initial conditions for this repetition available??
            if opt.fitInitialConds%initial conditions were fit
                if opt.fit_repetitions_seperately
                    [sol_opt] = sim_H([],t,[theta_opt(1:n_y);theta_opt(n_y+1:end)]',opt.model,opt,false,[],[]);
                else
                    [sol_opt] = sim_H([],t,[theta_opt(1+n_y*(i_repe-1):i_repe*n_y);theta_opt(opt.n_initialConds_N*n_y+1:end)]',opt.model,opt,false,[],[]);
                end
            else 
                [sol_opt] = sim_H(D.Y0,t,theta_opt',opt.model,opt,false,[],[]);
            end
            switch opt.optimizationMode
                case 'hierarchical'
                    sigma_vec = sigma_HO(ind_e,:);%sigma_HO: repetition*replicates x n_observables 
                    if opt.plotCompartmentSum && opt.n_divStates>1
                        sigma = sigma_vec(1:opt.n_divStates:length(sigma_vec));
                    else 
                        sigma = sigma_vec;
                    end
                case 'standard'
                    if strcmp(opt.modelSigma,'NdivDependent')
                        s_min = theta_opt(end-1);
                        s_max = theta_opt(end);
                        s=2/opt.n_divStates;
                        n=-2;
                    else
                        theta_lin = transformParBack(theta_opt,opt);
                        sigma = sqrt(theta_lin(strcmp(opt.rates,'s')));
                    end
            end
            [counter,bool_figAlreadyExists] = plotModelVsData(opt,[],sol_opt,t,D,sigma,counter,bool_figAlreadyExists,i_repe,i_repl,individualID);
            if size(sigma_vec,1)>1
                ind_e=ind_e+1;
            end
        end
    end
end

end