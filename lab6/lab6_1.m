% 1
M = 64; % for PAM, PSK: 2, 4, 8, 16; for QAM: 4, 16, 64
bin_seq = randi([0 1], 1, 10^4);
d = 100;
name = "QAM"; % "PAM", "PSK" or "QAM"

sym_seq = symbol_mapper(bin_seq, M, d, name);
scatterplot(sym_seq);

clear