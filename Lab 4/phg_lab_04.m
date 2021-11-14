%% BIOENGENHARIA - LABORATORIO 04
% Aluno: Pedro Henrique Garcia Macedo
% R.A.: 1829696

%% Ex. 1a.
clear; clc; close all

a = xlsread("p_8_1.xls");
a = a(1:end-1);
n = length(a);
fs = 1000;
A = fft(a);
A = abs(A);
A = A(1:end/2);
freq = 0:fs/n:fs/2-fs/n;
figure(1)
plot(freq, A)
title("Sinal impulso nervoso")
ylabel("amplitude (v)")
xlabel("frequência (Hz)")
[~, I] = max(A);
freq_dom = freq(I);

% a frequência dominante é 242.1875

%% Ex. 1b.

fs = 1000;
n = length(a);
t = 0:1/fs:(n-1)/fs;
figure(2)
plot(t,a)
title("Sinal impulso nervoso")
ylabel("amplitude (v)")
xlabel("tempo (s)")
figure
im = imread("pulso.jpg");
image(im)

% Conforme a imagem, o um pulso tem 30 milisegundos.
% Conforme o plot do sinal, vemos que há muito ruído de alta e baixa
% frequência.


%% Ex. 2.
a = xlsread("p_8_2.xls");
a1 = a(:,1);
a2 = a(:,2);
a3 = a(:,3);
n = length(a1);
fs = 1000;


% Item 1
A = fft(a1);
A = abs(A);
A = A(1:end/2);
freq = 0:fs/n:fs/2-fs/n;
figure(3)
subplot(3,1,1);
plot(freq, A)
title("Sinal 1")
ylabel("amplitude (v)")
xlabel("frequência (Hz)")
[~, I] = max(A);
freq_dom1 = freq(I);

% Item 2
A = fft(a2);
A = abs(A);
A = A(1:end/2);
freq = 0:fs/n:fs/2-fs/n;
subplot(3,1,2);
plot(freq, A)
title("Sinal 2")
ylabel("amplitude (v)")
xlabel("frequência (Hz)")
[~, I] = max(A);
freq_dom2 = freq(I);

% Item 3
fs = 1000;
A = fft(a3);
A = abs(A);
A = A(1:end/2);
freq = 0:fs/n:fs/2-fs/n;
subplot(3,1,3);
plot(freq, A)
title("Sinal 3")
ylabel("amplitude (v)")
xlabel("frequência (Hz)")
[~, I] = max(A);
freq_dom3 = freq(I);

% São sinais muito ruidosos. A frequência dominante das gravacões sao
% 183.5938 Hz, 136.7188 Hz e 160.1563 Hz para as gravações 1, 2 e 3
% respectivamente.

%% Ex 2b.
a = xlsread("p_8_2.xls");
a1 = a(:,1);
a2 = a(:,2);
a3 = a(:,3);
n = length(a1);
fs = 1000;
t = 0:1/fs:(n-1)/fs;

% Sinal 1
figure(4)
subplot(3,1,1);
plot(t,a1)
title("Sinal 1")
ylabel("amplitude (v)")
xlabel("tempo (s)")

% Sinal 2
subplot(3,1,2);
plot(t,a2)
title("Sinal 2")
ylabel("amplitude (v)")
xlabel("tempo (s)")

% Sinal 3

subplot(3,1,3);
plot(t,a3)
title("Sinal 3")
ylabel("amplitude (v)")
xlabel("tempo (s)")

% Medições dos pulsos
figure(5)
im = imread("pulsos_ex2.jpg");
image(im)


% As durações de pulso são de aproximadamente 29 ms para os sinais 1, 2 e 3
% respectivamente, e no final os sinais quase não apresentam atividade
% elétrica



