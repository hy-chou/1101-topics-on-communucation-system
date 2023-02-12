function sym_seq = symbol_mapper(bin_seq, M, d, name)
    if (size(bin_seq, 1) > size(bin_seq, 2))
        bin_seq = bin_seq';
    end

    bin_size = size(bin_seq, 2);
    if (mod(bin_size, log2(M)) > 0)
        for i = 1:log2(M)-mod(bin_size, log2(M))
            bin_seq(bin_size + i) = 0;
        end
        bin_size = size(bin_seq, 2);
    end
    data = zeros(1, bin_size / log2(M));
    for i = 1:size(data, 2)
        for j = 1:log2(M)
            data(i) = data(i) + bin_seq(log2(M) * (i-1) + j) * 2^(j-1);
        end
    end

    if name == "PAM"
        sym_seq = pammod(data, M, 0, 'gray') / 2 * d;
    elseif name == "PSK"
        sym_seq = pskmod(data, M, 0, 'gray') / sqrt(2 - 2 * cos(2 * pi / M)) * d;
    elseif name == "QAM"
        sym_seq = qammod(data, M) / 2 * d;
    else
        error('name should be "PAM", "PSK" or "QAM".');
    end