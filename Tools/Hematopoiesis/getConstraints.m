function [A,b] = getConstraints(state_names,par_names)
    A=[];
    for s_id=1:length(state_names)
        diff_out = strwcmp(par_names,['a_{',state_names{s_id},'*']);
        diff_in = strwcmp(par_names,['*',state_names{s_id},'}}']);
        prol = strwcmp(par_names,['b_{',state_names{s_id},'*']);
        apop = strwcmp(par_names,['g_{',state_names{s_id},'*']);
        if strcmp(state_names{s_id},'MLP')
            %sum(diff_in)+ prol_net -sum(diff_out) > 0 <-> -sum(diff_in)- prol_net +sum(diff_out) <0
            A=[A;-diff_in-prol+diff_out];
        else
            %prol - apop > 0   <-> (-prol+apop <=0)
            A=[A;-prol+apop];
            %sum(diff_in)+ prol - apop -sum(diff_out) > 0 <-> -sum(diff_in)- prol + apop +sum(diff_out) <0
            A=[A;-diff_in-prol+apop+diff_out];
        end
    end
    b=zeros(size(A,1),1);
end