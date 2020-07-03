function [counter,bool_figAlreadyExists] = plotModelVsData(opt,sol_test,sol_opt,t,D,sigma,counter,bool_figAlreadyExists,i_repe,i_repl,individualID)
currentPath=cd();              
errorband_str = {'$$+/- 2\hat{\sigma}$$'};
cc=opt.c_map;

% cc_b=[255 204 204;
%     253 238 205;
%     210 253 227;
%     194 238 249;
%     204 229 255;
%     229 204 255;
%     204 255 255;
%     255 229 204;
%     233 233 233]./255;

cc_b=[255 204 204;
     253 238 205;
     204 229 255;
     229 204 255;
     210 253 227;
     205 246 255;
     255 255 204
     233 233 233]./255;

LS={'-','-.'};


if strwcmp(opt.noiseType,'Log*')
    if (~isempty(sol_opt))
        sol_opt.y = exp(sol_opt.y)-1;
    end
    if (~isempty(sol_test))
        sol_test.y = exp(sol_test.y)-1;
    end 
end


% plot model for test par
if ((opt.plotCompartmentSum && opt.n_divStates>1) || opt.n_divStates==1)
    %% all in one figure with subplots
    if (opt.plotCompartmentSum && opt.n_divStates>1) 
        if (~isempty(sol_test))
            S_test = sum(sol_test.y(:,1:opt.n_divStates),2); 
            dS = sum(strcmp(opt.modelStates,'D'));
            for k=2:length(opt.modelStates)-dS
                S_test = [S_test, sum(sol_test.y(:,(k-1)*opt.n_divStates+1:(k)*opt.n_divStates),2)];
            end
            if any(strcmp(opt.modelStates,'D'))
                S_test = [S_test,sol_test.y(:,end)]; 
            end
        end
        if (~isempty(sol_opt))
            S_opt = sum(sol_opt.y(:,1:opt.n_divStates),2);
            dS = sum(strcmp(opt.modelStates,'D'));
            for k=2:length(opt.modelStates)-dS
                S_opt = [S_opt, sum(sol_opt.y(:,(k-1)*opt.n_divStates+1:(k)*opt.n_divStates),2)];
            end
            if any(strcmp(opt.modelStates,'D'))
                S_opt = [S_opt,sol_opt.y(:,end)]; 
            end
        end
    else
        if (~isempty(sol_test))
            S_test = sol_test.y;
        end
        if (~isempty(sol_opt))
            S_opt = sol_opt.y;
        end
    end
    if (~isempty(sol_test))
        [S_test_T] = transformModelOutput(S_test,opt);
    else
        S_test_T = [];
    end
    if (~isempty(sol_opt))
        [S_opt_T] = transformModelOutput(S_opt,opt);
    else
        S_opt_T = [];
    end
    
    if opt.exportResults4Python    
        if (~isempty(sol_opt))
            [e_up,e_down] = getAndTransformErrorBand(S_opt,sigma,opt);
        else
            [e_up,e_down] = getAndTransformErrorBand(S_test,sigma,opt);
        end
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
        YD = D.Y_t;
        tD = D.t;
        trans = opt.dataType;
        states_str = opt.modelStates;
        ndivs = opt.n_divStates;
        if opt.plotCompartmentSum
            save(['ws_modelFitPlot_sum_',num2str(i_repe),num2str(i_repl),'.mat'],'S_opt_T','S_test_T','t','YD','tD','e_up','e_down','i_repe','i_repl','trans','states_str','ndivs','-v7');
        else
            save(['ws_modelFitPlot_',num2str(i_repe),num2str(i_repl),'.mat'],'S_opt_T','S_test_T','t','YD','tD','e_up','e_down','i_repe','i_repl','trans','states_str','ndivs','-v7');
        end
        cd(currentPath)
    else
        figure('units','normalized','position',[0 0 1 0.2])
        bool_figAlreadyExists = true;

        %% error band:
        for l=1:size(D.Y_t,2)
            subplot(1,size(D.Y_t,2),l)
            if strcmp(opt.optimizationMode,'hierarchical')
                s=sigma(l);
            else
                s=sigma;
            end
            if (~isempty(sol_opt)) || (~isempty(sol_test))
                if ~isempty(sol_opt)
                    [s_up,s_down] = getAndTransformErrorBand(S_opt(:,l),s,opt);
                else
                    [s_up,s_down] = getAndTransformErrorBand(S_test(:,l),s,opt);
                end
                [a,b] = size(t);
                if a>b; t = t'; end
                T_model=[t./24,fliplr(t./24)];%#create continuous x value array for plotting
                S_model=[s_down',fliplr(s_up')]';    
                h_fill = fill(T_model,S_model,cc_b(l,:));
                set(h_fill(1),'edgecolor','white');
                h1(1,l) = h_fill;
                hold on;
                id=2;
            else
                id=1;
            end

            %% data:
            h1(id,l) = plot(D.t./24,D.Y_t(:,l),'o','LineWidth',3,'MarkerSize',7,'Color',cc(l,:));
            hold on;
            id=id+1;

            %% plot detection limit
            plot(D.t./24,D.DL_t,'--','LineWidth',1,'MarkerSize',7,'Color',[150 150 150]./256);
            hold on;

            if ~isempty(sol_test)
                %% plot model(test par)
                h1(id,l) = plot(t./24,S_test_T(:,l),':','LineWidth',2,'Color',cc(l,:));
                hold on;
                id=id+1;
            end

           if (~isempty(sol_opt))
                %% model fit:
                h1(id,l) = plot(t./24,S_opt_T(:,l),'LineWidth',2,'Color',cc(l,:));
                hold on;
                id=id+1;
            end

            set(gca,'ColorOrderIndex',1);

            if opt.applyNoise
                title_str = {'for \theta_{test} with additional noise'};
            else
                title_str = {'for \theta_{test}'};
            end
            title(['solution of the ODE system ', title_str])
            xticks(min(D.t./24):1:max(D.t./24));
            xlim([min(D.t./24),max(D.t./24)]);
            ylabel([D.axis_str 'number of ' opt.modelStates{l} 's']);
            xlabel('Time in days')
        end
        if (~isempty(sol_opt)) || (~isempty(sol_test))
            L_str{1} = ['cells modeled ',errorband_str{:}, ' (error band)'];
            id=2;
        else 
            id=1;
        end
        L_str{id} = 'cells measured';
        if ~isempty(sol_test)
            L_str{id} = 'cells modeled (test parameter)';
            id=id+1;
        end
        if (~isempty(sol_opt))
            L_str{id} = 'cells modeled (optimized parameter)';
        end
        leg1 = legend(h1(:,1),L_str{:});
        set(leg1,'Interpreter','latex');
        set(leg1,'AutoUpdate','off');
        set(leg1,'FontSize',13);
    end
