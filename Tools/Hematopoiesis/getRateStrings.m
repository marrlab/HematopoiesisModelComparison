function [prolif_rate,diff_rates_i,diff_rates_o,death_rate] = getRateStrings(rates_str,modelState)

    % diff rates going out
    ID_D_o = find(strwcmp(rates_str,['*a_',modelState,'*']));
    diff_rates_o = [];
    if ~isempty(ID_D_o)
        if length(ID_D_o)==1
            diff_rates_o = rates_str{ID_D_o};
        else
            for i=1:length(ID_D_o)
                diff_rates_o{i} = rates_str{ID_D_o(i)}(~isspace(rates_str{ID_D_o(i)}));
            end
        end
    end
    % diff rates coming in
    ID_D_i = find(strwcmp(rates_str,['*a_*_',modelState,'*']));
    diff_rates_i = [];
    if ~isempty(ID_D_i)
        if length(ID_D_i)==1
            diff_rates_i = rates_str{ID_D_i};
        else
            for i=1:length(ID_D_i)
                diff_rates_i{i} = rates_str{ID_D_i(i)}(~isspace(rates_str{ID_D_i(i)}));
            end
        end
    end
    % proliferation rate
    ID_p = find(strwcmp(rates_str,['*b_',modelState,'*']));
    if ~isempty(ID_p)
        prolif_rate = rates_str{ID_p};
    else
        prolif_rate = [];
    end
    %death rate
    ID_d = find(strwcmp(rates_str,['*g_',modelState,'*']));
    if ~isempty(ID_d)
        death_rate = rates_str{ID_d};
    else
        death_rate = [];
    end
    
end