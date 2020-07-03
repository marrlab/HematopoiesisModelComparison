function [T_new] = adaptModelFile_AMICI_multipleIS(T,opt,iS_ID,rates_str,n_prolif, n_diff, n_death)
T_new = T;
if any(strcmp(opt.modelStates,'D'))
    mS = (length(opt.modelStates)-1);
    dS = 1;
else
    mS = length(opt.modelStates);
    dS = 0;
end
n_states = opt.n_divStates * ((n_prolif+n_diff+n_death)*opt.n_intermediateStates(iS_ID) + mS) + dS;
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
EQ_ID = 1;
n_out_vec=zeros(1,mS);
if opt.fitDeadCells
    boundary = 3;
else
    boundary= 2;
end
for CT_ID = 1:mS
    %% header for cell type in T_new
    newline2 = {['%',opt.modelStates{CT_ID}]};
    T_new(ID+EQ_ID) = {''};
    T_new(ID+EQ_ID+1) = newline2;
    ID=ID+2;
    %% rates:
    n_out_vec(CT_ID) = sum(strwcmp(rates_str,['*_',opt.modelStates{CT_ID},'*']))-sum(strwcmp(rates_str,['a_*_',opt.modelStates{CT_ID},'*']));
    diff_rates_out_vec{CT_ID}=rates_str(find(strwcmp(rates_str,['*a_',opt.modelStates{CT_ID},'*'])));
    [prolif_rate,diff_rates_i,diff_rates_o,death_rate] = getRateStrings(rates_str,opt.modelStates{CT_ID});
    if ~isempty(death_rate)
        death_rate_str = ['+',death_rate,'*',num2str(n_is)];
    else
        death_rate_str = [];
    end
    [DivState_Vec,IS_Mat,Offset] = getIndices(opt.n_divStates,n_is,n_out_vec,CT_ID);
    if isempty(diff_rates_o)
            DR_out_str = '';
    elseif ischar(diff_rates_o)
            DR_out_str = ['+',diff_rates_o,'*',num2str(n_is)];
    elseif iscell(diff_rates_o)
        DR_out_str = [diff_rates_o{1},'*',num2str(n_is)];
        for i=2:length(diff_rates_o)
            DR_out_str = ['+',DR_out_str,'+',diff_rates_o{i},'*',num2str(n_is)];
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
                DR_in_str = [diff_rates_i,'*',num2str(n_is),'*x',num2str(Offset_U+source_state_D_ID)];
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
                    DR_in_str = [diff_rates_i{i},'*',num2str(n_is),'*x',num2str(Offset_U+source_state_D_ID)];
                else
                    DR_in_str = [DR_in_str,'+', diff_rates_i{i},'*',num2str(n_is),'*x',num2str(Offset_U+source_state_D_ID)];
                end
            end
        end
        %% first equation of current cell type and Division_ID        
        if D_ID == 1 %DR_in_str-1/n(prolif+diff_o+death)*xi
            newline3 = {['xdot(',num2str(EQ_ID),') =',DR_in_str, '-(',prolif_rate,'*',num2str(n_is),DR_out_str,death_rate_str,')*x',num2str(EQ_ID),';']};
        else
            if opt.modelAccumulateInLastState 
                source_state_P1_ID = find(ismember(IS_Mat(:,1:end),[n_is,zeros(1,size(IS_Mat,2)-1)],'rows') & ismember(DivState_Vec,D_ID-1));
                if ~isempty(source_state_P1_ID)
                    Prolif_in_str_1 = ['+2*',prolif_rate,'*',num2str(n_is),'*x',num2str(Offset+source_state_P1_ID)];
                end
                source_state_P2_ID = find(ismember(IS_Mat(:,1:end),[n_is,zeros(1,size(IS_Mat,2)-1)],'rows') & ismember(DivState_Vec,D_ID));
                if ~isempty(source_state_P2_ID)
                    Prolif_in_str_2 = ['+2*',prolif_rate,'*',num2str(n_is),'*x',num2str(Offset+source_state_P2_ID)];
                end
            else
                Prolif_in_str_1='';
                Prolif_in_str_2='';
            end
            if D_ID == opt.n_divStates %DR_in_str+Prolif_in_str_1-1/n(prolif+diff_o+death)*xi
                newline3 = {['xdot(',num2str(EQ_ID),') =',DR_in_str,Prolif_in_str_1,Prolif_in_str_2,'-(',prolif_rate,'*',num2str(n_is),DR_out_str,death_rate_str,')*x',num2str(EQ_ID),';']};
            else
                newline3 = {['xdot(',num2str(EQ_ID),') =',DR_in_str,Prolif_in_str_1,'-(',prolif_rate,'*',num2str(n_is),DR_out_str,death_rate_str,')*x',num2str(EQ_ID),';']};
            end
        end
        T_new(ID+EQ_ID) = newline3;
        EQ_ID = EQ_ID+1;
        %% block of intermediate equations for div
        if ~isempty(prolif_rate)
            for IS_ID = 1:n_is
                state_in = find(ismember(IS_Mat(:,1:end),[IS_ID-1,zeros(1,size(IS_Mat,2)-1)],'rows') & ismember(DivState_Vec,D_ID));
                state_out = find(ismember(IS_Mat(:,1:end),[IS_ID,zeros(1,size(IS_Mat,2)-1)],'rows') & ismember(DivState_Vec,D_ID));
                T_new(ID+EQ_ID) = {['xdot(',num2str(EQ_ID),') =','+',prolif_rate,'*',num2str(n_is),'*(x',num2str(Offset+state_in),'-x',num2str(Offset+state_out),');']};
                EQ_ID = EQ_ID+1;
            end
        end
        %% block of intermediate equations for diff
        if ischar(diff_rates_o)
            for IS_ID = 1:n_is
                state_in = find(ismember(IS_Mat(:,1:end),[0,IS_ID-1,zeros(1,size(IS_Mat,2)-2)],'rows') & ismember(DivState_Vec,D_ID));
                state_out = find(ismember(IS_Mat(:,1:end),[0,IS_ID,zeros(1,size(IS_Mat,2)-2)],'rows') & ismember(DivState_Vec,D_ID));
                T_new(ID+EQ_ID) = {['xdot(',num2str(EQ_ID),') =',diff_rates_o,'*',num2str(n_is),'*(x',num2str(Offset+state_in),'-x',num2str(Offset+state_out),');']};
                EQ_ID = EQ_ID+1;
            end
        elseif iscell(diff_rates_o)
            for i=1:length(diff_rates_o)
                for IS_ID = 1:n_is
                    state_in = find(ismember(IS_Mat(:,1:end),[zeros(1,i),IS_ID-1,zeros(1,size(IS_Mat,2)-(i+1))],'rows') & ismember(DivState_Vec,D_ID));
                    state_out = find(ismember(IS_Mat(:,1:end),[zeros(1,i),IS_ID,zeros(1,size(IS_Mat,2)-(i+1))],'rows') & ismember(DivState_Vec,D_ID));
                    T_new(ID+EQ_ID) = {['xdot(',num2str(EQ_ID),') =',diff_rates_o{i},'*',num2str(n_is),'*(x',num2str(Offset+state_in),'-x',num2str(Offset+state_out),');']};
                    EQ_ID = EQ_ID+1;
                end
            end
        end
        %% block of intermediate equations for death
        if ~isempty(death_rate_str)
            for IS_ID = 1:n_is
                state_in = find(ismember(IS_Mat(:,1:end),[zeros(1,size(IS_Mat,2)-1),IS_ID-1],'rows') & ismember(DivState_Vec,D_ID));
                state_out = find(ismember(IS_Mat(:,1:end),[zeros(1,size(IS_Mat,2)-1),IS_ID],'rows') & ismember(DivState_Vec,D_ID));
                T_new(ID+EQ_ID) = {['xdot(',num2str(EQ_ID),') =',death_rate_str(2:end),'*(x',num2str(Offset+state_in),'-x',num2str(Offset+state_out),');']};
                EQ_ID = EQ_ID+1;
            end
        end
    end
