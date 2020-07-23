function par0 = LHSconstraint(par_guess,par_min,par_max,n_starts,constr,scale,scaleVec)

par0_lin=[];
par0=[];
%LH sampling
par_number = length(par_min);
stopp=1;

while stopp==1
    theta_0 = [par_guess,...
              bsxfun(@plus,par_min,bsxfun(@times,par_max - par_min,...
                           lhsdesign(n_starts - size(par_guess,2),par_number,'smooth','off')'))];
    theta_0_lin= theta_0;
    if (strcmp(scale,'log') || strcmp(scale,'partly_log'))
        %re-transform: theta_0_lin is linear scale
           theta_0_lin(scaleVec,:)=exp(theta_0(scaleVec,:));
    elseif (strcmp(scale,'log10') || strcmp(scale,'partly_log10'))
        %re-transform: theta_0_lin is linear scale
           theta_0_lin(scaleVec==-1,:)=exp(theta_0(scaleVec==-1,:))-1;
           theta_0_lin(scaleVec==1,:)=10.^(theta_0(scaleVec==1,:));
    end

    %check if constraint is fullfilled for starting values:
    if (~isempty(constr.A) && ~isempty(constr.b))
        A=constr.A;
        b=constr.b;
        for i=1:n_starts
            if sum(A*theta_0_lin(:,i)<=b)==length(b) %% all constraints fullfilled
                par0_lin=[par0_lin theta_0_lin(:,i)];
                if (size(par0_lin,2) ==n_starts)
                    stopp=0;
                    break;
                end
            end
        end
    else
        par0_lin=theta_0_lin;
        stopp=0;
    end  
    
end

par0 = par0_lin;
if (strcmp(scale,'log') || strcmp(scale,'partly_log'))
       par0(scaleVec,:)=log(par0_lin(scaleVec,:));
elseif (strcmp(scale,'log10') || strcmp(scale,'partly_log10'))
       par0(scaleVec==-1,:)=log(par0_lin(scaleVec==-1,:)+1);
       par0(scaleVec==1,:)=log10(par0_lin(scaleVec==1,:));
end

end