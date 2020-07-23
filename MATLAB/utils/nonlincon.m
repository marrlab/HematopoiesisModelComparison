function [c,ceq,dc,dceq] = nonlincon(theta,A,b,scale,scaleVec)

ceq = [];
dceq = [];

theta_lin = theta;
switch scale
    case 'log10'
        theta_lin = 10.^theta_lin;
    case 'partly_log10'
        theta_lin(scaleVec==-1,:)=exp(theta_lin(scaleVec,:))-1;
        theta_lin(scaleVec==1,:)=10.^(theta_lin(scaleVec,:));
end

c = A*theta_lin - b;
dc = (A*diag(theta_lin))';


