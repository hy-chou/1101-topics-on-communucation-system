% 2(a)
symbols = {  'a',   'b',   'c',   'd',   'e',   'f',   'g',   'h'};
prob    = [0.200, 0.050, 0.005, 0.200, 0.300, 0.050, 0.045, 0.150];

dict = huffman_dict(symbols, prob);

% 2(b)
sym_seq = {'g', 'a', 'c', 'a', 'b'};
bin_seq = huffman_enc(sym_seq, dict);

% 2(c)
sym_seq = huffman_dec(bin_seq, dict);

% 3(a)
s = size(prob, 2);
[prob, I] = sort(prob,'descend');
symbols = symbols(I);
prob_CDF = zeros(1, s);
prob_CDF(1) = prob(1);
for i = 2:s
    prob_CDF(i) = prob_CDF(i-1) + prob(i);
end

n = 10;

r = rand(1, n);
sym_seq = cell(1, s);
for i = 1:n
    j = 1;
    while r(i) > prob_CDF(j)
        j = j + 1;
    end
    sym_seq(i) = symbols(j);
end
bin_seq = huffman_enc(sym_seq, dict);
length = size(bin_seq, 2);

% 3(b)
R = 200;
L = zeros(1, R);
for x = 1:R
    r = rand(1, n);
    sym_seq = cell(1, n);
    for i = 1:n
        j = 1;
        while r(i) > prob_CDF(j)
            j = j + 1;
        end
        sym_seq(i) = symbols(j);
    end
    bin_seq = huffman_enc(sym_seq, dict);

    L(x) = size(bin_seq, 2);
end

L_mean = num2str(mean(L));
histogram(L);
title(['L_{10}(200) = ', L_mean]);

% 3(c)
mat_R = [10, 20, 50, 100, 200, 500, 1000];
mat_n = [10, 50, 100];

L_avg = zeros(size(mat_R, 2), size(mat_n, 2));
for x = 1:size(mat_R, 2)
    for y = 1:size(mat_n, 2)
        R = mat_R(x);
        n = mat_n(y);

        L = zeros(1, R);
        for k = 1:R
            r = rand(1, n);
            sym_seq = cell(1, n);
            for i = 1:n
                j = 1;
                while r(i) > prob_CDF(j)
                    j = j + 1;
                end
                sym_seq(i) = symbols(j);
            end
            bin_seq = huffman_enc(sym_seq, dict);

            L(k) = size(bin_seq, 2);
        end

        L_avg(x, y) = mean(L) / n;
    end
end

semilogx(mat_R, L_avg);
yline(2.53,'--','entropy');
yline(2.6,'--','average codeword length');
grid on;
legend('n = 10', 'n = 50', 'n = 100');
title('experimental average codeword length');xlabel('R');ylabel('\overline{L}_n(R)');

clear;