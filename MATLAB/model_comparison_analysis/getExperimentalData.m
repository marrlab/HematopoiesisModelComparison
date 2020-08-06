function [data] = getExperimentalData(idx_individual,opt)
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
%% load preprocessed data:
cd('./data')
load('Data_preprocessed.mat','DataTable')
writetable(DataTable,['hematopoiesis_FACS_',opt.fileName(1:12),'.txt'],'Delimiter',' ') 
cd(opt.c_path);

% data belonging to individual idx_individual:
S_idx = strwcmp(DataTable.sample_name,[opt.individuals{idx_individual}(1:3),'*']);

sample_selection = unique(DataTable.sample_name(S_idx==1));
wdhl = unique(DataTable.repetition(S_idx==1));

data.repetition = [];
data.replicate = [];
if opt.fit_repetitions_seperately
    data.y0 = cell(1,1);
    k_end=1;
else
    data.y0 = cell(length(wdhl),1);
    k_end=length(wdhl);
end

%% store cell counts
[data] = storeCellCounts(data,k_end,sample_selection,wdhl,opt);

%% store number of cell divisions
[data] = storeNumberOfCellDivisions(opt,data,S_idx);

    function [data] = storeCellCounts(data,k_end,sample_selection,wdhl,opt)
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
    end

    function [data] = storeNumberOfCellDivisions(opt,data,S_idx)
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
        for is=1:length(opt.modelStates)
            selection2 = ~cellfun('isempty', regexp(DataTable.Properties.VariableNames, opt.modelStates{is}, 'once'));
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
                counter_d=1;
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
                        data.NumCellDiv_SUM{id1,id2}(counter_d,:) = CD_SUM(A_ID,:);
                        data.NumCellDiv_ALL{id1,id2}(counter_d,:) = CD_ALL(A_ID,:);
                        data.NumCellDiv_F_SUM{id1,id2}(counter_d,:) = CD_SUM(A_ID,:)./sum(CD_SUM(A_ID,:));
                        data.NumCellDiv_F_ALL{id1,id2}(counter_d,:) = CD_ALL(A_ID,:)./sum(CD_ALL(A_ID,:));
                        counter_d=counter_d+1;
                    end
                end
            end
        end
        data.CellDiv_All_str = opt.modelStates;
        
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

end