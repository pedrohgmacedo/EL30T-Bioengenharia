%% BIOENGENHARIA - LABORATORIO 08
% Aluno: Pedro Henrique Garcia Macedo
% R.A.: 1829696
%% Ex 1

% importar o sinal 

% 1.a.
data = load("p_11_1.txt");
t = data(:,1);
sig = data(:,2);
n = length(sig);
% sanity check: verificar se o plot de  t é linear
fs = n/t(end);
fft_freq = [0:1:n/2-1]*fs/n;


[pxx,f] = pwelch(sig,[],[],[],fs);
figure(1)
plot(f, 20*log10(pxx))

% plotando 

% 1.b.

% após o de-noise, File > Generate Matlab code (denoising process)

% código gerado pelo matlab
wname = 'db2';
level = 2;
sorh = 's';
thrSettings =  [...
    0.684683362173346 ; ...
    0.909570843446462   ...
    ];

sigDEN = cmddenoise(sig,wname,level,sorh,NaN,thrSettings);

% plotando
figure(2)
plot(sig, 'b'); 
hold on; 
plot(sigDEN, 'r'); 
hold off;

% 1.c. Calcular o AVR
AVR = sum(abs(sig)/length(sig));
