% logL__N.m provides the log-likelihood, its gradient and an 
% approximation of the Hessian matrix based on Fisher information matrix
% for the conversion reaction process.
function [varargout] = logL_H(varargin)

%% CHECK AND ASSIGN INPUTS
if nargin >= 1
    par = varargin{1};
else
    error('logL_H requires a parameter object as input.');
end
if nargin >= 2
    data = varargin{2};
else
    error('logL_H requires a data object as input.');
end
% Check and assign options
if nargin >= 3
    opt = varargin{3};
else
    error('logL_H requires an opt object as input.');
end
if nargin >= 4
    sample_ID = varargin{4};
else
    error('logL_H requires a sample_ID object as input.');
end
if nargin == 5
    lambda = varargin{5};
end
%bounds for indices:
nPar = length(par);% parameters

%need par as column vector
[a,b]=size(par);
if a<b
    par=par';
end

if opt.applyParConstraints
    % check constraints
    par_lin=transformParBack(par,opt);
    par_check = ((isempty(opt.A)&&isempty(opt.b)) || (sum(opt.A*par_lin<=opt.b)==length(opt.b)));
else
    par_check = true;
end

if par_check % all constraints fullfilled
    switch opt.optimizationMode 
        case 'hierarchical'
            %get Data in right format/ shape
            %set options
            %simulate model
           [simulation,D] = simulateAllExperiments(data,opt,par);
           if strcmp(opt.HO.distribution,'laplace')
               [LOGL,LOGL_D] = logLikelihoodHierarchical(simulation,D,opt.HO);
           elseif strcmp(opt.HO.distribution,'normal')
               [LOGL,LOGL_D,FIM] = logLikelihoodHierarchical(simulation,D,opt.HO);
           end
        case 'standard'
            [LOGL,LOGL_D,FIM] = logLikelihoodStandard(par,data,nPar,opt);
    end
    if strcmp(opt.RUN,'topology_comparison_L1')
       v=zeros(size(par));
       v(strwcmp(opt.rates,'a_*'))=1;
       LOGL = LOGL+lambda*sum(abs(par(strwcmp(opt.rates,'a_*'))));
       LOGL_D = LOGL_D+lambda*v;
    end
else
    LOGL = opt.par_init_TH;%very small number such that set of parameter values is rejected
    LOGL_D = zeros(nPar,1);
    FIM = zeros(nPar);
end
 
assert(~isnan(LOGL) && imag(LOGL)==0 && ~isinf(LOGL), 'improper logL value')

switch nargout
    case 1
        varargout{1} = LOGL;  
    case 2 
        varargout{1} = LOGL;
        varargout{2} = LOGL_D;
    case 3
        varargout{1} = LOGL;
        varargout{2} = LOGL_D;
        varargout{3} = FIM;
end

end

    

    
