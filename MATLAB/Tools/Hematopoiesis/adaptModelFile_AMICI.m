function [] = adaptModelFile_AMICI(model,opt,iS_ID)

%% rates string without brackets
for i=1:length(opt.rates)
    rates_str{i} = strrep(opt.rates{i},'{','');
    rates_str{i} = strrep(rates_str{i},'}','');
    rates_str{i} = rates_str{i}(~isspace(rates_str{i}));
end
n_prolif = sum(strwcmp(rates_str,'b_*'));
n_diff = sum(strwcmp(rates_str,'a_*'));
n_death = sum(strwcmp(rates_str,'g_*'));

%% create string of filename
if any(strcmp(model,opt.models_implemented))
    FileName1 = [model,'_',num2str(opt.n_intermediateStates(iS_ID)),'_syms.m'];
else
    error('This model is not implemented. Go to adaptSymsFile!')
end

CD = cd();
cd([opt.a_path,'\hematopoiesis']);
str = fileread(FileName1);
T = textread(FileName1, '%s', 'delimiter', '\n','bufsize', max(size(str)));
cd(CD);

%% 1) Correct number of states (= opt.n_divStates * opt.n_intermediateStates(iS_ID) * (length(opt.modelStates)-1) +1 if strcmp(opt.modelStates,'D')
if opt.n_intermediateStates(iS_ID)==1
    [T_new] = adaptModelFile_AMICI_noIS(T,opt,iS_ID,rates_str);
else
    [T_new] = adaptModelFile_AMICI_multipleIS(T,opt,iS_ID,rates_str,n_prolif,n_diff,n_death);
end

cd([opt.a_path,'/hematopoiesis']);
FID = fopen(FileName1, 'wb');
if FID < 0 
    error('Cannot open file.'); 
end
fprintf(FID, '%s\n', T_new{:});
fclose(FID);
cd(CD);

end