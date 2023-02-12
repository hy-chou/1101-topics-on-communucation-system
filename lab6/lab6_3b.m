% 3(b)
M = [2, 4, 8, 16];
SNR = 0:10;

l = 10^7;
d = 1;
name = "PSK";
SER = zeros(4, 11);

for i = 1:4
    for j = 1:11
        bin_seq = randi([0 1], 1, l);
        u_seq = symbol_mapper(bin_seq, M(i), d, name);
        u_size = size(u_seq, 2);

%         r_seq = awgn(u_seq, SNR(j), 'measured');
        Eb = getEb(M(i), d, name);
        N0 = Eb / 10^(SNR(j)/10);
        n_real = randn(1, u_size) * sqrt(N0 / 2);
        n_imag = randn(1, u_size) * sqrt(N0 / 2);
        r_seq = u_seq + n_real + 1i * n_imag;

        demod_seq = MD_symbol_demapper(r_seq, M(i), d, name);

        for k = 1:u_size
            if u_seq(k) ~= demod_seq(k)
                SER(i, j) = SER(i, j) + 1;
            end
        end
        SER(i, j) = SER(i, j) / u_size;
    end
    Theo(i, :) = 2 * qfunc(sqrt(6*log2(M(i)) / (M(i)^2 - 1) * 10 .^ linspace(0, 1)));
end

grid on;
semilogy(SNR, SER(1, :), 'ro', SNR, SER(2, :), 'go', SNR, SER(3, :), 'bo', SNR, SER(4, :), 'ko');
legend('M = 2', 'M = 4', 'M = 8', 'M = 16');
title('3(b) PSK');xlabel('SNR(dB)');ylabel('SER');
hold on;

x = linspace(0, 10);
semilogy(x, Theo(1, :), 'r-', x, Theo(2, :), 'g-', x, Theo(3, :), 'b-', x, Theo(4, :), 'k-');
legend('M = 2', 'M = 4', 'M = 8', 'M = 16');

clear