%% BIOENGENHARIA - LABORATORIO 01
% Aluno: Pedro Henrique Garcia Macedo
% R.A.: 1829696

%% Ex 1.
% a.
x = @(t) (exp(-2.*t));
subplot(4,1,1)
fplot(x, [0, 10])

% b.
Ts = 0.1;
T = 0:Ts:10;
xd1 = x(T);
subplot(4,1,2)
stem(T, xd1, ".");
title("Ts = 0.1s")
xlabel("t (s)")
ylabel("y = exp(-2t)")

% c.
Ts = 1;
T = 0:Ts:10;
xd2 = x(T);
subplot(4,1,3)
stem(T, xd2);
title("Ts = 1s")
xlabel("t (s)")
ylabel("y = exp(-2t)")

% d.
Ts = 4;
T = 0:Ts:10;
xd2 = x(T);
subplot(4,1,4)
stem(T, xd2);
title("Ts = 4s")
xlabel("t (s)")
ylabel("y = exp(-2t)")

% e. 
% O mlehor período de amostragem é de 0.1s.

%% Ex 2.
clear
load("p_1_2.mat")
whos
plot(x1);
grid on;
% d.
% Assumindo que a unidade é segundos, então o período é 10s, e a frequência
% de amostragem é 1/10;

% e. 
figure
plot(x2)
m2 = mean(x2./(1:length(x2)))
figure
plot(x3)
m3 = mean(x3./(1:length(x3)))
% Para o sinal x2, a inclinação média é 0.5231. Para o sinal x3 
% a inclinação média é 11.6956. 

%% Ex 3.
clear
load("p_2_9.mat")
x = y;
n = length(x);
X = abs(fft(x));
plot(y(1:n/2-1));
grid on;
xlabel("Frequency")
ylabel("Magnitude")
[~, freq_dom] = max(x);
% A frequência dominante é 34.

%% Ex 4.
clear
A = imread("p_2_10", "jpg");
A = A(:,:,1);
A_mag = abs(fft2(A));
% tem um nivel dc gigante de ~10E3
dc = rms(rms(A_mag));
A_mag_norm = A_mag - dc;
% tem um pixel muito maior, ver surf
% surf(A_mag_norm)
A_mag_norm(1,1) = 0;
figure(1)
image(A_mag_norm);
figure(2)
surf(A_mag_norm);

%% Ex 5.
% O comando fft() calcula a DFT de N pontos em apenas uma dimensão. 
% Como uma imagem possui duas dimensões, a função correta é a fft2()
% que calcula a DFT em 2 dimensões.

%% Ex 6.
% As componentes de baixa e alta frequência.

%% A. Complementar ?
% assumindo freq. de amostragem = 1000 Hz
fs = 1000;
fc = 200;
n = 9;

[b, a] = butter(n, 2*pi*fc, 'high', 's');
freqz(b, a, 512, fs);

