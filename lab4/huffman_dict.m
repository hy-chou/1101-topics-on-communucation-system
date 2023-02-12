function dict = huffman_dict(symbols, prob)
    s_init = size(prob, 2);
    s = s_init;
    p = 1;
    dict = cell(s, 5);

    for i = 1:s
        dict(i, 1) = symbols(i);
        dict(i, 2) = num2cell(prob(i));
    end
    
    while p <= s
        s = size(dict, 1);
        symbols = cell(1, s);
        prob = zeros(1, s);
        for i = 1:s
            symbols(i) = dict(i, 1);
            prob(i) = cell2mat(dict(i, 2));
        end
        [~, prob_index] = sort(prob);

        rc = prob_index(p);
        lc = prob_index(p + 1);
        dict(s+1, 1) = strcat(symbols(lc), symbols(rc));
        dict(s+1, 2) = num2cell(prob(lc) + prob(rc));
        dict(s+1, 3) = num2cell(lc);
        dict(s+1, 4) = num2cell(rc);
        
        p = p + 2;
    end

    s = size(dict, 1);
    dict(s, 5) = cellstr('');
    for i = 0:floor(s/2)-1
        lc = cell2mat(dict(s-i, 3));
        rc = cell2mat(dict(s-i, 4));
        dict(lc, 5) = cellstr(strcat(dict(s-i, 5), '0'));
        dict(rc, 5) = cellstr(strcat(dict(s-i, 5), '1'));
    end
end