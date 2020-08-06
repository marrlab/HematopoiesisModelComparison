function [] = createSimulationFiles(opt,bool_simulate,model)
    if bool_simulate
        currentDir = cd;
        %% adapt AMICI model file
        adaptModelFile_AMICI(model,opt,opt.iS_ID)
        %% run respective generating file 
        cd(fullfile(opt.a_path,'hematopoiesis'));
%          disp(strcat(opt.a_path,'hematopoiesis/'));
%          disp([model,'_',num2str(opt.n_intermediateStates(opt.iS_ID)),'()']);
         try
            eval([model,'_',num2str(opt.n_intermediateStates(opt.iS_ID)),'()']);
         catch
            error(['this model scheme(',model,'_',num2str(opt.n_intermediateStates(opt.iS_ID)),') is not implemented. Go to updateModelParams()!'])
         end
        cd(currentDir);
    end
end

function [] = adaptModelFile_AMICI(model,opt,iS_ID)

%% rates string without brackets
for i=1:length(opt.rates)
    rates_str{i} = strrep(opt.rates{i},'{','');
    rates_str{i} = strrep(rates_str{i},'}','');
    rates_str{i} = rates_str{i}(~isspace(rates_str{i}));
end
n_prolif = sum(strwcmp(rates_str,'b_*'));
n_diff = sum(strwcmp(rates_str,'a_*'));
n_death = sum(strwcmp(rates_str,'g_*'));

%% create string of filename
if any(strcmp(model,opt.models_implemented))
    FileName1 = [model,'_',num2str(opt.n_intermediateStates(iS_ID)),'_syms.m'];
else
    error('This model is not implemented. Go to adaptSymsFile!')
end

CD = cd();
cd(fullfile(opt.a_path,'hematopoiesis'));
str = fileread(FileName1);
T = textread(FileName1, '%s', 'delimiter', '\n','bufsize', max(size(str)));
cd(CD);

%% 1) Correct number of states (= opt.n_divStates * opt.n_intermediateStates(iS_ID) * (length(opt.modelStates)-1) +1 if strcmp(opt.modelStates,'D')
if opt.n_intermediateStates(iS_ID)==1
    [T_new] = adaptModelFile_AMICI_noIS(T,opt,iS_ID,rates_str);
else
    [T_new] = adaptModelFile_AMICI_multipleIS(T,opt,iS_ID,rates_str,n_prolif,n_diff,n_death);
end

cd(fullfile(opt.a_path,'hematopoiesis'));
FID = fopen(FileName1, 'wb');
if FID < 0 
    error('Cannot open file.'); 
end
fprintf(FID, '%s\n', T_new{:});
fclose(FID);
cd(CD);

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

end
