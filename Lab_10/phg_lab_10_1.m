%% BIOENGENHARIA - LABORATORIO 09
%
% Aluno: Pedro Henrique Garcia Macedo - R.A.: 1829696

%% Exercício 1
clc
clear
clf

img = imread("p_15_1.jpg");
img_gray =  rgb2gray(img);
H = (1/9)*[1 1 1; 1 8 1; 1 1 1];
sharpened = imfilter(img_gray,H);

figure(1)
imshow(img)
figure(2)
imshow(sharpened)

limiar = 220;
sharpened = sharpened >= limiar;

figure(5)
imshow(limiar)



% algoritmo região crescimento
se = strel('diamond',10);
img_abertura = imopen(sharpened,se);
figure(3)
imshow(img_abertura)

% bordas = edge(img_abertura,'sobel');
% figure(4)
% imshow(bordas);
filtro = uint8(img_abertura);
img_cor_destacado = img_gray.*filtro;
figure(4)
imshow(img_cor_destacado);

% 
% title('Eliminando discos com  raio menor que 10')
% title('Filtro morfológico de abertura 100x')
% title('Filtro de abertura com detecção de bordas sobel')

