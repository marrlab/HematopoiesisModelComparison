function [data] = getObsData(group,compartments,individuals,idx_individual,opt,possibleCompartments)
%other ways to get the data
% ds = tabularTextDatastore('2017_05_data.csv','TreatAsMissing','NA');
% [num,str]=xlsread('2017_05_data.xlsx',3);

%% need format:
% data.ym{idx_wdhl,idx_replicate} = n_time x n_cellcounts matrix
% data.t{idx_wdhl,idx_replicate} = 1 x n_time vector
% opt.n_individuals
% opt.n_repetitions
% opt.n_replicates
% currentDir = cd();
%% create table from data sheet
load('Data_preprocessed.mat','DataTable')

if opt.exportData4Python == true && ~strwcmp(opt.c_path,'*icb*')
    cd(opt.pythonDataVisualization_path)
    writetable(DataTable,['hematopoiesis_FACS_',opt.fileName(1:12),'.txt'],'Delimiter',' ') 
    cd(opt.c_path);
end


% % %%find data belonging to individual idx_individual:
switch group
    case {'healthy','MDS'}
        S_idx = strcmp(DataTable.Status,group) & strwcmp(DataTable.sample_name,[individuals{idx_individual},'*']);
% %         VAF = max(max(DataTable.SF3B1_B_VAF,DataTable.ASXL1_B_VAF),DataTable.TET2_B_VAF);
% %     case 'MDS_SF3B1'
% %         S_idx = strcmp(DataTable.Status,'MDS') & strwcmp(DataTable.sample_name,[individuals{idx_individual},'*']);
% %         for i=1:length(DataTable.SF3B1_B)
% %             if DataTable.SF3B1_B{i}==0
% %                 S_idx(i)=0;
% %             end
% %         end
% %         VAF = DataTable.SF3B1_VAF;
% %     case 'MDS_ASXL1'
% %         S_idx = strcmp(DataTable.Status,'MDS') & strwcmp(DataTable.sample_name,[individuals{idx_individual},'*']);
% %         for i=1:length(DataTable.ASXL1_B)
% %             if DataTable.ASXL1_B{i}==0
% %                 S_idx(i)=0;
% %             end
% %         end
% %         VAF = DataTable.ASXL1_B_VAF;
% %     case 'MDS_TET2'
% %         S_idx = strcmp(DataTable.Status,'MDS') & strwcmp(DataTable.sample_name,[individuals{idx_individual},'*']);
% %         for i=1:length(DataTable.TET2_B)
% %             if DataTable.TET2_B{i}==0
% %                 S_idx(i)=0;
% %             end
% %         end
% %         VAF = DataTable.TET2_B_VAF;
end

sample_selection = unique(DataTable.sample_name(S_idx));
wdhl = unique(DataTable.repetition(S_idx));

if isempty(compartments)
    compartments = possibleCompartments;
end

for i=1:length(possibleCompartments)
    if any(strcmp(compartments,possibleCompartments{i}))
        ID(i) = find(strwcmp(compartments,possibleCompartments{i}));
    end
end
data.legend_str = compartments;   
data.repetition = [];
data.replicate = [];
if opt.fit_repetitions_seperately
    data.y0 = cell(1,1);
    k_end=1;
else
    data.y0 = cell(length(wdhl),1);
    k_end=length(wdhl);
end
data.mutations_str = {'SF3B1','ASXL1','TET2'};
counter = 1;

for k=1:k_end
    for j=1:length(sample_selection)   
%         for i=1:length(times)
            %find all observations belongig to the current sample and current
            %time point
            YM = [];
            YM_ext = [];
            if ~opt.fitInitialConds
                idx = find(DataTable.repetition==wdhl(k)&strcmp(DataTable.sample_name,sample_selection{j})&DataTable.Tag<=6);
            else
                idx = find(DataTable.repetition==wdhl(k)&strcmp(DataTable.sample_name,sample_selection{j})&DataTable.Tag<=7);
            end
            if length(idx)>1
                ADD_rows=[];
                for i=1:length(opt.modelStates)
                    selection = ~cellfun('isempty', regexp(DataTable.Properties.VariableNames, opt.modelStates{i}, 'once'));
                    exclude = ~cellfun('isempty', regexp(DataTable.Properties.VariableNames, 'g', 'once'));
                    DataTable_selection = DataTable(:,DataTable.Properties.VariableNames(selection & ~exclude));
                    ADD_rows = [ADD_rows, DataTable_selection{:,:}(idx)];
                end
                if opt.fitDeadCells
                    ADD_rows = [ADD_rows, DataTable.dead(idx)]; %dead cells]
                end
                YM = [YM; ADD_rows];
                switch opt.noiseType
                    case 'additiveNormal'
                        data.detectionLimit_corrected{k,counter} = DataTable.detectionLimit_corrected(idx);
                    case {'LogNormal','LogLaplace'}
                        data.detectionLimit_corrected{k,counter} = log(DataTable.detectionLimit_corrected(idx)+ones(size(DataTable.detectionLimit_corrected(idx))));
                end