else
    if (~isempty(sol_opt))
        [S_opt_T] = transformModelOutput(sol_opt.y,opt);
    else
        S_opt_T = [];
    end
    if ~isempty(sol_test)
        [S_test_T] = transformModelOutput(sol_test.y,opt);
    else 
        S_test_T = [];
    end
    if opt.exportResults4Python
        if (~isempty(sol_opt))
            [e_up,e_down] = getAndTransformErrorBand(sol_opt.y,sigma,opt);
        else
            [e_up,e_down] = getAndTransformErrorBand(sol_test.y,sigma,opt);
        end
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
        YD = D.Y_t;
        tD = D.t;
        trans = opt.dataType;
        states_str = opt.modelStates;
        ndivs = opt.n_divStates;
        if opt.plotCompartmentSum
            save(['ws_modelFitPlot_sum',num2str(i_repe),num2str(i_repl),'.mat'],'S_opt_T','S_test_T','t','YD','tD','e_up','e_down','i_repe','i_repl','trans','states_str','ndivs','-v7');
        else
            save(['ws_modelFitPlot',num2str(i_repe),num2str(i_repl),'.mat'],'S_opt_T','S_test_T','t','YD','tD','e_up','e_down','i_repe','i_repl','trans','states_str','ndivs','-v7');
        end
        cd(currentPath)
    else
        h1=[];
        col_counter=0;
        for l=1:size(D.Y_t,2)
            if mod(l,opt.n_divStates)==1
                col_counter = col_counter+1;
                figure('units','normalized','position',[0 0 1 0.8])
                bool_figAlreadyExists = true;
                counter=1;
            end
            s_nr = mod(l,opt.n_divStates);
            if s_nr==0
                s_nr=opt.n_divStates;
            end
            subplot(3,4,s_nr)
            %% error band:
            if strcmp(opt.optimizationMode,'hierarchical')
                s=sigma(l);
            else
                s=sigma;
            end
            if (~isempty(sol_opt)) || (~isempty(sol_test))
                if ~isempty(sol_opt)
                    [s_up,s_down] = getAndTransformErrorBand(sol_opt.y(:,l),s,opt);
                else
                    [s_up,s_down] = getAndTransformErrorBand(sol_test.y(:,l),s,opt);
                end
                [a,b] = size(t);
                if a>b; t = t'; end
                T_model=[t./24,fliplr(t./24)];%#create continuous x value array for plotting
                S_model=[s_down',fliplr(s_up')]';    
                h_fill = fill(T_model,S_model,cc_b(col_counter,:));
                set(h_fill(1),'edgecolor','white');
                if counter==1
                    h1(1,col_counter) = h_fill;
                end
                hold on;
                id=2;
            else
                id=1;
            end

            if (~isempty(sol_opt))
                %% model fit:
                h1(id,col_counter) = plot(t./24,S_opt_T(:,l),'-','LineWidth',2,'Color',cc(col_counter,:));
                id=id+1;
                hold on;
            end

            if ~isempty(sol_test)
            %% plot model(test par) 
                h1(id,col_counter) = plot(t./24,S_test_T(:,l),':','LineWidth',2,'Color',cc(col_counter,:));
                id=id+1;
                hold on;
            end
            id_max=id;
        end

        col_counter=0;
        for l=1:size(D.Y_t,2)
            if mod(l,opt.n_divStates)==1
                col_counter = col_counter+1;
                figure(col_counter)
            end
            s_nr = mod(l,opt.n_divStates);
            if s_nr==0
                s_nr=opt.n_divStates;
            end
            subplot(3,4,s_nr)
            %% data:
            h1(id_max,col_counter) = plot(D.t./24,D.Y_t(:,l),'o','MarkerSize',7,'LineWidth',3,'Color',cc(col_counter,:));
            hold on;

            %detection limit
            plot(D.t./24,D.DL_t,'--','LineWidth',1,'Color',[150 150 150]./256);
            hold on

            if s_nr==1
                if (~isempty(sol_opt)) || (~isempty(sol_test))
                    id=2;
                    L_str{1} = [opt.modelStates{col_counter},' modeled ',errorband_str{:}, ' (error band)'];
                else
                    id=1;
                end
                if ~isempty(sol_opt)
                    L_str{id} = [opt.modelStates{col_counter},' modeled (optimized parameter)'];
                    id=id+1;
                end
                if ~isempty(sol_test)
                    L_str{id} = [opt.modelStates{col_counter},' modeled (test parameter)'];
                    id=id+1;
                end
                L_str{id} = [opt.modelStates{col_counter},' measured'];
                leg1 = legend(h1(:,col_counter),L_str{:});
                set(leg1,'Interpreter','latex');
                set(leg1,'AutoUpdate','off');
                set(leg1,'FontSize',13);
            end
            xlabel('Time in days')
            ylabel([D.axis_str 'number of ' opt.modelStates{col_counter} '_{' num2str(s_nr-1) '}s']);
            set(gca,'FontSize',14)
            %save last figure:
        end 
    end
end
if ~opt.exportResults4Python
    set(gca,'FontSize',16)
    if opt.save && bool_figAlreadyExists
        saveFigures(opt,true,strcat('resultingModel_',num2str(opt.n_divStates),'Divs_',opt.group,'_individual',individualID,'_repetition',num2str(i_repe),'_replicate',num2str(i_repl)));
    end
end

