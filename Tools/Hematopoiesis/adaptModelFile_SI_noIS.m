function [T_new] = adaptModelFile_SI_noIS(T,opt,model,rates_str)
T_new = T;
%% header
T_new(1) = {'% hematopoiesis model '};
T_new(2) = {strcat('%',model)};
T_new(3) = {'% Lisa Bast '};
T_new(4) = {' '};
T_new(5) = {'clear;'};
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
state_str=[state_str2,state_str1,']'];
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
    newline5 = {['ics = [',isc_str(1:end-1),']']};
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