%                 data.mutations{k,counter} = [cell2mat(DataTable.SF3B1_B(idx)), cell2mat(DataTable.ASXL1_B(idx)), cell2mat(DataTable.TET2_B(idx))];
                switch opt.noiseType
                    case 'additiveNormal'
                       data.ym{k,counter} = YM;
                    case {'LogNormal','LogLaplace'}
                       data.ym{k,counter} = log(YM+ones(size(YM)));
                    otherwise
                       data.ym = [];
                end
                data.t{k,counter} = DataTable.Tag(idx)*24;%time is in hours
%                 data.VAF{k,counter} = VAF(idx)./100;
                %old: b = textscan(DataTable.sample_name{idx(1)},'%d%c');
                % old: data.sample=b{1}(:);
                % old: switch b{2}
                switch sample_selection{j}(end)
                    case 'a'
                        data.replicate = [data.replicate,1];
                        data.sample=sample_selection{j}(1:end-1);
                    case 'b'
                        data.replicate = [data.replicate,2];
                        data.sample=sample_selection{j}(1:end-1);
                    case 'c'
                        data.replicate = [data.replicate,3];
                        data.sample=sample_selection{j}(1:end-1);
                    otherwise
                        data.replicate = [data.replicate,1];
                        data.sample=sample_selection{j};
                end
                data.repetition = [data.repetition,wdhl(k)];
                %add day 0 measurement
                idx_d0 = find(DataTable.Tag==min(DataTable.Tag(idx))&strcmp(DataTable.sample_name,sample_selection{j})&DataTable.repetition==wdhl(k));
                if ~isempty(idx_d0)
                    ADD_rows_ext = [];
                    for i=1:length(opt.modelStates)
                        selection = ~cellfun('isempty', regexp(DataTable.Properties.VariableNames, opt.modelStates{i}, 'once'));
                        exclude = ~cellfun('isempty', regexp(DataTable.Properties.VariableNames, 'g', 'once'));
                        DataTable_selection = DataTable(:,DataTable.Properties.VariableNames(selection & ~exclude));
                        ADD_rows_ext = [ADD_rows_ext, DataTable_selection{:,:}(idx_d0)];
                    end
                    if opt.fitDeadCells
                        ADD_rows_ext = [ADD_rows_ext, DataTable.dead(idx_d0)]; %dead cells]
                    end
                    YM_ext = [YM_ext; ADD_rows_ext]; 
                    switch opt.noiseType
                        case 'additiveNormal'
                            data.y0{k,counter} = YM_ext;
                            data.inputCells{k} = DataTable.Inputzellen(idx_d0);
                        case {'LogNormal','LogLaplace'}
                            data.y0{k,counter} = log(YM_ext+ones(size(YM_ext)));
                            data.inputCells{k} = log(DataTable.Inputzellen(idx_d0)+ones(size(DataTable.Inputzellen(idx_d0))));
                    end
                end
                counter=counter+1;
            end
    end
    counter=1;
end


%% number of cell divisions
% get rid of time points that were only measured in one group
if ~opt.fitInitialConds
    S_idx(DataTable.Tag>6) = 0;
else
    S_idx(DataTable.Tag>7) = 0;
end
Tag = DataTable.Tag(S_idx==1);
Repe = DataTable.repetition(S_idx==1);
Repl = DataTable.replicate(S_idx==1);
% VAF_div = VAF(S_idx==1);
DL_corrected = DataTable.detectionLimit_corrected(S_idx==1);

CellDiv_ALL = [];
CellDiv_SUM = [];
selection1 = ~cellfun('isempty', regexp(DataTable.Properties.VariableNames, 'g', 'once'));
for i=1:length(opt.modelStates)
    selection2 = ~cellfun('isempty', regexp(DataTable.Properties.VariableNames, opt.modelStates{i}, 'once'));
    DataTable_selection = DataTable(:,DataTable.Properties.VariableNames(selection1 & selection2));
    R_OF_INTEREST = getSelectedValues(DataTable_selection{:,:}(S_idx==1,:)); 
    CellDiv_ALL = [CellDiv_ALL, R_OF_INTEREST];  
    CellDiv_SUM = [CellDiv_SUM, sum(R_OF_INTEREST,2)]; 
end
if opt.fitDeadCells
    CellDiv_ALL = [CellDiv_ALL, DataTable.dead(S_idx==1)]; %dead cells]
    CellDiv_SUM = [CellDiv_SUM, DataTable.dead(S_idx==1)]; %dead cells]
end

if strwcmp(opt.noiseType,'*Log*')
    CD_SUM = reallog(CellDiv_SUM+ones(size(CellDiv_SUM)));
    CD_ALL = reallog(CellDiv_ALL+ones(size(CellDiv_ALL)));
    DL_c = reallog(DL_corrected+ones(size(DL_corrected)));
end
data.days_observed = unique(Tag);
rid = unique(Repl);
wid = unique(Repe);

