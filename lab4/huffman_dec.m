function sym_seq = huffman_dec(bin_seq, dict)
    sym_seq = {};
    dict_size = size(dict, 1);
    bin_seq_size = size(bin_seq, 2);

    ptr = dict_size;
    for i = 1:bin_seq_size
        if bin_seq(i) == '0'
            if isempty(cell2mat(dict(ptr, 3)))
                sym_seq(size(sym_seq, 2)+1) = dict(ptr, 1);
                ptr = dict_size;
            end
            ptr = cell2mat(dict(ptr, 3));
        elseif bin_seq(i) == '1'
            if isempty(cell2mat(dict(ptr, 4)))
                sym_seq(size(sym_seq, 2)+1) = dict(ptr, 1);
                ptr = dict_size;
            end
            ptr = cell2mat(dict(ptr, 4));
        end
    end
    sym_seq(size(sym_seq, 2)+1) = dict(ptr, 1);
end