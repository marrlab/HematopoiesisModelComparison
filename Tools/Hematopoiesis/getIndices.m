    
function [DivState_Vec,IS_Mat,Offset] = getIndices(n_divStates,n_is,n_out_vec,CT_ID)
%gives the vector of division state and matrix of intermediate state
%indices for all equations of the current cell type
n_out = n_out_vec(CT_ID);
DivState_Vec = sort(repmat(1:n_divStates,1,n_out*n_is+1))';
IS_Mat = zeros((n_is*n_out+1)*n_divStates,n_out);
id=2;
for j=1:n_divStates*n_out
    for k=0:n_out-1
        if mod(j-(n_out-k),n_out)==0
            IS_Mat(id:id+n_is-1,n_out-k) = 1:n_is;
            id=id+n_is;
        end
    end
    if mod(j,n_out)==0
        id=id+1;
    end
end

if CT_ID>1
    Offset = sum((n_out_vec(1:CT_ID-1)*n_is+1).*n_divStates);
else
    Offset = 0;
end

end