function [T_new] = adaptModelFile_AMICI_noIS(T,opt,iS_ID,rates_str)
T_new = T;
%% 1) Correct number of states (= opt.n_divStates * opt.n_intermediateStates(iS_ID) * (length(opt.modelStates)-1) +1 if strcmp(opt.modelStates,'D')
if any(strcmp(opt.modelStates,'D'))
    mS = (length(opt.modelStates)-1);
    dS = 1;
else
    mS = length(opt.modelStates);
    dS = 0;
end
n_states = opt.n_divStates * opt.n_intermediateStates(iS_ID) * mS +dS;
state_str = [];
for i=1:n_states
    state_str = [state_str, ' x', num2str(i)];
end
newline0 = {strcat('syms ',state_str)};
T_new(find(strwcmp(T, '% create state syms*')==1)+1)=newline0;
newline1 = {strcat(state_str)};
T_new(find(strwcmp(T, '% create state vector*')==1)+2)=newline1;

%% 2) Correct parameter vector
if opt.fitInitialConds
    for i=1:mS+dS
        par_str{i} = strcat('x0_',num2str(i));
    end
else
    par_str=[];
end
par_str = [par_str, rates_str(~strwcmp(rates_str,'x0*'))];
newline1a = {['syms ', strjoin(par_str)]};
T_new(find(strwcmp(T, '% create parameter syms*')==1)+1)=newline1a;
newline1b = {['p= [', strjoin(par_str),'];']};
T_new(find(strwcmp(T, '% create parameter vector*')==1)+1)=newline1b;

%% 3) EQUATIONS
ID = find(strwcmp(T,'xdot = sym(zeros(size(x)));*'))+1;
n_is = opt.n_intermediateStates(iS_ID);
for j=1:n_states
    %% first state
    if (mod(j-1,opt.n_divStates)==0)
        id_state = (j-1)/(opt.n_divStates * opt.n_intermediateStates(iS_ID))+1;
        newline2 = {['%',opt.modelStates{id_state}]};
        T_new(ID) = {''};
        T_new(ID+1) = newline2;
        ID=ID+2;
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
%                 DR_in_str = [diff_rates_i,'*x',num2str(j-(id_state-source_state_ID)*opt.n_divStates*opt.n_intermediateStates(iS_ID)+(opt.n_intermediateStates(iS_ID)-1))];
                DR_in_str = [diff_rates_i,'*x',num2str(j-(id_state-source_state_ID)*opt.n_divStates*opt.n_intermediateStates(iS_ID))];
        elseif iscell(diff_rates_i)
                source_state1_ID = find(strcmp(opt.modelStates,diff_rates_i{1}(3:5)));
                source_state2_ID = find(strcmp(opt.modelStates,diff_rates_i{2}(3:5)));
%                 DR_in_str = [diff_rates_i{1},'*x',num2str(j-(id_state-source_state1_ID)*opt.n_divStates*opt.n_intermediateStates(iS_ID)+(opt.n_intermediateStates(iS_ID)-1)),'+',...
%                             diff_rates_i{2},'*x',num2str(j-(id_state-source_state2_ID)*opt.n_divStates*opt.n_intermediateStates(iS_ID)+(opt.n_intermediateStates(iS_ID)-1))];
                DR_in_str = [diff_rates_i{1},'*x',num2str(j-(id_state-source_state1_ID)*opt.n_divStates*opt.n_intermediateStates(iS_ID)),'+',...
                            diff_rates_i{2},'*x',num2str(j-(id_state-source_state2_ID)*opt.n_divStates*opt.n_intermediateStates(iS_ID))];
        end
        %newline3 = {['xdot(',num2str(j),') = ',DR_in_str,'-(',prolif_rate,'/',num2str(n_is),')*x',num2str(j),';']};
        %first equation of each cell type:
        newline3 = {['xdot(',num2str(j),') = ',DR_in_str,'-(',prolif_rate,DR_out_str,death_rate,')*x',num2str(j),';']};
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
                newline3 = {['xdot(',num2str(j),') = 2*',prolif_rate,'*x',num2str(j-1),DR_in_str,'+2*',prolif_rate,'*x',num2str(j+opt.n_intermediateStates(iS_ID)-1),'-(',prolif_rate,DR_out_str,death_rate,')*x',num2str(j),';']};
            else
                newline3 = {['xdot(',num2str(j),') = 2*',prolif_rate,'*x',num2str(j-1),DR_in_str,'-(',prolif_rate,DR_out_str,death_rate,')*x',num2str(j),';']};
            end
        else
            %middle equations for each cell type
            
            newline3 = {['xdot(',num2str(j),') = 2*',prolif_rate,'*x',num2str(j-1),DR_in_str,'-(',prolif_rate,DR_out_str,death_rate,')*x',num2str(j),';']};
        end

        %% old version:
