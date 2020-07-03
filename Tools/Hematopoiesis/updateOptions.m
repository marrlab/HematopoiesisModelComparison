function [opt] = updateOptions(data,opt)
    opt.n_repetitions = max(data.repetition);
    if ~opt.fitInitialConds
        opt.n_initialConds_N = 0;
    else
        if opt.fit_repetitions_seperately
            opt.n_initialConds_N=1;
        else
            opt.n_initialConds_N = opt.n_repetitions;
        end
    end
    [~,~,opt] = getModelParams(opt,opt.model);
end