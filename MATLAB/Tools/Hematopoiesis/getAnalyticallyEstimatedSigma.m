function [sigma_HO] = getAnalyticallyEstimatedSigma(opt)
    sigma_HO = [];
    if strcmp(opt.optimizationMode,'hierarchical')
        cd(['./',opt.foldername,'/',opt.subfoldername,'/',opt.subsubfoldername]);
        load('analytical_results.mat','noise');
        if length(size(noise))==4
            for i=1:size(noise,4)%noise: 1 x n_observables x 1 x repetition*replicates
                switch opt.noiseType 
                    case 'LogLaplace'
                        sigma_HO = [sigma_HO;noise(1,:,1,i)];%sigma_HO: repetition*replicates x n_observables 
                    case 'LogNormal'
                        sigma_HO = [sigma_HO;sqrt(noise(1,:,1,i))];%sigma_HO: repetition*replicates x n_observables 
                end
            end
        else
            switch opt.noiseType 
                case 'LogLaplace'
                    sigma_HO = noise;
                case 'LogNormal'
                    sigma_HO = sqrt(noise);
            end
        end
    end
    cd(opt.c_path);
end