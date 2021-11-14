%% BIOENGENHARIA - LABORATORIO 06
% Aluno: Pedro Henrique Garcia Macedo
% R.A.: 1829696


%% Ex 1.
load 'ECG01_5min@240Hz.dat'
y = ECG01_5min_240Hz;
fs = 240;
T_final = 5*60;
t = 0:1/fs:T_final-1/fs;
fs2 = 1000;
t_ = 0:1/fs2:T_final-1/fs2;
y_ = spline(t, y, t_);

inic = 3*60*fs+1;
fim = (3*60+10)*fs+1;
inic2 = 3*60*fs2+1;
fim2 = (3*60+10)*fs2+1;

plot( t(inic:fim), y(inic:fim), 'b*', t_(inic2:fim2), y_(inic2:fim2), 'go') 

%% Ex 2.
plot(t_(inic2:fim2), y_(inic2:fim2))
y_diff = diff(y_);
[~, locs] = findpeaks(y_diff, 'MinPeakheight', 0.4);
n_janelas = sum(locs > 0);
y_janelado = [];
for i=2:n_janelas-1
    before = 0.2*fs2;
    after = 0.4*fs2;
    y_aux = y_(locs(i)-before:locs(i)+after);
    y_janelado = [y_janelado y_aux'];
end
y_media = zeros(size(y_janelado(:,1)));
for i=1:length(y_janelado(1,:))
    y_media= y_media+y_janelado(:,i);
end
y_media = y_media/n_janelas;
plot(y_media, 'b')
hold on;
plot(y_janelado(:,1), 'r')
legend('PQRST promediado', 'PQRST ruidoso')
hold off;

%% Ex 3.
n = length(locs);
rr = [];
for i=1:n-1
    rr(i) = (t_(locs(i+1)) -t_(locs(i)))*1e3;
end
plot(rr)
ylabel('intervalo rr (ms)')
xlabel('amostra n do intervalo')

%% Ex 4.
b = ones(5,1)/5;
y_ma = fftfilt(b, y_);

tempo = ["0-5 min" "0-1 min" "1-2 min" "2-3 min" "3-4 min" "4-5 min"];

y_mean = mean(y_);
y_mean_ma = mean(y_ma);
y_std = std(y_);
y_std_ma = std(y_ma);
y_var = var(y_);
y_var_ma = var(y_ma);
y_rms = rms(y_);
y_rms_ma = rms(y_ma);

for i=0:4
    y_aux = y_(i*60*fs+1:(i+1)*60*fs);
    y_aux_ma = y_(i*60*fs+1:(i+1)*60*fs);

    y_mean(i+2) = mean(y_aux);
    y_mean_ma(i+2) = mean(y_aux_ma);
    
    y_std(i+2) = std(y_aux);
    y_std_ma(i+2) = std(y_aux_ma);
    
    y_var(i+2) = var(y_aux);
    y_var_ma(i+2) = var(y_aux_ma);    
    
    y_rms(i+2) = rms(y_aux);
    y_rms_ma(i+2) = rms(y_aux_ma);
end

%% Ex 5.
ind_selec = abs(rr-mean(rr)) < 2*std(rr);
abscissa = 1:length(rr);
plot(abscissa(ind_selec), rr(ind_selec), 'b-')
hold on;
plot(abscissa(~ind_selec), rr(~ind_selec), 'rx')
hold off;
legend('selecionados','rejeitados')


