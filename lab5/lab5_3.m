% (i)
n = 100001;
alice = randi([0, 1], 1, n);

% (ii)
FIR = [1, 1, 0; 1, 0, 1];
fsm(FIR)
% alice_enc = conv_enc(alice, FIR);
% 
% % (iii)
% p = 0:0.1:1;
% BER = zeros(size(p));
% for i = 1:size(p, 2)
%     bob = mbsc(alice_enc, p(i));
% 
% % (iv)
%     bob_dec = conv_dec(bob, FIR);
% 
% % (v)
%     BER(i) = sum(xor(alice, bob_dec)) / n;
% end
% 
% plot(p, BER, '-o', [0, 1], [1, 1], 'white');
% grid on; xticks([0, 0.5 1]); yticks([0, 0.5 1]);
% title('3');xlabel('p');ylabel('BER');
% legend('BER');
% 
% clear;