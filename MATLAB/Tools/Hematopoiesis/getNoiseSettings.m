function [opt] = getNoiseSettings(opt,noiseLevel)
    switch noiseLevel 
        case 'weak'
            switch opt.noiseType 
                case 'LogLaplace'
                    opt.sigma=0.4/sqrt(2);
                case 'LogNormal'
                    opt.sigma=0.4;
            end
        case 'middle'
            switch opt.noiseType 
                case 'LogLaplace'
                    opt.sigma=0.8/sqrt(2);
                case 'LogNormal'
                    opt.sigma=0.8;
            end
        case 'strong'
            switch opt.noiseType 
                case 'LogLaplace'
                    opt.sigma=1.2/sqrt(2);
                case 'LogNormal'
                    opt.sigma=1.2;
            end
        case 'realistic'
            if strwcmp(opt.noiseType,'Log*')
                opt.sigma=getRealisticNoiseLevelFromRealDataFitResults(opt);
            end
        otherwise
            opt.sigma=[];
            error('noise level option not implemented! Specify in function getAppSettings first!')
    end
end