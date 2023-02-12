function decoded = conv_dec(msg, g)
    n = size(g, 1);
    K = size(g, 2);
    KK = 2^(K-1);
    msg_size = size(msg, 2);
    l = msg_size / n;

    [c, ~] = fsm(g);

    y = zeros(n, l);
    for i = 1:n
        for j = 1:l
            y(i, j) = msg(i + (j-1) * n);
        end
    end
    
%     Viterbi Algorithm
    
    Vv = zeros(l + 1, KK);
    Vs = zeros(l + 1, KK);
    Vv(1, 2:KK) = ones(1, KK - 1) * (K * l);
    Vs(1, 1:KK) = ones(1, KK) * -1;
    for i = 1:l
        for state = 0:KK-1
            reg0 = state * 2;
            reg1 = state * 2 + 1;
            c0 = c(reg0 + 1, :);
            c1 = c(reg1 + 1, :);
            yy = y(:, i)';
            pre0 = mod(reg0, KK);
            pre1 = mod(reg1, KK);
            dH0 = sum(xor(c0, yy));
            dH1 = sum(xor(c1, yy));
            v0 = Vv(i, pre0 + 1) + dH0;
            v1 = Vv(i, pre1 + 1) + dH1;
            if v0 <= v1
                Vv(i + 1, state + 1) = v0;
                Vs(i + 1, state + 1) = pre0;
            else
                Vv(i + 1, state + 1) = v1;
                Vs(i + 1, state + 1) = pre1;
            end
        end
    end
    
    minv = Vv(l + 1, 1);
    last_pos = 1;
    for i = 2:KK
        if Vv(l + 1, i) < minv
            minv = Vv(l + 1, i);
            last_pos = i;
        end
    end

    path = zeros(1, l + 2);
    path(l + 2) = last_pos - 1;
    path(l + 1) = Vs(l + 1, last_pos);
    for i = l:-1:1
        path(i) = Vs(i, path(i + 1) + 1);
    end

    decoded = zeros(1, l);
    for i = 1:l
        decoded(i) = bitshift(path(i + 2), 2-K);
    end