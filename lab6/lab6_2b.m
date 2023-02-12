% 2(b)
l = 10^4;
bin_seq = randi([0 1], 1, l);
d = 1;
M = 4;
name = "PSK";
u_seq = symbol_mapper(bin_seq, M, d, name);
u_size = size(u_seq, 2);

SNR = [0, 10, 20];
SER = zeros(1, 3);
for i = 1:3
    r_seq = awgn(u_seq, SNR(i), 'measured');
    demod_seq = MD_symbol_demapper(r_seq, M, d, name);

    for j = 1:u_size
        if u_seq(j) ~= demod_seq(j)
            SER(i) = SER(i) + 1;
        end
    end
end
SER = SER / u_size

clear