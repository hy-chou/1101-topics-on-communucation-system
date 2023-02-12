% 4(a)
l = 10;
bin_seq = randi([0 1], 1, l);
d = 1;
M = 2;
name = "PSK";
u_seq = symbol_mapper(bin_seq, M, d, name)
u_size = size(u_seq, 2);

SNR = 10; % SNR = [0, 10, 20];

Eb = getEb(M, d, name);
N0 = Eb / 10^(SNR/10);
n_real = randn(1, u_size) * sqrt(N0 / 2);
n_imag = randn(1, u_size) * sqrt(N0 / 2);
r_seq = u_seq + n_real + 1i * n_imag;

demod_seq = MD_symbol_demapper(r_seq, M, d, name);

impulse_response = [1, 0, 1; 1, 1, 1];
decoded_data = conv_dec(demod_seq, impulse_response)
    
clear