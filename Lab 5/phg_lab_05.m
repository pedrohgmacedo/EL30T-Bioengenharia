%% BIOENGENHARIA - LABORATORIO 05
% Aluno: Pedro Henrique Garcia Macedo
% R.A.: 1829696

%%
function phg_lab_05()

    function c = limiar_soft(c,zeta)
        n = max(max(c));
        c = c/n;
        c(abs(c) < zeta) = 0;
        c = c - (c > zeta)*zeta;
        c = c + (c < -zeta)*zeta;
        c = c*n;
    end

    function c = limiar_hard(c, zeta)
        c(abs(c) < zeta) = 0;
    end

%% Ex. 1.
close all; clear; clc;
f = load('p_5_1.mat');
x = f.fluoroscopy;
x = x/max(max(x));
figure(1);
imshow(x);
title("Imagem Original");

% Limiar Hard
% Aplicando limiar zeta = 0.01;

[cA,cH,cV,cD] = dwt2(x,"db2");
zeta = 0.01;
cA = limiar_hard(cA, zeta);
cH = limiar_hard(cH, zeta);
cV = limiar_hard(cV, zeta);
cD = limiar_hard(cD, zeta);

X = idwt2(cA,cH,cV,cD,"db2");
X = X/max(max(X));
figure;
imshow(X);
title("Limiar hard zeta = 0.01");

% Aplicando limiar zeta = 0.05;
[cA,cH,cV,cD] = dwt2(x,"db2");
zeta = 0.05;
cA = limiar_hard(cA, zeta);
cH = limiar_hard(cH, zeta);
cV = limiar_hard(cV, zeta);
cD = limiar_hard(cD, zeta);

X = idwt2(cA,cH,cV,cD,"db2");
X = X/max(max(X));
figure;
imshow(X);
title("Limiar hard zeta = 0.05");

% Aplicando limiar zeta = 0.1;
[cA,cH,cV,cD] = dwt2(x,"db2");
zeta = 0.1;
cA = limiar_hard(cA, zeta);
cH = limiar_hard(cH, zeta);
cV = limiar_hard(cV, zeta);
cD = limiar_hard(cD, zeta);

X = idwt2(cA,cH,cV,cD,"db2");
X = X/max(max(X));
figure;
imshow(X);
title("Limiar hard zeta = 0.1");

% Limiar soft

% zeta = 0.01
[cA,cH,cV,cD] = dwt2(x,"db2");
zeta = 0.01;
cA = limiar_soft(cA,zeta);
cH = limiar_soft(cH,zeta);
cV = limiar_soft(cV,zeta);
cD = limiar_soft(cD,zeta);

X = idwt2(cA,cH,cV,cD,"db2");
X = X/max(max(X));
figure;
imshow(X);
title("Limiar soft zeta = 0.01")

% zeta = 0.05
[cA,cH,cV,cD] = dwt2(x,"db2");

zeta = 0.05;
cA = limiar_soft(cA,zeta);
cH = limiar_soft(cH,zeta);
cV = limiar_soft(cV,zeta);
cD = limiar_soft(cD,zeta);

X = idwt2(cA,cH,cV,cD,"db2");
X = X/max(max(X));
figure;
imshow(X);
title("Limiar soft zeta = 0.05");

% zeta = 0.1
[cA,cH,cV,cD] = dwt2(x,"db2");

zeta = 0.1;
cA = limiar_soft(cA,zeta);
cH = limiar_soft(cH,zeta);
cV = limiar_soft(cV,zeta);
cD = limiar_soft(cD,zeta);

X = idwt2(cA,cH,cV,cD,"db2");
X = X/max(max(X));
figure;
imshow(X);
title("Limiar soft zeta = 0.1");

% Podemos ver que o limiar soft apresenta melhores resultados pois
% não descarta coeficientes que são negativos.