end
ID=ID+EQ_ID;
%% equation for dead cells
if any(strcmp(opt.modelStates,'D'))
    deg_rate = rates_str{find(strwcmp(rates_str,'deg*'))};
    D_str=['xdot(',num2str(EQ_ID),') = '];
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
    T_new(ID)={''};
    T_new(ID+1)={'%D'};
    T_new(ID+2) = {[D_str,'-',deg_rate,'*x',num2str(EQ_ID),';']};
    ID=ID+3;
elseif ~any(strcmp(opt.modelStates,'D'))
    T_new(ID)={''};
    T_new(ID+1)={'%D'};
    T_new(ID+2)={''};
    ID=ID+3;
end    

%% 4) INITIAL CONDITIONS
IDX_vec = ones(mS,1);
for CT_ID=2:mS+dS
    IDX_vec(CT_ID) = sum(opt.n_divStates  * (n_out_vec(1:CT_ID-1) * opt.n_intermediateStates(iS_ID)+1))+1;
end
idx_str = strjoin(arrayfun(@num2str,IDX_vec,'uni',false),',');
newline4 = {'% INITIAL CONDITIONS'};
newline5 = {'x0 = sym(zeros(size(x)));'};
if opt.n_initialConds_N==0
    newline6 = {strcat('x0([',idx_str,'])=k(1:',num2str(mS+dS),');')};
else
    newline6 = {strcat('x0([',idx_str,'])=exp(p(1:',num2str(mS+dS),'))-1;')};
end
T_new(ID)={''};
T_new(ID+1)={''};
T_new(ID+2)=newline4;
T_new(ID+3)=newline5;
T_new(ID+4)=newline6;
T_new(ID+5)={''};
ID=ID+6;

%% 5) Observables 
len_output = mS*opt.n_divStates+dS;
% for CT_ID=1:mS
%     for i=1:opt.n_divStates
%         y(opt.n_divStates*(CT_ID-1)+i) = log(sum(x((i-1)*(n_out_vec(CT_ID)*n_is+1)+IDX_vec(CT_ID):i*(n_out_vec(CT_ID)*n_is+1)+IDX_vec(CT_ID)))+1);
%     end
% end
newline7 = {'% OBSERVABLES'};
newline8 = {['y= sym(zeros(',num2str(len_output),',1));']};
T_new(ID)=newline7;
T_new(ID+1)=newline8;
ID=ID+2;
for CT_ID=1:mS
    T_new(ID) = {['for i=1:',num2str(opt.n_divStates)]};
    T_new(ID+1) = {['y(',num2str(opt.n_divStates*(CT_ID-1)),'+i) = log(sum(x((i-1)*',num2str(n_out_vec(CT_ID)*n_is+1),'+',num2str(IDX_vec(CT_ID)),':i*',num2str(n_out_vec(CT_ID)*n_is+1),'+',num2str(IDX_vec(CT_ID)),'-1))+1);']};
    T_new(ID+2) = {'end'};
    ID=ID+3;
end
if dS==1
    newline9 = {['y(',num2str(len_output),')=log(x(',num2str(len_output),')+1);']};
else
    newline9 = {''};
end
T_new(ID)=newline9;
T_new(ID+1)={''};
ID=ID+2;

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