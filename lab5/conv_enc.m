function encoded = conv_enc(msg, g)
    n = size(g, 1);
    K = size(g, 2);
    msg_size = size(msg, 2);

    [c, post] = fsm(g);

%     enc = zeros(n, b_size);
    encoded = zeros(1, n * msg_size);
    s = 0;
    for i = 1:msg_size
        reg = bitshift(msg(i), K-1) + s;
        for j = 1:n
%             enc(j, i) = c(reg + 1, j);
            encoded(j + (i - 1) * n) = c(reg + 1, j);
        end
        s = post(reg + 1);
    end