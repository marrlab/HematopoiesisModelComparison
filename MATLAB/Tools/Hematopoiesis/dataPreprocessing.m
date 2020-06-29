function [] = dataPreprocessing(possibleCompartments, bool_fitInitialConds, fileName)
load('Data.mat','DataTable')

% %% sort according to sample_name;
% DataTable = sortrows(DataTable,'sample_name');

%% add status
for i=1:size(DataTable.filename,1)
    if strwcmp(DataTable.filename{i},'*H*')
        DataTable.Status{i} = 'healthy';
    elseif strwcmp(DataTable.filename{i},'*MDS*')
        DataTable.Status{i} = 'MDS';
    end
end

%% add columns for mature cells and dead cells
DataTable.mature = DataTable.CD34negativ+DataTable.CD45nichtdim+DataTable.lin_pos;
n_div_max_measured = sum(~cellfun('isempty', regexp(DataTable.Properties.VariableNames, 'CD34negativ', 'once')))-1;
for i=1:n_div_max_measured
    selection_CD34negativ = ~cellfun('isempty', regexp(DataTable.Properties.VariableNames, ['g',num2str(i),'_CD34negativ'], 'once'));
    selection_CD45nichtdim = ~cellfun('isempty', regexp(DataTable.Properties.VariableNames, ['g',num2str(i),'_CD45nichtdim'], 'once'));
    selection_lin_p = ~cellfun('isempty', regexp(DataTable.Properties.VariableNames, ['g',num2str(i),'_lin_pos'], 'once'));
    DataTable_CD34negativ = DataTable(:,DataTable.Properties.VariableNames(selection_CD34negativ));
    DataTable_CD45nichtdim = DataTable(:,DataTable.Properties.VariableNames(selection_CD45nichtdim));
    DataTable_lin_pos = DataTable(:,DataTable.Properties.VariableNames(selection_lin_p));
    DataTable = [DataTable, table(DataTable_CD34negativ{:,:}+DataTable_CD45nichtdim{:,:}+DataTable_lin_pos{:,:},'VariableNames',{['g',num2str(i),'_mature']})];
end      
DataTable.dead = max(DataTable.p2-DataTable.viable,0);

%% check if sum of Celltype_gi equals Celltype_total and store deviations in excel sheet
for i=1:length(possibleCompartments)-1
    selection_sum = ~cellfun('isempty', regexp(DataTable.Properties.VariableNames, ['g*_',possibleCompartments{i}], 'once'));
    selection_total = (~cellfun('isempty', regexp(DataTable.Properties.VariableNames, possibleCompartments{i}, 'once')) & cellfun('isempty', regexp(DataTable.Properties.VariableNames, ['g*_',possibleCompartments{i}], 'once')));
    DataTable_selection_sum = sum(DataTable{:,DataTable.Properties.VariableNames(selection_sum)},2);
    DataTable_selection_total = DataTable{:,DataTable.Properties.VariableNames(selection_total)};
    if i==1
        T_error = table(DataTable.filename,DataTable_selection_sum-DataTable_selection_total);
        T_error.Properties.VariableNames{1} = 'fileName';
    else
        New_col = DataTable_selection_sum-DataTable_selection_total;
        T_error = [T_error,table(New_col)];
    end
    T_error.Properties.VariableNames{i+1}=[possibleCompartments{i},'total_minus_sumOf_gi_',possibleCompartments{i}];
end
writetable(T_error,['AbweichungInDaten_',fileName]);
    
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
[DataTable] = correctCellNumberForBeadCounts(DataTable,[possibleCompartments,'lin_pos','lin_neg']);

%% correct day: first day should be day 0 if initial conditions are not fit
if ~bool_fitInitialConds %start at 0 if first data point is used as known initial condition
    DataTable.Tag = DataTable.Tag-1;
end

