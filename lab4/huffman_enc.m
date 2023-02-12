function bin_seq = huffman_enc(sym_seq, dict)
    bin_seq = '';
    s = size(sym_seq, 2);
    for i = 1:s
        p = 1;
        while true
            if cell2mat(dict(p, 1)) ~= cell2mat(sym_seq(i))
                p = p + 1;
                if p > ceil(size(dict, 1)/2)
                    error('ERROR')
                end
                continue
            end
            bin_seq = strcat(bin_seq, dict(p, 5));
            break
        end
    end
    bin_seq = cell2mat(bin_seq);
end