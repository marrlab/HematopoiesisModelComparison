function [Y_t] = transformModelOutput(Y,opt)

    switch opt.dataType
        case 'totalNumbers'
           Y_t = Y;
        case 'logTotalNumbers'
           Y_t= log(Y+1); 
        case 'log2TotalNumbers'
           Y_t = log2(Y+1);   
        case 'log10TotalNumbers'
           Y_t = log10(Y+1); 
        case 'percentages'
           Y_t = 100.*(Y./sum(Y,2));
    end
    

end