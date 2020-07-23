    function [] = saveModelSelectionResult(opt,AIC_all_mat,AIC_corrected_all_mat,BIC_all_mat,LOGL_all_mat,AIC_mat,AIC_corrected_mat,BIC_mat,LOGL_mat,Time_mat,MS_num_mat)
        cd(opt.foldername)
        save(['ws_scores',add_str,'.mat'],'AIC_corrected_mat','AIC_mat','BIC_mat','LOGL_mat','Time_mat','AIC_corrected_all_mat','AIC_all_mat','BIC_all_mat','LOGL_all_mat','MS_num_mat')
        cd(opt.c_path);
    end