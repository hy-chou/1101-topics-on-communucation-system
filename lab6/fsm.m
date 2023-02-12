function [c, post] = fsm(g)
    n = size(g, 1);
    K = size(g, 2);

    c = zeros(2^K, n);
    post = zeros(2^K, 1);
    for i = 1:2^K
        reg = bitget(i - 1, K:-1:1);

        for j = 1:n
            s = sum(reg .* g(j, :));
            c(i, j) = mod(s, 2);
        end

        post(i) = bitshift(i - 1, -1);
    end