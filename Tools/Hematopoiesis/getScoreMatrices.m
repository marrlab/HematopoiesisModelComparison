function [AIC_all_mat,AIC_corrected_all_mat,BIC_all_mat,LOGL_all_mat,AIC_mat,AIC_corrected_mat,BIC_mat,LOGL_mat,MS_num_mat] = getScoreMatrices(Scores_all,Scores,MS_num,iS_ID)
    AIC_all_mat = Scores_all{1,iS_ID};
    AIC_corrected_all_mat = Scores_all{2,iS_ID};
    BIC_all_mat = Scores_all{3,iS_ID};
    LOGL_all_mat = Scores_all{4,iS_ID};
    AIC_mat = Scores{1,iS_ID};
    AIC_corrected_mat = Scores{2,iS_ID};
    BIC_mat = Scores{3,iS_ID};
    LOGL_mat = Scores{4,iS_ID};
    MS_num_mat = MS_num{iS_ID};
end