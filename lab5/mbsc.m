function output = mbsc(input, p)
    l = size(input, 2);
    output = input;
    if p == 0
        return
    end
    %     r = rand(1, l);
    for i = 1:l
        if rand() < p
            output(i) = not(output(i));
        end
    end