%% Ex. 2
clear; clc;
f = load("p_5_2.mat");
eeg_signal = f.eeg_signal;
[cA,cD] = dwt(eeg_signal,"db1");

% caso zeta = 0.01
zeta = 0.01;
cA = limiar_soft(cA, zeta);
cD = limiar_soft(cD, zeta);

figure
subplot(2,1,1)
plot(cA)
title("zeta = 0.01, Aproximação")
subplot(2,1,2)
plot(cD)
title("zeta = 0.01, Detalhe")

X_001 = idwt(cA, cD, "db1");


% caso zeta = 0.05
zeta = 0.05;
cA = limiar_soft(cA, zeta);
cD = limiar_soft(cD, zeta);

figure
subplot(2,1,1)
plot(cA)
title("zeta = 0.01, Aproximação")
subplot(2,1,2)
plot(cD)
title("zeta = 0.01, Detalhe")

X_005 = idwt(cA, cD, "db1");

% caso zeta = 0.1
zeta = 0.1;
cA = limiar_soft(cA, zeta);
cD = limiar_soft(cD, zeta);

figure
subplot(2,1,1)
plot(cA)
title("zeta = 0.01, Aproximação")
subplot(2,1,2)
plot(cD)
title("zeta = 0.01, Detalhe")

X_010 = idwt(cA, cD, "db1");

% plotando os resultados
figure
subplot(4,1,1)
plot(eeg_signal/max(eeg_signal));
title("sinal original")
subplot(4,1,2)
plot(X_001)
title("sinal reconstruido com zeta = 0.01")
subplot(4,1,3)
plot(X_005)
title("sinal reconstruido com zeta = 0.05")
subplot(4,1,4)
plot(X_010)
title("sinal reconstruido com zeta = 0.1")


% plotando a diferença entre os resultados
% amplitude media dos sinais de erro
x = eeg_signal;
mean(abs(x-X_001))
mean(abs(x-X_005))
mean(abs(x-X_010))

figure
subplot(3,1,1)
plot(x-X_001)
ylim([-10 10])
title("dif do sinal reconstruido com zeta = 0.01")
subplot(3,1,2)
plot(x-X_005)
ylim([-10 10])
title("dif do sinal reconstruido com zeta = 0.05")
subplot(3,1,3)
plot(x-X_010)
ylim([-10 10])
title("dif do sinal reconstruido com zeta = 0.1")

%% Ex 3.
f = load("p_5_3.mat");
x = f.vein;

% pra não ficar repetindo muito, utilizamos funções de ajuda
% mas essa funcão provavelmente deveria ser feita usando recursão.
    function [cH1, cV1, cD1, cA2, cH2, cV2, cD2] = wavelet2niveis(x, tipo, zeta)
        [cA1, cH1, cV1, cD1] = dwt2(x,tipo);
        [cA2, cH2, cV2, cD2] = dwt2(cA1,tipo);
        cH1 = limiar_hard(cH1, zeta);
        cV1 = limiar_hard(cV1, zeta);
        cD1 = limiar_hard(cD1, zeta);
        cA2 = limiar_hard(cA2, zeta);
        cH2 = limiar_hard(cH2, zeta);
        cV2 = limiar_hard(cV2, zeta);
        cD2 = limiar_hard(cD2, zeta);
    end

    function x = wavelet2niveis_inversa(cH1, cV1, cD1, cA2, cH2, cV2, cD2, tipo)
        cA1 = idwt2(cA2, cH2, cV2, cD2, tipo);
        [l1, c1] = size(cA1);
        [l2, c2] = size(cH1);
        if c1 > c2 
            cA1 = cA1(:, 1:end-1);
        end
        if l1 > l2
            cA1 = cA1(1:end-1, :);
        end
        x = idwt2(cA1, cH1, cV1, cD1, tipo);
        x = x/max(max(x));
    end


