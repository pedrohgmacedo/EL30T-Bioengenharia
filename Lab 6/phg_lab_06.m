%% BIOENGENHARIA - LABORATORIO 06
% Aluno: Pedro Henrique Garcia Macedo
% R.A.: 1829696

%% 1
data = xlsread("p_9_1.xls");
sig1 = data(:,1);
sig2 = data(:,2);
% o sinal foi coletado durante 1 min => 60 segundos
% isso d� 128 amostras por 60 segundos -> 128/60 Hz +- 2 Hz (wtf?)
T = 60;
n = length(data);
fs = length(data)/T;

% plotando o signal
t = 0:1/fs:60-1/fs;

subplot(2,1,1);
plot(t,sig1);
title("sinal 1")
xlabel("tempo (s)")
ylabel("tens�o (mV)")

% na frequ�ncia
SIG1_f = fft(sig1);
SIG1 = abs(SIG1_f(1:end/2))
f = 0:fs/n:fs/2-fs/n/2
[~, maior_freq] = max(SIG1);
fn = fs/2;
freq_batimento = f(maior_freq);
% A maior freq�ncia no sinal ocorre em 0.1 Hz. 
% O sinal fornecido possui 128 amostras, coletadas em um per�odo de 
% 60 segundos. O que nos d� uma taxa de amostragem de ~2Hz.
% a frequ�ncia de nyquist � metade da frequ�ncia de amostragem.
% A freq�ncia de nyquist � a maior frequ�ncia que pode ser capturada.
% No entanto, considerando que normalmente a freq�ncia de batimento
% em um ser humano saud�vel � de 1Hz � 1.5 Hz, e que a frequ�ncia de
% nyquist (fn = fs/2) � de 1.0667 Hz, o pico em 0.1 Hz � provavelmente
% devido ao fen�meno de sobreposi��o espectral. 
% Uma estimativa para a frequ�ncia de batimento assumindo sobreposi��o
% calculando a dist�ncia entre a frequ�ncia de pico e a frequ�ncia de
% nyquist pode ser feita. 
distancia = fn - f(maior_freq);
freq_chute = fn + distancia
% 2.0333 Hz.


subplot(2,1,2);
plot(t, sig2);
title("sinal 2")
xlabel("tempo (s)")
ylabel("tens�o (mV)")

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

% b) No sinal com FA, podemos ver que n�o h� a presen�a das ondas P de
% forma regular, e tamb�m h� um intervalo RR anormal. No sinal normal,
% podemos ver a presen�a do ciclo PQRST de forma regular.

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

