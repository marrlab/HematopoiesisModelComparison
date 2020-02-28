function [D] = getAndTransformDataSelection(data,opt,i_repe,i_repl)

    if opt.fit_repetitions_seperately
       i_repe = 1; 
    end
    if opt.n_divStates>1 && ~opt.plotCompartmentSum
        D.Y = data.NumCellDiv_ALL{i_repe,i_repl};
        D.Y0 = data.NumCellDiv_ALL_Y0{i_repe,i_repl};
        D.t = data.timeDiv{i_repe,i_repl};
    else
        D.Y = data.ym{i_repe,i_repl};
        D.Y0 = data.y0{i_repe};
        D.t = data.t{i_repe,i_repl};
    end
    D.DL = data.detectionLimit_corrected{i_repe,i_repl};
    if strwcmp(opt.noiseType,'Log*')
        Y = exp(D.Y)-1;
        Y0 = exp(D.Y0)-1;
        DL = exp(D.DL)-1;
    else
        Y = D.Y;
        Y0 = D.Y0;
        DL = D.DL;
    end

    switch opt.dataType
        case 'totalNumbers'
           D.Y_t = Y;
           D.Y0_t = Y0;
           D.DL_t = DL;
           D.axis_str = [];
        case 'logTotalNumbers'
           D.Y_t = log(Y+1); 
           D.Y0_t = log(Y0+1); 
           D.DL_t = log(DL+1);
           D.axis_str = 'log ';
        case 'log2TotalNumbers'
           D.Y_t = log2(Y+1);   
           D.Y0_t = log2(Y0+1);   
           D.DL_t = log2(DL+1);
           D.axis_str = 'log_2 ';
        case 'log10TotalNumbers'
           D.Y_t = log10(Y+1); 
           D.Y0_t = log10(Y0+1); 
           D.DL = log10(DL+1);
           D.axis_str = 'log_{10} ';
        case 'percentages'
           D.Y_t = 100.*(Y./sum(Y,2));
           D.Y0_t = 100.*(Y0./sum(Y0,2));
           D.DL_t = 100.*(DL./sum(DL,2));
           D.axis_str = [];
    end
end