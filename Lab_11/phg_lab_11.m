%% BIOENGENHARIA - LABORATORIO 11
%
% Aluno: Pedro Henrique Garcia Macedo - R.A.: 1829696

%% Exercício 1
image = imread("p_16_5.jpg");
image = rgb2gray(image);

imtool(image)

% unidade é px
largura_parede = 27.62;
diametro_vaso = 102.22;
diametro_cateter = 41.97;
larg_relativa = largura_parede/diametro_vaso;

% a unidade é mm/px
razao_diametral = 5/diametro_cateter;
% unidade mm
largura_parede_mm = razao_diametral*largura_parede;

%% Exercício 2
img = imread("p_16_6.jpg");
figure(1)
imshow(img)
img = rgb2gray(img);
img = double(img);
img = img./max(img);
img = histeq(img);
figure(2)
imshow(img);
X = 345; Y = 286;
J = regiongrowing(img, X, Y, 0.26);
figure(3)
imshow(img+J)
disp('done')

%% Exercício 3
clear
clc
img = imread("p_16_7.jpg");
[r,g,b] = imsplit(img);

% retiramos todos os valores de pixel com intensidade menor que 
threshold = 60;
r = (r>threshold).*r;
g = (g>threshold).*g;
b = (b>threshold).*b;
% retorna ao rgb
img = cat(3, r, g, b);

% essas 3 linhas demoraram 40 minutos
img = double(img);
img = img./max(max(img));
img = uint8(img*255);

gray = rgb2gray(img);
% thresholding em imagens grayscale
% setando pixels com alta intensidade de brilho pra zero
pixels_brilhantes = gray > 250;
gray(pixels_brilhantes) = 0;

% 2 regioes
gray = double(gray);
X = 370; Y = 155;
J1 = regiongrowing(gray, X, Y, 0.26);
X = 406; Y = 361;
J2 = regiongrowing(gray, X, Y, 0.26)
J = J1 + J2;
imshow(img+J)


figure(1)
img = rgb2gray(img);
imshow(img+pixels_brilhantes)
figure(2)
imshow(gray)
