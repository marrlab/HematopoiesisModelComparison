function [s_up_T,s_down_T] = getAndTransformErrorBand(Y,sigma,opt)
    
    if strwcmp(opt.noiseType,'Log*')
        Y=log(Y+1);
    end
        
    s_up = Y+2.*sigma;
    s_down = max(0,Y-2.*sigma);
    
    if strwcmp(opt.noiseType,'Log*')
        s_up = exp(s_up)-1;
        s_down = exp(s_down)-1;
    end  

    switch opt.dataType
        case 'totalNumbers'
           s_down_T = s_down;
           s_up_T = s_up;
        case 'logTotalNumbers'
           s_down_T = log(s_down+1);
           s_up_T = log(s_up+1);
        case 'log2TotalNumbers'
           s_down_T = log2(s_down+1);
           s_up_T = log2(s_up+1);
        case 'log10TotalNumbers'
           s_down_T = log10(s_down+1);
           s_up_T = log10(s_up+1);
        case 'percentages'
           s_down_T = 100.*(s_down./sum(Y,2));
           s_up_T = 100.*(s_up./sum(Y,2));
    end
end