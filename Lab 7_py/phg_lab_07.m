%% BIOENGENHARIA - LABORATORIO 06
% Aluno: Pedro Henrique Garcia Macedo
% R.A.: 1829696

%% Ex 1.
all_sig = xlsread("p_10_1.xls");

fs = 256;
T = 1/fs;
n = length(all_sig(:,1));
 
sig1 = all_sig(:,1);
SIG1 = fft(sig1);
SIG1 = abs(SIG1(1:end/2));
f = 0:fs/n:fs/2-fs/n/2;


sig2 = all_sig(:,9);
SIG2 = fft(sig2);
SIG2 = abs(SIG2(1:end/2));

%filtro passa alta
SIG1(1:2) = 0; SIG2(1:2) = 0;

% encontrando a frequência dominante
[~, ind_maior1] = max(SIG1);
freq_dom1 = f(ind_maior1);

[~, ind_maior2] = max(SIG2);
freq_dom2 = f(ind_maior2);

figure(1)
hold on
plot(f, SIG1, 'b')
plot(freq_dom1, SIG1(ind_maior1), 'r*')
legend('sinal 1', 'frequência dominante')
datatip(freq_dom1, SIG1(ind_maior1))
ylim([-100 1400])
xlim([-10 f(end)+10])
grid on
hold off

figure(2)
hold on
plot(f, SIG2, 'b')
plot(freq_dom2, SIG2(ind_maior2), 'r*')
legend('sinal 2', 'frequência dominante')
ylim([-100 1400])
xlim([-10 f(end)+10])
grid on
hold off