%% BIOENGENHARIA - LABORATORIO 06
% Aluno: Pedro Henrique Garcia Macedo
% R.A.: 1829696

%% 1
data = xlsread("p_9_1.xls");
sig1 = data(:,1);
sig2 = data(:,2);
% o sinal foi coletado durante 1 min => 60 segundos
% isso dá 128 amostras por 60 segundos -> 128/60 Hz +- 2 Hz (wtf?)
T = 60;
n = length(data);
fs = length(data)/T;

% plotando o signal
t = 0:1/fs:60-1/fs;

subplot(2,1,1);
plot(t,sig1);
title("sinal 1")
xlabel("tempo (s)")
ylabel("tensão (mV)")

% na frequência
SIG1_f = fft(sig1);
SIG1 = abs(SIG1_f(1:end/2))
f = 0:fs/n:fs/2-fs/n/2
[~, maior_freq] = max(SIG1);
fn = fs/2;
freq_batimento = f(maior_freq);
% A maior freqência no sinal ocorre em 0.1 Hz. 
% O sinal fornecido possui 128 amostras, coletadas em um período de 
% 60 segundos. O que nos dá uma taxa de amostragem de ~2Hz.
% a frequência de nyquist é metade da frequência de amostragem.
% A freqência de nyquist é a maior frequência que pode ser capturada.
% No entanto, considerando que normalmente a freqência de batimento
% em um ser humano saudável é de 1Hz à 1.5 Hz, e que a frequência de
% nyquist (fn = fs/2) é de 1.0667 Hz, o pico em 0.1 Hz é provavelmente
% devido ao fenômeno de sobreposição espectral. 
% Uma estimativa para a frequência de batimento assumindo sobreposição
% calculando a distância entre a frequência de pico e a frequência de
% nyquist pode ser feita. 
distancia = fn - f(maior_freq);
freq_chute = fn + distancia
% 2.0333 Hz.


subplot(2,1,2);
plot(t, sig2);
title("sinal 2")
xlabel("tempo (s)")
ylabel("tensão (mV)")

%% 2
data = xlsread("p_9_2.xls");
t = data(:, 1);
sig = data(:,2);
fs = (length(t)-1)/t(end);
fn = fs/2;
n = length(data);
f = 0:fs/n:fs/2-fs/n/2;


plot(t, sig)
title("II")
ylabel("mV")
xlabel("tempo (s)")

SIG_ = fft(sig);
SIG = abs(SIG_(1:end/2));
[~, maior_freq] = max(SIG);
freq_batimento = f(maior_freq)*t(end)*60; % em bpm
plot(f, SIG);

% b) No sinal com FA, podemos ver que não há a presença das ondas P de
% forma regular, e também há um intervalo RR anormal. No sinal normal,
% podemos ver a presença do ciclo PQRST de forma regular.

%% 3
data = xlsread("p_9_3.xls");
t = data(:, 1);
sig1 = data(:,2);
sig2 = data(:,3);
fs = (length(t)-1)/t(end);
fn = fs/2;
n = length(data);
f = 0:fs/n:fs/2-fs/n/2;

SIG_1 = fft(sig1);
SIG1 = abs(SIG_1(1:end/2));
[~, maior_freq] = max(SIG1(2:end));
freq_batimento = f(maior_freq)*t(end)*60; % em bpm
plot(f, SIG1)

SIG_2 = fft(sig2);
SIG2 = abs(SIG_2(1:end/2));
[~, maior_freq_2] = max(SIG2(2:end));
freq_batimento_2 = f(maior_freq_2)*t(end)*60; % em bpm
plot(f, SIG2)