for id1=1:length(wid)
    for id2=1:length(rid)
        counter=1;
        for d_id = 1:length(data.days_observed)
            data.timeDiv{id1,id2} = 24*unique(Tag(Repl==rid(id2) & Repe==wid(id1)));
            data.detectionLimit_correctedDiv{id1,id2} = DL_c(Repl==rid(id2) & Repe==wid(id1));
%             data.VAF_div = VAF_div(Repl==rid(id2) & Repe==wid(id1));
            A_ID = (Tag == data.days_observed(d_id) & Repl==rid(id2) & Repe==wid(id1));
            if sum(A_ID)>0
                if sum(A_ID)>1
                    disp('moment mal')
                end
                if data.days_observed(d_id)==min(data.days_observed)
                    data.NumCellDiv_SUM_Y0{id1,id2} = CD_SUM(A_ID,:);
                    data.NumCellDiv_ALL_Y0{id1,id2} = CD_ALL(A_ID,:);
                end
                data.NumCellDiv_SUM{id1,id2}(counter,:) = CD_SUM(A_ID,:);
                data.NumCellDiv_ALL{id1,id2}(counter,:) = CD_ALL(A_ID,:);
                data.NumCellDiv_F_SUM{id1,id2}(counter,:) = CD_SUM(A_ID,:)./sum(CD_SUM(A_ID,:));
                data.NumCellDiv_F_ALL{id1,id2}(counter,:) = CD_ALL(A_ID,:)./sum(CD_ALL(A_ID,:));
                counter=counter+1;
            end
        end
    end
end
data.CellDiv_All_str = compartments(1:end-1);

if opt.exportData4Monolix==true && ~strwcmp(opt.c_path,'*icb*')
    sel = ~cellfun('isempty', regexp(DataTable.Properties.VariableNames, 'g', 'once'));
    for i=1:length(opt.modelStates)
        sel = [sel; ~cellfun('isempty', regexp(DataTable.Properties.VariableNames, opt.modelStates{i}, 'once'))];
    end
    DataTable_selection = DataTable(:,DataTable.Properties.VariableNames(sum(sel)==2)); 
    %sum content of columns with more that opt.n_divStates divisions
    
    for i=1:length(opt.modelStates)
        sel_m=~cellfun('isempty', regexp(DataTable_selection.Properties.VariableNames, 'asfhgwkefuzfv', 'once'));
        if strcmp(opt.modelStates{i},'mat')
            state_str = 'mature';
        else
            state_str = opt.modelStates{i};
        end
        for int_id=opt.n_divStates:12
            sel_m = [sel_m; ~cellfun('isempty', regexp(DataTable_selection.Properties.VariableNames,['g',num2str(int_id),'_',state_str], 'once'))];
        end
        eval(['DataTable_selection.',['g',num2str(opt.n_divStates),'_',state_str],' = sum(DataTable_selection{:,:}(:,sum(sel_m)==1),2);']);
        for int_id=opt.n_divStates+1:12
            eval(['DataTable_selection.',['g',num2str(int_id),'_',state_str],' = [];']);
        end
    end
    DataTable_selection.repetition = DataTable.repetition;
    DataTable_selection.Tag = DataTable.Tag;
    DataTable_selection.sample_name= DataTable.sample_name;
    cols_of_interest = sum([contains(DataTable_selection.Properties.VariableNames, 'repetition');...
                            contains(DataTable_selection.Properties.VariableNames, 'Tag');...
                            contains(DataTable_selection.Properties.VariableNames, 'sample_name')]);
    obs_id = 1;
    n_rows = size(DataTable_selection,1);
    for i=1:length(opt.modelStates)  
        if strcmp(opt.modelStates{i},'mat')
            state_str = 'mature';
        else
            state_str = opt.modelStates{i};
        end
        for int_id=1:opt.n_divStates
            Observations = DataTable_selection(:,contains(DataTable_selection.Properties.VariableNames,['g',num2str(int_id),'_',state_str]));
            Observations.Properties.VariableNames{['g',num2str(int_id),'_',state_str]} = 'Observations';
            Obs_ID = obs_id*ones(n_rows,1);
            if i==1 && int_id==1
                DataTable_4monolix = DataTable_selection(:,cols_of_interest==1);
                DataTable_4monolix.Observations = Observations{:,:};
                DataTable_4monolix.Obs_ID = Obs_ID;
            else
                new_rows = [DataTable_selection(:,cols_of_interest==1),Observations,table(Obs_ID)];
                DataTable_4monolix = [DataTable_4monolix;new_rows];
            end
            obs_id=obs_id+1;
        end
    end
    writetable(DataTable_4monolix,'hematopoiesis_data4monolix.txt','Delimiter',' ') 
end

function [R_new] = getSelectedValues(R)
    if opt.n_divStates>12
        error('data not available for more than 12 division states')
    end
    if opt.modelAccumulateInLastState  
        R_new = [R(:,1:opt.n_divStates-1) sum(R(:,opt.n_divStates:end),2)];
    else
        R_new = R(:,1:opt.n_divStates);
    end  
end

end