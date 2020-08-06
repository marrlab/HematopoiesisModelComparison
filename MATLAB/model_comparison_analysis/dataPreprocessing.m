function [] = dataPreprocessing(opt)
cd('./data')
load('Data.mat','DataTable')

% %% sort according to sample_name;
% DataTable = sortrows(DataTable,'sample_name');

%% add status
for i=1:size(DataTable.filename,1)
    if strwcmp(DataTable.filename{i},'*H*')
        DataTable.Status{i} = 'healthy';
    end
end

%% add columns for mature cells and dead cells
DataTable.mature = DataTable.CD34negativ+DataTable.CD45nichtdim+DataTable.lin_p;
n_div_max_measured = sum(~cellfun('isempty', regexp(DataTable.Properties.VariableNames, 'CD34negativ', 'once')))-1;
for i=1:n_div_max_measured
    selection_CD34negativ = ~cellfun('isempty', regexp(DataTable.Properties.VariableNames, ['g',num2str(i),'_CD34negativ'], 'once'));
    selection_CD45nichtdim = ~cellfun('isempty', regexp(DataTable.Properties.VariableNames, ['g',num2str(i),'_CD45nichtdim'], 'once'));
    selection_lin_p = ~cellfun('isempty', regexp(DataTable.Properties.VariableNames, ['g',num2str(i),'_lin_p'], 'once'));
    DataTable_CD34negativ = DataTable(:,DataTable.Properties.VariableNames(selection_CD34negativ));
    DataTable_CD45nichtdim = DataTable(:,DataTable.Properties.VariableNames(selection_CD45nichtdim));
    DataTable_lin_pos = DataTable(:,DataTable.Properties.VariableNames(selection_lin_p));
    DataTable = [DataTable, table(DataTable_CD34negativ{:,:}+DataTable_CD45nichtdim{:,:}+DataTable_lin_pos{:,:},'VariableNames',{['g',num2str(i),'_mature']})];
end      
DataTable.dead = max(DataTable.p2-DataTable.viable,0);

%% check if sum of Celltype_gi equals Celltype_total and store deviations in excel sheet
%if deviations too prominent --> gate cells again
for i=1:length(opt.modelStates)-1
    selection_sum = ~cellfun('isempty', regexp(DataTable.Properties.VariableNames, ['g*_',opt.modelStates{i}], 'once'));
    selection_total = (~cellfun('isempty', regexp(DataTable.Properties.VariableNames, opt.modelStates{i}, 'once')) & cellfun('isempty', regexp(DataTable.Properties.VariableNames, ['g*_',opt.modelStates{i}], 'once')));
    DataTable_selection_sum = sum(DataTable{:,DataTable.Properties.VariableNames(selection_sum)},2);
    DataTable_selection_total = DataTable{:,DataTable.Properties.VariableNames(selection_total)};
    if i==1
        T_error = table(DataTable.filename,DataTable_selection_sum-DataTable_selection_total);
        T_error.Properties.VariableNames{1} = 'fileName';
    else
        New_col = DataTable_selection_sum-DataTable_selection_total;
        T_error = [T_error,table(New_col)];
    end
    T_error.Properties.VariableNames{i+1}=[opt.modelStates{i},'total_minus_sumOf_gi_',opt.modelStates{i}];
end
writetable(T_error,['AbweichungInDaten_',opt.fileName]);
    
%% check if number of dead cells gets negative
idx_ndcn = find(DataTable.p2<DataTable.viable);
if ~isempty(idx_ndcn)
    str = 'Individual(s):';
    for i=1:length(idx_ndcn)
        str = [DataTable.Status{idx_ndcn}, DataTable.sample_name{idx_ndcn}];
    end
    disp('Data contains negative number of dead cells!');
    disp(str);
end

%% calculate correction factor and corrected detection limit
DataTable.correctionFactor = DataTable.Beads_im_Gesamtvolumen./DataTable.counts_beads;
DataTable.detectionLimit = 2.626785*ones(size(DataTable,1),1);
DataTable.detectionLimit_corrected = DataTable.detectionLimit./DataTable.correctionFactor;

%% correct cell numbers according to beads
[DataTable] = correctCellNumberForBeadCounts(DataTable,[opt.modelStates,'lin_p','lin_n']);

%% correct day: first day should be day 0 if initial conditions are not fit
if ~opt.fitInitialConds %start at 0 if first data point is used as known initial condition
    DataTable.Tag = DataTable.Tag-1;
end
save('Data_preprocessed.mat','DataTable')
cd('../')
end

function [DataTable_corrected] = correctCellNumberForBeadCounts(DataTable,compartments)

    DataTable_corrected = DataTable;

    DataTable_corrected.mature = DataTable_corrected.CD34negativ+DataTable_corrected.CD45nichtdim+DataTable_corrected.lin_p;
    n_div_max_measured = sum(~cellfun('isempty', regexp(DataTable_corrected.Properties.VariableNames, 'CD34negativ', 'once')))-1;

    ID1 = zeros(1,size(DataTable_corrected,2)); %opt.modelStates of specific generation and specific cell type 
    ID2 = zeros(1,size(DataTable_corrected,2)); %opt.modelStates of speific cell type 
    ID3 = zeros(1,size(DataTable_corrected,2)); %opt.modelStates of specific generation
    for i=1:n_div_max_measured
       for j=1:length(compartments)
            ID1 = ID1 + (~cellfun('isempty', regexp(DataTable_corrected.Properties.VariableNames, ['g',num2str(i)], 'once')) & ~cellfun('isempty', regexp(DataTable_corrected.Properties.VariableNames, compartments{j}, 'once')));
            if i==1
                ID2 = ID2+ (~cellfun('isempty', regexp(DataTable_corrected.Properties.VariableNames, compartments{j}, 'once')) & cellfun('isempty', regexp(DataTable_corrected.Properties.VariableNames, 'g', 'once')));
            end
       end
       ID3 = ID3 + (~cellfun('isempty', regexp(DataTable_corrected.Properties.VariableNames, ['g',num2str(i)], 'once')) & cellfun('isempty', regexp(DataTable_corrected.Properties.VariableNames, '_', 'once')));
    end
    ID=ID1+ID2+ID3;
    for id=find(ID>0)
        DataTable_corrected{:,id} = DataTable_corrected{:,id}.*DataTable_corrected.correctionFactor;
    end
    %DataTable.Properties.VariableNames(ID==1)
    %sum(sum([DataTable.HSC, DataTable.MPP, DataTable.MEP, DataTable.CMP, DataTable.GMP, DataTable.MLP],2)<DataTable.lin_neg)
 
end