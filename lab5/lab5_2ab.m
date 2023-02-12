% 2(a)
binary_data = [1, 0, 1, 1, 0];
impulse_response = [1, 0, 0; 1, 0, 1; 1, 1, 1];
encoded_data = conv_enc(binary_data, impulse_response);

% 2(b)
d = [0, 1, 0, 0, 0, 0, 1, 0, 1, 1, 1, 1, 0, 0, 1, 0, 1, 1, 0, 0, 0];
decoded_data = conv_dec(d, impulse_response);

y = [0, 0, 1, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0];
g = [1, 0, 1; 1, 1, 1];
decoded_data = conv_dec(y, g);

clear;