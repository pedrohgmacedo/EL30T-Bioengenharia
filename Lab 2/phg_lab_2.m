%% BIOENGENHARIA - LABORATORIO 02
% Aluno: Pedro Henrique Garcia Macedo
% R.A.: 1829696

%% Ex 1.
clear; clc

% a)
% Essa s� consegui resolver na cagada kkkk.
% Quando r=0, s=0 ->  0 = a + b
% portanto a = -b

% Quando r = 0.85, s = 0.5 -> f(c) = 0.5;
% Divindo f(r=0.85)/f(r=1) obtemos, e isolando f(c) = 0
valor_inicial = 10;
[c, f] = fsolve(@(c) (2*exp(0.85*c)-exp(c)-1), valor_inicial)
% Obtemos o valor de 4.5510 para c;
% Quando r = 1, s = 1 -> isolamos b;
b = 1/(exp(c)-1);
a = -b;

% Obtendo os coeficientes, verificamos que a transforma��o d� exatamente
% os par�metros de projeto
s = @(r) (a + b.*exp(c.*r));
s(0)
s(1)
s(0.85)

% b)
A = imread("p_3_1", "jpg");
% imread() retorna uint8 (num. inteiro sem sinal)
% � necess�rio converter para double() para poder fazer a divis�o
A = double(A);
A_n = A./max(max(A));
A_s = s(A_n);
imshow(A_s)

%% Ex 2.
clc; clear;
A = imread("p_3_2", "jpg");
A = rgb2gray(A);
class(A)

%% 2. a)
% O matlab n�o suporta inteiros com menos de 8 bits (ver doc Integers).
% N�o podemos, portanto, economizar mem�ria utilizando inteiros menores
% com menos que 8 bits.
% No entanto, podemos aplicar uma m�scara de bits para zerar os MSB ou LSB.
lsb3 = 248;
A_c = bitand(A, lsb3);

figure(1)
subplot(2,1,1)
imshow(A, [0 255]);

subplot(2,1,2)
imshow(A_c, [0 255]);
% Inspecionando, a diferen�a entre as imagens � pouco significativa.

%% 2. b)

lsb4 = 240;
A_c = bitand(A, lsb4);

figure(2)
subplot(2,1,1)
imshow(A, [0 255]);

subplot(2,1,2)
imshow(A_c, [0 255]);

% Inspecionando, a diferen�a entre as imagens � perceptivel,
% mas pouco significativa.

%% 2. c)

lsb5 = 224;
A_c = bitand(A, lsb5);

figure(3)
subplot(2,1,1)
imshow(A, [0 255]);

subplot(2,1,2)
imshow(A_c, [0 255]);
% Com menos que 3 bits MSB restantes, a percepc�o � muito degradada.

% Olha que legal, d� pra inverter as cores usando A_c = bitxor(A, 255);

%% 3.
clc; clear;
I = imread("p_3_3", "jpg");
J = histeq(I);
figure(1)
imshow(I)
figure(2)
imshow(J)
figure(3)
imhist(I,255)
figure(4)
imhist(J, 255)

% Verificamos que caracter�sticas da imagem est�o mais distintas
% mas h� um n�vel percept�vel de ru�do tamb�m.

%% 4. a)
clear
load("p_3_4.mat")
I = noisy_MRI_image;
H = (1/9)*[1 1 1; 1 1 1; 1 1 1];
smooth_image = imfilter(I, H);


figure(1)
imshow(I)
figure(2)
imshow(smooth_image)

% 4. b) verificamos que a imagem filtrada � mais 'lisa'

% 4. c)
H = (1/16)*[1 2 1; 2 4 2; 2 2 2];
smoother_image = imfilter(I, H);
figure(3)
imshow(smoother_image)

% 4. d)
J = imnoise(I, 'salt & pepper', .2);
k = medfilt2(J);
imshow(J);
figure(4)
imshow(k)

% vemos que o ru�do � reduzido sem degradar as bordas.

%% 5.)
clear
load("p_3_5.mat")
I = vertebra;
% A = 1
A = 1;
H = (1/9)*[ 1 1 1; 1 -8 1; 1 1 1];
K = [0 0 0; 0 1 0; 0 0 0];
HB = ((A-1).*K) +H;
sharpened = imfilter(I, HB);
imshow(I);
figure(1)
imshow(sharpened)

% A = 1.05
A = 1.05;
H = (1/9)*[ 1 1 1; 1 -8 1; 1 1 1];
K = [0 0 0; 0 1 0; 0 0 0];
HB = ((A-1).*K) +H;
sharpened = imfilter(I, HB);
imshow(I);
figure(2)
imshow(sharpened)

% A = 1.15
A = 1.15;
H = (1/9)*[ 1 1 1; 1 -8 1; 1 1 1];
K = [0 0 0; 0 1 0; 0 0 0];
HB = ((A-1).*K) +H;
sharpened = imfilter(I, HB);
imshow(I);
figure(3)
imshow(sharpened)

% A = 1.2
A = 1.2;
H = (1/9)*[ 1 1 1; 1 -8 1; 1 1 1];
K = [0 0 0; 0 1 0; 0 0 0];
HB = ((A-1).*K) +H;
sharpened = imfilter(I, HB);
imshow(I);
figure(4)
imshow(sharpened)

% 5. b)
% O melhor desempenho foi com o filtro com A = 1.15;

% 5. c)
% Detec��o de borda utilizando Sobel
figure
imshow(I);
J = edge(I, 'sobel');
figure(5)
imshow(J)

% 5. d)
% Pode somar a imagem resultado do filtro com a imagem inicial