% %% add column repetition
% f_str = cellfun(@(x) x(1:end-6), DataTable.filename, 'un', 0);
% Fnames_uni = unique(f_str,'stable');
% for i = 1:length(f_str)
%     f_str{i}(regexp(f_str{i},'[a-z]+'))='';
% end
% sampleNums_uni = unique(cellfun(@(x) x(max([regexp(x,'[H]'),regexp(x,'[MDS]')])+1:end), unique(f_str,'stable'), 'un', 0),'stable');
% sampleIDs_uni = unique(cellfun(@(x) x(max([regexp(x,'[H]'),regexp(x,'[MDS]')])+1:end), Fnames_uni, 'un', 0),'stable');
% DataTable.repetition = ones(size(DataTable,1),1);
% DataTable.replicate = ones(size(DataTable,1),1);
% for j=1:length(sampleNums_uni)
%     idx_Fn = find(cellfun(@(x) strwcmp(x(9:end),['*',sampleNums_uni{j},'*']), Fnames_uni));
%     %whenever length(idx_Fn)>1: more than 1 replicate and/or repetition
%     %idx_sID = find(strwcmp(sampleIDs_uni,['*',sampleNums_uni{j},'*']));
%     %whenever length(idx_Fn)>length(idx_sID) %more than 1 replicate
%     counter_repe=1;
%     timestamp = '';
%     bools = [true true true];
%     for k1=1:length(idx_Fn)
%         %repetition: unique time stamp or sampleIDs occur with 'a' and ''
%         %ending
%         idx_DT = find(strwcmp(DataTable.filename,[Fnames_uni{idx_Fn(k1)},'*']));
%         idx_a = find(strwcmp(Fnames_uni{idx_Fn(k1)},'*a*'));
%         idx_b = find(strwcmp(Fnames_uni{idx_Fn(k1)},'*b*'));
%         DataTable.repetition(idx_DT) = counter_repe.*ones(size(idx_DT));
%         if ~isempty(idx_b)
%             DataTable.replicate(idx_DT) = 2.*ones(size(idx_DT));
%             bools(3)=false;
%         else
%             DataTable.replicate(idx_DT) = ones(size(idx_DT));
%             if ~isempty(idx_a)
%                 bools(2)=false;
%             else
%                 bools(1)=false;
%             end
%         end
%         if (~strcmp(Fnames_uni{idx_Fn(k1)},timestamp) && bools(1)==false && isempty(idx_a) && isempty(idx_b)|| sum(bools(2:3)==false)==2)
%             counter_repe = counter_repe+1;
%             %update timestamp
%             timestamp = Fnames_uni{idx_Fn(k1)}(1:8);
%         end
%     end
% end

save('Data_preprocessed.mat','DataTable')
end

function [DataTable_corrected] = correctCellNumberForBeadCounts(DataTable,possibleCompartments)

    DataTable_corrected = DataTable;

    DataTable_corrected.mature = DataTable_corrected.CD34negativ+DataTable_corrected.CD45nichtdim+DataTable_corrected.lin_p;
    n_div_max_measured = sum(~cellfun('isempty', regexp(DataTable_corrected.Properties.VariableNames, 'CD34negativ', 'once')))-1;

    ID1 = zeros(1,size(DataTable_corrected,2)); %compartments of specific generation and specific cell type 
    ID2 = zeros(1,size(DataTable_corrected,2)); %compartments of speific cell type 
    ID3 = zeros(1,size(DataTable_corrected,2)); %compartments of specific generation
    for i=1:n_div_max_measured
       for j=1:length(possibleCompartments)
            ID1 = ID1 + (~cellfun('isempty', regexp(DataTable_corrected.Properties.VariableNames, ['g',num2str(i)], 'once')) & ~cellfun('isempty', regexp(DataTable_corrected.Properties.VariableNames, possibleCompartments{j}, 'once')));
            if i==1
                ID2 = ID2+ (~cellfun('isempty', regexp(DataTable_corrected.Properties.VariableNames, possibleCompartments{j}, 'once')) & cellfun('isempty', regexp(DataTable_corrected.Properties.VariableNames, 'g', 'once')));
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