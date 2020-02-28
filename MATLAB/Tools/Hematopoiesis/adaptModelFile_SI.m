function [] = adaptModelFile_SI(model,opt)

opt.RUN = 'topology_comparison_BIC'; 
%% rates string without brackets
for i=1:length(opt.rates)
    rates_str{i} = strrep(opt.rates{i},'{','');
    rates_str{i} = strrep(rates_str{i},'}','');
    rates_str{i} = rates_str{i}(~isspace(rates_str{i}));
end
n_prolif = sum(strwcmp(rates_str,'b_*'));
n_diff = sum(strwcmp(rates_str,'a_*'));
n_death = sum(strwcmp(rates_str,'g_*'));

%% write .m file for structural identifiability analysis
if any(strcmp(model,opt.models_implemented))
    FileName2 = ['z_create_hematopoiesis_',model,'.m'];
else
    error('This model is not implemented. Go to adaptSymsFile!')
end
CD = cd();
cd(opt.structIdent_path);
str = fileread(FileName2);
T2 = textread(FileName2, '%s', 'delimiter', '\n','bufsize', max(size(str)));
cd(CD);

%% 1) Correct number of states (= opt.n_divStates * opt.n_intermediateStates(iS_ID) * (length(opt.modelStates)-1) +1 if strcmp(opt.modelStates,'D')
if opt.n_intermediateStates(opt.iS_ID)==1
    [T2_new] = adaptModelFile_SI_noIS(T2,opt,model,rates_str);
else
    [T2_new] = adaptModelFile_SI_multipleIS(T2,opt,opt.iS_ID,model,rates_str,n_prolif,n_diff,n_death);
end

cd(opt.structIdent_path);
FID = fopen(FileName2, 'wb');
if FID < 0 
    error('Cannot open file.'); 
end
fprintf(FID, '%s\n', T2_new{:});
fclose(FID);
cd(CD);
end