function Eb = getEb(M, d, name)
    if name == "PAM"
        Eb = d^2 * (M^2 - 1) / 12 / log2(M);
    elseif name == "PSK"
        Eb = (d/2)^2 / log2(M) / (sin(pi/M))^2;
    elseif name == "QAM"
        Eb = d^2 * (M - 1) / 6 / log(M);
    else
        error('name should be "PAM", "PSK" or "QAM".');
    end