function bin_seq = MD_symbol_demapper(sym_seq, M, d, name)
    if size(sym_seq, 1) > size(sym_seq, 2)
        sym_seq = sym_seq';
    end
    sym_size = size(sym_seq, 2);

    if name == "PAM"
        basis = pammod(0:M-1, M, 0, 'gray') / 2 * d;
    elseif name == "PSK"
        basis = pskmod(0:M-1, M, 0, 'gray') / sqrt(2 - 2 * cos(2 * pi / M)) * d;
    elseif name == "QAM"
        basis = qammod(0:M-1, M) / 2 * d;
    else
        error('name should be "PAM", "PSK" or "QAM".');
    end
    
    bin_seq = zeros(1, sym_size);
    for i = 1:sym_size
        min_d = abs(sym_seq(i) - basis(1));
        md_sym = 1;
        for j = 2:M
            d = abs(sym_seq(i) - basis(j));
            if d < min_d
                min_d = d;
                md_sym = j;
            end
        end
        bin_seq(i) = basis(md_sym);
    end