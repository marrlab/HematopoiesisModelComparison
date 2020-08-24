function [] = adaptModelFileSI(model,opt)

opt.RUN = 'topology_comparison_BIC'; 
%% rates string without brackets
for i=1:length(opt.rates)
    rates_str{i} = strrep(opt.rates{i},'{','');
    rates_str{i} = strrep(rates_str{i},'}','');
    rates_str{i} = rates_str{i}(~isspace(rates_str{i}));
end
n_prolif = sum(strwcmp(rates_str,'b_*'));
n_diff = sum(strwcmp(rates_str,'a_*'));
n_death = sum(strwcmp(rates_str,'g_*'));

%% write .m file for structural identifiability analysis
if any(strcmp(model,opt.models_implemented))
    FileName2 = ['z_create_hematopoiesis_',model,'.m'];
else
    error('This model is not implemented. Go to adaptSymsFile!')
end
CD = cd();
cd(opt.structIdent_path);
str = fileread(FileName2);
T2 = textread(FileName2, '%s', 'delimiter', '\n','bufsize', max(size(str)));
cd(CD);

%% 1) Correct number of states (= opt.n_divStates * opt.n_intermediateStates(iS_ID) * (length(opt.modelStates)-1) +1 if strcmp(opt.modelStates,'D')
if opt.n_intermediateStates(opt.iS_ID)==1
    [T2_new] = adaptModelFileSInoIS(T2,opt,model,rates_str);
else
    [T2_new] = adaptModelFileSImultipleIS(T2,opt,opt.iS_ID,model,rates_str,n_prolif,n_diff,n_death);
end

cd(opt.structIdent_path);
FID = fopen(FileName2, 'wb');
if FID < 0 
    error('Cannot open file.'); 
end
fprintf(FID, '%s\n', T2_new{:});
fclose(FID);
cd(CD);

    function [T_new] = adaptModelFileSInoIS(T,opt,model,rates_str)
        T_new = T;
        %% header
        T_new(1) = {'% hematopoiesis model '};
        T_new(2) = {strcat('%',model)};
        T_new(3) = {'% Lisa Bast '};
        T_new(4) = {' '};
        T_new(5) = {'clearvars -except i model_str opt;'};
        T_new(6) = {' '};
        T_new(7) = {'%% states '};

        %% 1) states (= opt.n_divStates * (length(opt.modelStates)-1) +1 if strcmp(opt.modelStates,'D')
        if any(strcmp(opt.modelStates,'D'))
            mS = (length(opt.modelStates)-1);
            dS = 1;
        else
            mS = length(opt.modelStates);
            dS = 0;
        end
        n_states = opt.n_divStates * mS +dS;
        state_str2 = 'x = [';
        state_str1 = [];
        for i=1:n_states
            state_str1 = [state_str1, ' x', num2str(i)];
        end
        state_str=[state_str2,state_str1,'];'];
        T_new(8) = {['syms ',state_str1]};
        newline1 = {state_str};
        T_new(9)=newline1;
        T_new(10)={' '};

        %% 2) parameter vector
        T_new(11)={'%% unknown parameters'};
        if opt.fitInitialConds
            for i=1:mS+dS
                par_str1{i} = strcat('x0_',num2str(i));
                par_str2{i} = strcat(strcat('x0_',num2str(i)),';');
                ics_str{i} = strcat(strcat('x0_',num2str(i)),',');
            end
        else
            par_str1=[];
            par_str2=[];
        end
        par_str1 = [par_str1, rates_str(~strwcmp(rates_str,'x0*'))];
        par_str2 = [par_str2, strcat(rates_str(~strwcmp(rates_str,'x0*')),';')];
        newline1a = {['syms ', strjoin(par_str1)]};
        T_new(12)=newline1a;
        newline1b_str = ['p= [', strjoin(par_str2)];
        newline1b = {[newline1b_str(1:end-1),'];']};
        T_new(13)=newline1b;
        T_new(14)={' '};

        %% 3) input
        T_new(15)={'%% input'};
        newline1 = {'u=[];'};
        T_new(16)=newline1;
        T_new(17)={' '};

        %% 4) EQUATIONS
        T_new(18)={'%% dynamic equations'};
        T_new(19) = {'f=['};
        ID = 20;
        for j=1:n_states
            %% first state
            if (mod(j-1,opt.n_divStates)==0)
                id_state = (j-1)/(opt.n_divStates)+1;
                ID_D_o = find(strwcmp(rates_str,['*a_',opt.modelStates{id_state},'*']));
                diff_rates_o = [];
                if ~isempty(ID_D_o)
                    if length(ID_D_o)==1
                        diff_rates_o = rates_str{ID_D_o};
                    else
                        diff_rates_o{1} = rates_str{ID_D_o(1)};
                        diff_rates_o{2} = rates_str{ID_D_o(2)};
                    end
                end
                ID_D_i = find(strwcmp(rates_str,['a_*_',opt.modelStates{id_state},'*']));
                diff_rates_i = [];
                if ~isempty(ID_D_i)
                    if length(ID_D_i)==1
                        diff_rates_i = rates_str{ID_D_i};
                    else
                        diff_rates_i{1} = rates_str{ID_D_i(1)};
                        diff_rates_i{2} = rates_str{ID_D_i(2)};
                    end
                end
                ID_p = find(strwcmp(rates_str,['b_',opt.modelStates{id_state},'*']));
                if ~isempty(ID_p)
                    prolif_rate = rates_str{ID_p};
                else
                    prolif_rate = [];
                end
                ID_d = find(strwcmp(rates_str,['g_',opt.modelStates{id_state},'*']));
                if ~isempty(ID_d)
                    death_rate = ['+',rates_str{ID_d}];
                else
                    death_rate = [];
                end
                if isempty(diff_rates_o)
                        DR_out_str = '';
                elseif ischar(diff_rates_o)
                        DR_out_str = ['+',diff_rates_o];
                elseif iscell(diff_rates_o)
                        DR_out_str = ['+',diff_rates_o{1},'+',diff_rates_o{2}];
                end
                if isempty(diff_rates_i)
                        DR_in_str = '';
                elseif ischar(diff_rates_i)
                        source_state_ID = find(strcmp(opt.modelStates,diff_rates_i(3:5)));
                        DR_in_str = [diff_rates_i,'*x',num2str(j-(id_state-source_state_ID)*opt.n_divStates)];
                elseif iscell(diff_rates_i)
                        source_state1_ID = find(strcmp(opt.modelStates,diff_rates_i{1}(3:5)));
                        source_state2_ID = find(strcmp(opt.modelStates,diff_rates_i{2}(3:5)));
                        DR_in_str = [diff_rates_i{1},'*x',num2str(j-(id_state-source_state1_ID)*opt.n_divStates),'+',...
                                    diff_rates_i{2},'*x',num2str(j-(id_state-source_state2_ID)*opt.n_divStates)];
                end
                %first equation of each cell type:
                newline3 = {[DR_in_str,'-(',prolif_rate,DR_out_str,death_rate,')*x',num2str(j),';']};
            else
                DR_in_str = '';
                if ~isempty(diff_rates_i)
                    if ischar(diff_rates_i)
                        DR_in_str = ['+',diff_rates_i,'*x',num2str(j-(id_state-source_state_ID)*opt.n_divStates)];
                    elseif iscell(diff_rates_i)
                        DR_in_str = '+';
                        for ci=1:length(diff_rates_i)
                            DR_in_str = [DR_in_str,'+',diff_rates_i{ci},'*x',num2str(j-(id_state-source_state1_ID)*opt.n_divStates),'+'];
                        end
                    end
                end
                if (mod(j,opt.n_divStates)==0)
                    %last equation of each cell type
                    if opt.modelAccumulateInLastState 
                        newline3 = {['2*',prolif_rate,'*x',num2str(j-1),DR_in_str,'+2*',prolif_rate,'*x',num2str(j),'-(',prolif_rate,DR_out_str,death_rate,')*x',num2str(j),';']};
                    else
                        newline3 = {['2*',prolif_rate,'*x',num2str(j-1),DR_in_str,'-(',prolif_rate,DR_out_str,death_rate,')*x',num2str(j),';']};
                    end
                else
                    %middle equations for each cell type
                    newline3 = {['2*',prolif_rate,'*x',num2str(j-1),DR_in_str,'-(',prolif_rate,DR_out_str,death_rate,')*x',num2str(j),';']};
                end
            end
            if j~=n_states
                T_new(ID) = newline3;
                ID=ID+1;
            end
            %% last state
            if j==n_states && strcmp(opt.modelStates{id_state},'D')
                    deg_rate = rates_str{find(strwcmp(rates_str,'deg*'))};
                    D_str='';
                    for k=1:mS
                        x_ID = (k-1)*opt.n_divStates+1:1:k*opt.n_divStates;
                        D_str = [D_str,'g_',opt.modelStates{k},'*('];
                        for l=1:length(x_ID)
                            if l==length(x_ID)
                                D_str = [D_str,'x',num2str(x_ID(l)),')+'];
                            else
                                D_str = [D_str,'x',num2str(x_ID(l)),'+'];
                            end
                        end
                    end
                    D_str = [D_str,'-',deg_rate,'*x',num2str(j)];
                    T_new(ID)= {D_str};
                    ID=ID+1;
                    break;
            elseif j==n_states
                T_new(ID) = newline3;
                ID=ID+1;
            end
        end
        T_new(ID) = {'];'};
        T_new(ID+1) = {' '};

        %% 5) INITIAL CONDITIONS
        idx_str = ['1:',num2str(opt.n_divStates),':',num2str(n_states)];
        newline4 = {'%% initial conditions'};
        isc_str = strjoin(ics_str);
        if opt.n_initialConds==0
            newline5 = {['known_ics = [',isc_str(1:end-1),']']};
            newline6 ={'ics = [];'};
        else
            newline5 = {['ics = [',isc_str(1:end-1),'];']};
            newline6 ={'known_ics = [];'};
        end
        T_new(ID+2)=newline4;
        T_new(ID+3)=newline5;
        T_new(ID+4)=newline6;
        T_new(ID+5)={''};
        ID=ID+6;

        %% 6) Observables 
        len_output = n_states;
        newline7 = {'%% output'};
        newline8 = {['h =[',state_str1,'];']};
        T_new(ID)=newline7;
        T_new(ID+1)=newline8;
        T_new(ID+2)={''};
        ID = ID+3;

        %% 6) save file
        newline10 = {['save(''hematopoiesis_',model,''',''x'',''p'',''h'',''f'',''u'',''ics'',''known_ics''',');']};
        T_new(ID)=newline10;

        ID_end = max(find(strwcmp(T_new, 'save*')==1));
        T_new(ID+1:ID_end) = {''};
    end

    function [T_new] = adaptModelFileSImultipleIS(T,opt,iS_ID,model,rates_str,n_prolif, n_diff, n_death)
        T_new = T;
        n_is = opt.n_intermediateStates(iS_ID);

        %% header
        T_new(1) = {'% hematopoiesis model '};
        T_new(2) = {strcat('%',model)};
        T_new(3) = {'% Lisa Bast '};
        T_new(4) = {' '};
        T_new(5) = {'clearvars -except i model_str opt;'};
        T_new(6) = {' '};
        T_new(7) = {'%% states '};

        %% 1) states (= opt.n_divStates * opt.n_intermediateStates(iS_ID) * (length(opt.modelStates)-1) +1 if strcmp(opt.modelStates,'D')
        if any(strcmp(opt.modelStates,'D'))
            mS = (length(opt.modelStates)-1);
            dS = 1;
        else
            mS = length(opt.modelStates);
            dS = 0;
        end
        n_states = opt.n_divStates * ((n_prolif+n_diff+n_death)*n_is + mS) + dS;
        state_str2 = 'x = [';
        state_str1 = [];
        state_str_out = [];
        for CT_ID = 1:mS
            %% rates:
            n_out_vec(CT_ID) = sum(strwcmp(rates_str,['*_',opt.modelStates{CT_ID},'*']))-sum(strwcmp(rates_str,['a_*_',opt.modelStates{CT_ID},'*']));
        end
        next_CT_ID = cumsum((n_out_vec*n_is+1)*opt.n_divStates);
        CT_ID=1;
        n_out = n_out_vec(CT_ID);
        for i=1:n_states
            state_str1 = [state_str1, ' x', num2str(i)];
            if i==next_CT_ID
                CD_ID=CT_ID+1;
                n_out = n_out_vec(CT_ID);
            end
            if mod(i,n_is*n_out+1)==0
                state_str_out = [state_str_out, ' x', num2str(i),','];
            elseif i==n_states
                state_str_out = [state_str_out, ' x', num2str(i)];
            else
                state_str_out = [state_str_out, ' x', num2str(i),'+'];
            end
        end
        state_str=[state_str2,state_str1,'];'];
        T_new(8) = {['syms ',state_str1]};
        newline1 = {state_str};
        T_new(9)=newline1;
        T_new(10)={' '};

        %% 2) parameter vector
        T_new(11)={'%% unknown parameters'};
        if opt.fitInitialConds
            for i=1:mS+dS
                par_str1{i} = strcat('x0_',num2str(i));
                par_str2{i} = strcat(strcat('x0_',num2str(i)),';');
                ics_str{i} = strcat(strcat('x0_',num2str(i)),',');
            end
        else
            par_str1=[];
            par_str2=[];
        end
        par_str1 = [par_str1, rates_str(~strwcmp(rates_str,'x0*'))];
        par_str2 = [par_str2, strcat(rates_str(~strwcmp(rates_str,'x0*')),';')];
        newline1a = {['syms ', strjoin(par_str1)]};
        T_new(12)=newline1a;
        newline1b_str = ['p= [', strjoin(par_str2)];
        newline1b = {[newline1b_str(1:end-1),'];']};
        T_new(13)=newline1b;
        T_new(14)={' '};

        %% 3) input
        T_new(15)={'%% input'};
        newline1 = {'u=[];'};
        T_new(16)=newline1;
        T_new(17)={' '};

        %% 4) EQUATIONS
        T_new(18)={'%% dynamic equations'};
        T_new(19) = {'f=['};
        ID = 19;
        EQ_ID = 1;
        n_out_vec=zeros(1,mS);
        if opt.fitDeadCells
            boundary = 3;
        else
            boundary= 2;
        end
        for CT_ID = 1:mS
            %% rates:
            n_out_vec(CT_ID) = sum(strwcmp(rates_str,['*_',opt.modelStates{CT_ID},'*']))-sum(strwcmp(rates_str,['a_*_',opt.modelStates{CT_ID},'*']));
            diff_rates_out_vec{CT_ID}=rates_str(find(strwcmp(rates_str,['*a_',opt.modelStates{CT_ID},'*'])));
            [prolif_rate,diff_rates_i,diff_rates_o,death_rate] = getRateStrings(rates_str,opt.modelStates{CT_ID});
            if ~isempty(death_rate)
                death_rate_str = ['+',death_rate,'/',num2str(n_is)];
            else
                death_rate_str = [];
            end
            [DivState_Vec,IS_Mat,Offset] = getIndices(opt.n_divStates,n_is,n_out_vec,CT_ID);
            if isempty(diff_rates_o)
                    DR_out_str = '';
            elseif ischar(diff_rates_o)
                    DR_out_str = ['+',diff_rates_o,'/',num2str(n_is)];
            elseif iscell(diff_rates_o)
                DR_out_str = [diff_rates_o{1},'/',num2str(n_is)];
                for i=2:length(diff_rates_o)
                    DR_out_str = ['+',DR_out_str,'+',diff_rates_o{i},'/',num2str(n_is)];
                end
            end
            for D_ID = 1:opt.n_divStates
                if isempty(diff_rates_i)
                        DR_in_str = '';
                elseif ischar(diff_rates_i)
                        CT_ID_U = find(strcmp(opt.modelStates,diff_rates_i(3:5)));
                        [DivState_Vec_U,IS_Mat_U,Offset_U] = getIndices(opt.n_divStates,n_is,n_out_vec,CT_ID_U);
                        if size(IS_Mat_U,2)==boundary
                            source_state_D_ID = find(ismember(IS_Mat_U(:,1:end),[0,n_is,zeros(1,size(IS_Mat_U,2)-2)],'rows') & ismember(DivState_Vec_U,D_ID));
                        else
                            ID_rate = find(strcmp(diff_rates_out_vec{CT_ID_U},diff_rates_i));
                            source_state_D_ID = find(ismember(IS_Mat_U(:,1:end),[zeros(1,ID_rate),n_is,zeros(1,size(IS_Mat_U,2)-(ID_rate+1))],'rows') & ismember(DivState_Vec_U,D_ID));
                        end
                        DR_in_str = [diff_rates_i,'/',num2str(n_is),'*x',num2str(Offset_U+source_state_D_ID)];
                elseif iscell(diff_rates_i)
                    for i=1:length(diff_rates_i)
                        CT_ID_U = find(strcmp(opt.modelStates,diff_rates_i{i}(3:5)));
                        [DivState_Vec_U,IS_Mat_U,Offset_U] = getIndices(opt.n_divStates,n_is,n_out_vec,CT_ID_U);
                        if size(IS_Mat_U,2)==boundary
                            source_state_D_ID = find(ismember(IS_Mat_U(:,1:end),[0,n_is,zeros(1,size(IS_Mat_U,2)-2)],'rows') & ismember(DivState_Vec_U,D_ID));
                        else
                            ID_rate = find(strcmp(diff_rates_out_vec{CT_ID_U},diff_rates_i{i}));
                            source_state_D_ID = find(ismember(IS_Mat_U(:,1:end),[zeros(1,ID_rate),n_is,zeros(1,size(IS_Mat_U,2)-(ID_rate+1))],'rows') & ismember(DivState_Vec_U,D_ID));
                        end
                        if i==1
                            DR_in_str = [diff_rates_i{i},'/',num2str(n_is),'*x',num2str(Offset_U+source_state_D_ID)];
                        else
                            DR_in_str = [DR_in_str,'+', diff_rates_i{i},'/',num2str(n_is),'*x',num2str(Offset_U+source_state_D_ID)];
                        end
                    end
                end
                %% first equation of current cell type and Division_ID        
                if D_ID == 1 %DR_in_str-1/n(prolif+diff_o+death)*xi
                    newline3 = {[DR_in_str, '-(',prolif_rate,'/',num2str(n_is),DR_out_str,death_rate_str,')*x',num2str(EQ_ID),';']};
                else
                    if opt.modelAccumulateInLastState 
                        source_state_P1_ID = find(ismember(IS_Mat(:,1:end),[n_is,zeros(1,size(IS_Mat,2)-1)],'rows') & ismember(DivState_Vec,D_ID-1));
                        if ~isempty(source_state_P1_ID)
                            Prolif_in_str_1 = ['+2*',prolif_rate,'/',num2str(n_is),'*x',num2str(Offset+source_state_P1_ID)];
                        end
                        source_state_P2_ID = find(ismember(IS_Mat(:,1:end),[n_is,zeros(1,size(IS_Mat,2)-1)],'rows') & ismember(DivState_Vec,D_ID));
                        if ~isempty(source_state_P2_ID)
                            Prolif_in_str_2 = ['+2*',prolif_rate,'/',num2str(n_is),'*x',num2str(Offset+source_state_P2_ID)];
                        end
                    else
                        Prolif_in_str_1='';
                        Prolif_in_str_2='';
                    end
                    if D_ID == opt.n_divStates %DR_in_str+Prolif_in_str_1-1/n(prolif+diff_o+death)*xi
                        newline3 = {[DR_in_str,Prolif_in_str_1,Prolif_in_str_2,'-(',prolif_rate,'/',num2str(n_is),DR_out_str,death_rate_str,')*x',num2str(EQ_ID),';']};
                    else
                        newline3 = {[DR_in_str,Prolif_in_str_1,'-(',prolif_rate,'/',num2str(n_is),DR_out_str,death_rate_str,')*x',num2str(EQ_ID),';']};
                    end
                end
                T_new(ID+EQ_ID) = newline3;
                EQ_ID = EQ_ID+1;
                %% block of intermediate equations for div
                if ~isempty(prolif_rate)
                    for IS_ID = 1:n_is
                        state_in = find(ismember(IS_Mat(:,1:end),[IS_ID-1,zeros(1,size(IS_Mat,2)-1)],'rows') & ismember(DivState_Vec,D_ID));
                        state_out = find(ismember(IS_Mat(:,1:end),[IS_ID,zeros(1,size(IS_Mat,2)-1)],'rows') & ismember(DivState_Vec,D_ID));
                        if ~any(strcmp(opt.modelStates,'D')) && isempty(death_rate_str) && isempty(diff_rates_o) && IS_ID==n_is && CT_ID==mS && D_ID==opt.n_divStates
                            T_new(ID+EQ_ID) = {['+',prolif_rate,'/',num2str(n_is),'*(x',num2str(Offset+state_in),'-x',num2str(Offset+state_out),')']};
                        else
                            T_new(ID+EQ_ID) = {['+',prolif_rate,'/',num2str(n_is),'*(x',num2str(Offset+state_in),'-x',num2str(Offset+state_out),');']};
                        end
                        EQ_ID = EQ_ID+1;
                    end
                end
                %% block of intermediate equations for diff
                if ischar(diff_rates_o)
                    for IS_ID = 1:n_is
                        state_in = find(ismember(IS_Mat(:,1:end),[0,IS_ID-1,zeros(1,size(IS_Mat,2)-2)],'rows') & ismember(DivState_Vec,D_ID));
                        state_out = find(ismember(IS_Mat(:,1:end),[0,IS_ID,zeros(1,size(IS_Mat,2)-2)],'rows') & ismember(DivState_Vec,D_ID));
                        if ~any(strcmp(opt.modelStates,'D')) && isempty(death_rate_str) && IS_ID==n_is && CT_ID==mS && D_ID==opt.n_divStates
                            T_new(ID+EQ_ID) = {[diff_rates_o,'/',num2str(n_is),'*(x',num2str(Offset+state_in),'-x',num2str(Offset+state_out),');']};
                        else
                            T_new(ID+EQ_ID) = {[diff_rates_o,'/',num2str(n_is),'*(x',num2str(Offset+state_in),'-x',num2str(Offset+state_out),');']};
                        end
                        EQ_ID = EQ_ID+1;
                    end
                elseif iscell(diff_rates_o)
                    for i=1:length(diff_rates_o)
                        for IS_ID = 1:n_is
                            state_in = find(ismember(IS_Mat(:,1:end),[zeros(1,i),IS_ID-1,zeros(1,size(IS_Mat,2)-(i+1))],'rows') & ismember(DivState_Vec,D_ID));
                            state_out = find(ismember(IS_Mat(:,1:end),[zeros(1,i),IS_ID,zeros(1,size(IS_Mat,2)-(i+1))],'rows') & ismember(DivState_Vec,D_ID));
                            if ~any(strcmp(opt.modelStates,'D')) && isempty(death_rate_str) && IS_ID==n_is && i==length(diff_rates_o) && CT_ID==mS && D_ID==opt.n_divStates
                                T_new(ID+EQ_ID) = {[diff_rates_o{i},'/',num2str(n_is),'*(x',num2str(Offset+state_in),'-x',num2str(Offset+state_out),')']};
                            else
                                T_new(ID+EQ_ID) = {[diff_rates_o{i},'/',num2str(n_is),'*(x',num2str(Offset+state_in),'-x',num2str(Offset+state_out),');']};
                            end
                            EQ_ID = EQ_ID+1;
                        end
                    end
                end
                %% block of intermediate equations for death
                if ~isempty(death_rate_str)
                    for IS_ID = 1:n_is
                        state_in = find(ismember(IS_Mat(:,1:end),[zeros(1,size(IS_Mat,2)-1),IS_ID-1],'rows') & ismember(DivState_Vec,D_ID));
                        state_out = find(ismember(IS_Mat(:,1:end),[zeros(1,size(IS_Mat,2)-1),IS_ID],'rows') & ismember(DivState_Vec,D_ID));
                        if ~any(strcmp(opt.modelStates,'D')) && IS_ID==n_is && CT_ID==mS && D_ID==opt.n_divStates
                            T_new(ID+EQ_ID) = {[death_rate_str(2:end),'*(x',num2str(Offset+state_in),'-x',num2str(Offset+state_out),')']};
                        else
                            T_new(ID+EQ_ID) = {[death_rate_str(2:end),'*(x',num2str(Offset+state_in),'-x',num2str(Offset+state_out),');']};
                        end
                        EQ_ID = EQ_ID+1;
                    end
                end
            end
        end
        ID=ID+EQ_ID;
        %% equation for dead cells
        if any(strcmp(opt.modelStates,'D'))
            deg_rate = rates_str{find(strwcmp(rates_str,'deg*'))};
            D_str='';
            for CT_ID=1:mS
                [~,~,~,death_rate] = getRateStrings(rates_str,opt.modelStates{CT_ID});
                [DivState_Vec,IS_Mat,Offset] = getIndices(opt.n_divStates,n_is,n_out_vec,CT_ID);
                D_str = [D_str,death_rate,'*('];
                for D_ID = 1:opt.n_divStates
                    state_in = find(ismember(IS_Mat(:,1:end),[zeros(1,size(IS_Mat,2)-1),n_is],'rows') & ismember(DivState_Vec,D_ID));
                    if D_ID ==opt.n_divStates
                        D_str = [D_str,'x',num2str(Offset+state_in),')+'];
                    else
                        D_str = [D_str,'x',num2str(Offset+state_in),'+'];
                    end
                end
            end
            T_new(ID) = {[D_str,'-',deg_rate,'*x',num2str(EQ_ID)]};
            ID=ID+1;
        end 
        T_new(ID) = {'];'};
        T_new(ID+1) = {' '};

        %% 5) INITIAL CONDITIONS
        idx_str = ['1:',num2str(opt.n_divStates * opt.n_intermediateStates(iS_ID)),':',num2str(n_states)];
        newline4 = {'%% initial conditions'};
        isc_str = strjoin(ics_str);
        if opt.n_initialConds==0
            newline5 = {['known_ics = [',isc_str(1:end-1),'];']};
            newline6 ={'ics = [];'};
        else
            newline5 = {['ics = [',isc_str(1:end-1),'];']};
            newline6 ={'known_ics = [];'};
        end
        T_new(ID+2)=newline4;
        T_new(ID+3)=newline5;
        T_new(ID+4)=newline6;
        T_new(ID+5)={''};
        ID=ID+6;

        %% 5) Observables 
        newline7 = {'%% output'};
        newline8 = {['h =[',state_str_out,'];']};
        T_new(ID)=newline7;
        T_new(ID+1)=newline8;
        T_new(ID+2)={''};
        ID = ID+3;

        %% 6) save file
        newline10 = {['save(''hematopoiesis_',model,''',''x'',''p'',''h'',''f'',''u'',''ics'',''known_ics''',');']};
        T_new(ID)=newline10;

        ID_end = max(ID+2,max(find(strwcmp(T_new, 'save*')==1)));
        T_new(ID+1:ID_end) = {''};
    end
end