% limiar hard, 2 níveis, daubechies 2, zeta = 0.01
zeta = 0.01;
tipo = "db2";
[cH1, cV1, cD1, cA2, cH2, cV2, cD2] = wavelet2niveis(x, tipo, zeta);
x1 = wavelet2niveis_inversa(cH1, cV1, cD1, cA2, cH2, cV2, cD2, tipo);
% limiar hard, 2 níveis, daubechies 2, zeta = 0.05
zeta = 0.05;
[cH1, cV1, cD1, cA2, cH2, cV2, cD2] = wavelet2niveis(x, tipo, zeta);
x2 = wavelet2niveis_inversa(cH1, cV1, cD1, cA2, cH2, cV2, cD2, tipo);
% limiar hard, 2 níveis, daubechies 2, zeta = 0.1
zeta = 0.1;
[cH1, cV1, cD1, cA2, cH2, cV2, cD2] = wavelet2niveis(x, tipo, zeta);
x3 = wavelet2niveis_inversa(cH1, cV1, cD1, cA2, cH2, cV2, cD2, tipo);

figure
imshow(x1)
title("zeta = 0.01, db2")
figure
imshow(x2)
title("zeta = 0.05, db2")
figure
imshow(x3)
title("zeta = 0.1, db2")


% limiar hard, 2 níveis, harr, zeta = 0.01
zeta = 0.01;
tipo = "db1";
[cH1, cV1, cD1, cA2, cH2, cV2, cD2] = wavelet2niveis(x, tipo, zeta);
x1 = wavelet2niveis_inversa(cH1, cV1, cD1, cA2, cH2, cV2, cD2, tipo);
% limiar hard, 2 níveis, harr, zeta = 0.05
zeta = 0.05;
[cH1, cV1, cD1, cA2, cH2, cV2, cD2] = wavelet2niveis(x, tipo, zeta);
x2 = wavelet2niveis_inversa(cH1, cV1, cD1, cA2, cH2, cV2, cD2, tipo);
% limiar hard, 2 níveis, harr, zeta = 0.1
zeta = 0.1;
[cH1, cV1, cD1, cA2, cH2, cV2, cD2] = wavelet2niveis(x, tipo, zeta);
x3 = wavelet2niveis_inversa(cH1, cV1, cD1, cA2, cH2, cV2, cD2, tipo);

%visualizar
figure
imshow(x1)
title("zeta = 0.01, db1")
figure
imshow(x2)
title("zeta = 0.05, db1")
figure
imshow(x3)
title("zeta = 0.1, db1")

% limiar hard, 2 níveis, coiflets 1, zeta = 0.01
zeta = 0.01;
tipo = "coif1";
[cH1, cV1, cD1, cA2, cH2, cV2, cD2] = wavelet2niveis(x, tipo, zeta);
x1 = wavelet2niveis_inversa(cH1, cV1, cD1, cA2, cH2, cV2, cD2, tipo);
% limiar hard, 2 níveis, coiflets 1, zeta = 0.05
zeta = 0.05;
[cH1, cV1, cD1, cA2, cH2, cV2, cD2] = wavelet2niveis(x, tipo, zeta);
x2 = wavelet2niveis_inversa(cH1, cV1, cD1, cA2, cH2, cV2, cD2, tipo);
% limiar hard, 2 níveis, coiflets 1, zeta = 0.1
zeta = 0.1;
[cH1, cV1, cD1, cA2, cH2, cV2, cD2] = wavelet2niveis(x, tipo, zeta);
x3 = wavelet2niveis_inversa(cH1, cV1, cD1, cA2, cH2, cV2, cD2, tipo);

%visualizar
figure
imshow(x1)
title("zeta = 0.01, coif1")
figure
imshow(x2)
title("zeta = 0.05, coif1")
figure
imshow(x3)
title("zeta = 0.1, coif1")

% Não consegui identificar a compressão, parece que as imagem foram
% todas adequadamente reconstruídas.

end


