% 2(a)
l = 10^4;
bin_seq = randi([0 1], 1, l);
d = 1;
M = 4;
name = "PSK";

sym_seq = symbol_mapper(bin_seq, M, d, name);
sym_size = size(sym_seq, 2);

figure(1);
histogram2(real(sym_seq), imag(sym_seq), [10 10], 'FaceColor', 'flat');
colorbar; axis square;
title("2(a) \{u\}");

SNR = [0, 10, 20];
for i = 1:3
%     rec_seq = awgn(sym_seq, SNR(i), 'measured');
    Eb = getEb(M, d, name);
    N0 = Eb / 10^(SNR(i)/10);
    n_real = randn(1, sym_size) * sqrt(N0 / 2);
    n_imag = randn(1, sym_size) * sqrt(N0 / 2);
    rec_seq = sym_seq + n_real + 1i * n_imag;

    figure(2 * i);
    histogram2(real(rec_seq), imag(rec_seq), [100 100], 'FaceColor', 'flat');
    colorbar
    title("2(a) \{r\}"); subtitle("SNR = " + SNR(i) + "dB");
    line([-3, 3], [-3, 3], 'Color', 'red', 'LineStyle', '--', 'LineWidth', 3);
    line([3, -3], [-3, 3], 'Color', 'red', 'LineStyle', '--', 'LineWidth', 3);
    axis square;

    figure(2 * i + 1);
    histogram2(real(rec_seq), imag(rec_seq), [100 100], 'FaceColor', 'flat', 'DisplayStyle','tile');
    colorbar
    title("2(a) \{r\}"); subtitle("SNR = " + SNR(i) + "dB");
    line([-3, 3], [-3, 3], 'Color', 'red', 'LineStyle', '--', 'LineWidth', 3);
    line([3, -3], [-3, 3], 'Color', 'red', 'LineStyle', '--', 'LineWidth', 3);
    axis square;
end

clear