%         if (mod(j,opt.n_intermediateStates(iS_ID))~=0)
%             if (mod(j-1,opt.n_intermediateStates(iS_ID))==0)
%                 if ischar(diff_rates_i)
%                     DR_in_str = [diff_rates_i,'*x',num2str(j-(id_state-source_state_ID)*opt.n_divStates*opt.n_intermediateStates(iS_ID)+(opt.n_intermediateStates(iS_ID)-1)),'+'];
%                 elseif iscell(diff_rates_i)
%                     DR_in_str = [diff_rates_i{1},'*x',num2str(j-(id_state-source_state1_ID)*opt.n_divStates*opt.n_intermediateStates(iS_ID)+(opt.n_intermediateStates(iS_ID)-1)),'+',...
%                                 diff_rates_i{2},'*x',num2str(j-(id_state-source_state2_ID)*opt.n_divStates*opt.n_intermediateStates(iS_ID)+(opt.n_intermediateStates(iS_ID)-1)),'+'];
%                 end
%             else
%                 DR_in_str = '';
%             end
%             newline3 = {['xdot(',num2str(j),') = ',DR_in_str,'(',prolif_rate,'/',num2str(n_is),')*x',num2str(j-1),'-(',prolif_rate,'/',num2str(n_is),')*x',num2str(j),';']};
%         else
%             
%             newline3 = {['xdot(',num2str(j),') = (',prolif_rate,'/',num2str(n_is),')*x',num2str(j-1),'-(',prolif_rate,'/',num2str(n_is),'+',DR_out_str,death_rate,')*x',num2str(j),';']};
%         end
    end
    if (j~=n_states && dS == 1) || (dS==0)
        T_new(ID) = newline3;
        ID=ID+1;
    end
    %% last state
    if (j==n_states && dS == 1)
        deg_rate = rates_str{find(strwcmp(rates_str,'deg*'))};
        D_str=['xdot(',num2str(j),') = '];
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
        newline3 = {[D_str,';']};
        T_new(ID)={''};
        T_new(ID+1)={'%D'};
        T_new(ID+2) = newline3;
        ID=ID+3;
        break;
    elseif (j==n_states && dS == 0)
        T_new(ID)={''};
        T_new(ID+1)={'%D'};
        T_new(ID+2)={''};
        ID=ID+3;
    end
end

%% 4) INITIAL CONDITIONS
idx_str = ['1:',num2str(opt.n_divStates * opt.n_intermediateStates(iS_ID)),':',num2str(n_states)];
newline4 = {'% INITIAL CONDITIONS'};
newline5 = {'x0 = sym(zeros(size(x)));'};
if opt.n_initialConds_N==0
    newline6 = {strcat('x0(',idx_str,')=k(1:',num2str(mS+dS),');')};
else
    newline6 = {strcat('x0(',idx_str,')=exp(p(1:',num2str(mS+dS),'))-1;')};
end
T_new(ID)={''};
T_new(ID+1)={''};
T_new(ID+2)=newline4;
T_new(ID+3)=newline5;
T_new(ID+4)=newline6;
T_new(ID+5)={''};
ID=ID+6;

%% 5) Observables 
len_output = n_states;
newline7 = {'% OBSERVABLES'};
newline8 = {['y= sym(zeros(',num2str(len_output),',1));']};
newline9 = {'y = log(x+1);'};
T_new(ID)=newline7;
T_new(ID+1)=newline8;
T_new(ID+2)=newline9;
T_new(ID+3)={''};
ID = ID+4;

%% 6) System struct
newline10 = {'% SYSTEM STRUCT'};
newline11 = {'model.sym.x = x;'};
newline12 = {'model.sym.k = k;'};
newline13 = {'model.sym.xdot = xdot;'};
newline14 = {'model.sym.p = p;'};
newline15 = {'model.sym.x0 = x0;'};
newline16 = {'model.sym.y = y;'};
if strcmp(opt.optimizationMode,'hierarchical')
    newline17 = {'model.sym.sigma_y = 0;'};
else
    newline17 = {'model.sym.sigma_y = s.^2;'};
end
T_new(ID)=newline10;
T_new(ID+1)=newline11;
T_new(ID+2)=newline12;
T_new(ID+3)=newline13;
T_new(ID+4)=newline14;
T_new(ID+5)=newline15;
T_new(ID+6)=newline16;
T_new(ID+7)=newline17;
ID=ID+8;
ID_end = max(find(strwcmp(T, 'model.sym.sigma_y*')==1));
T_new(ID:ID_end) = {''};

end