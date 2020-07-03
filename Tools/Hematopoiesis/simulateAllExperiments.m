function [simulation,Data] = simulateAllExperiments(data,opt,par)
simulation = struct([]);
Data = struct([]);

nRepetitions = opt.n_initialConds_N;% matches the array size no matter if repetitions are fit together or not

%   D: (1 x #experiments) struct containing data with two fields
%       * t: time points
%       * my: # time points x # observables x # replicates
j=0;
for i_repe=1:nRepetitions %size(data.sample,2) %index for data sets/ fits
    if opt.fit_repetitions_seperately
        n_replicates = max(data.replicate);
    else
        n_replicates = max(data.replicate(data.repetition==i_repe));
    end
    for i_repl=1:n_replicates 
        j=j+1;
        if opt.n_divStates>1
            Data(j).my(:,:,1) = data.NumCellDiv_ALL{i_repe,i_repl};
            Data(j).t = data.timeDiv{i_repe,i_repl};%-min(data.timeDiv{i_repe,i_repl});
            if opt.n_initialConds_N==0
                Data(j).y0 = data.NumCellDiv_ALL_Y0{i_repe,i_repl};
            else
                Data(j).y0 = [];
            end
            Data(j).DL = data.detectionLimit_correctedDiv{i_repe,i_repl};
        else
            Data(j).my(:,:,1) = data.ym{i_repe,i_repl};
            if opt.n_initialConds_N==0
                Data(j).y0 = data.y0{i_repe};
            else
                Data(j).y0 = [];
            end
            Data(j).t = data.t{i_repe,i_repl};%-min(data.t{i_repe,i_repl});
            Data(j).DL = data.detectionLimit_corrected{i_repe,i_repl};
        end
        if isempty(Data(j).my(:,:,1))
            continue;
        end
        
        if opt.fitInitialConds==true
            ny0 = length(opt.modelStates); %number of parameters for initial per repetition and replicate
        else
            ny0=0;
        end
        % Data is a matrix of dimension nTime * nObs
        %initial conditions for this repetition available??
        if opt.fitInitialConds
            par_sim = [par(1+ny0*(i_repe-1):i_repe*ny0);par(opt.n_initialConds_N*ny0+1:end)]';
        else
            par_sim = par';
        end

        % parameter vector for simulation always contains current set of
        % initial conditions --> model output shou
        [sol] = sim_H(Data(j).y0,Data(j).t,par_sim,opt.model,opt,false,[],[]);
        simulation(j).y = sol.y;
        simulation(j).sy = zeros(length(Data(j).t),size(Data(j).my,2),length(par));
        simulation(j).sy(:,:,1+ny0*(i_repe-1):i_repe*ny0) = sol.sy(:,:,1:ny0);
        simulation(j).sy(:,:,nRepetitions*ny0+1:end) = sol.sy(:,:,ny0+1:end);
    end
end
