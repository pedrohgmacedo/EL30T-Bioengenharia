%% BIOENGENHARIA - LABORATORIO 09
%
% Aluno: Pedro Henrique Garcia Macedo - R.A.: 1829696
% 
% Aluno: Paulo Henrique dos Santos - R.A.: 1828606

clc;
clear;
close all;
load('imagem.mat')

% Plotando a imagem
imagem=cdata;
imshow(imagem)
title('Imagem original')
figure

%% Segmentação

%Pré-processamento: diminuindo o tamanho da imagem
J=imresize(imagem,0.5);
imshow(J)
title('Imagem tamanho reduzido')

% inserir borda preta
%zerando a borda da imagem (6 primeiras linhas, 6 primeiras colunas, 6
%últimas linhas e 6 últimas colunas)
imagem2=J(7:end-6,7:end-6);
[l,c]=size(imagem2);
linhas=zeros(6,c);
colunas=zeros(l,6);
aux=zeros(6,6);
imagem_bordas=[ aux linhas aux
    colunas imagem2 colunas
    aux linhas aux];

figure;
imshow(imagem_bordas)
title('Imagem com borda')

% Limiarização: separar objeto e fundo
% objetivo: manter todos pixels acima do limiar.
logico=imagem_bordas>=76;
inteiro=uint8(logico);
imshow(logico)
title('Imagem limiarizada 76')

I=imagem_bordas.*inteiro;
figure
imshow(I)
title('Imagem sem fundo')

%% Realce de nódulos

% Filtragem passa alta -> tecidos mais claros estão em alta frequência
f=[-0.65 -0.4 3 -1] ;
sharpened = imfilter(I,f) ;
figure
imshow(sharpened) ;
title('Imagem sem fundo após filtragem passa-alta')

% realce de contraste
contraste=histeq(sharpened);
figure
imshow(contraste)
title('Aumento de contraste')

% Filtragem passa alta
f = [-0.65 -0.4 3 -1] ;
sharpened2 = imfilter(contraste, f) ;
figure
imshow(sharpened2) ;
title('Imagem com aumento de contraste filtrada')

%% Detecção de agrupamentos

% Nova segmentação via limiarização global
logico2=sharpened2>=215;
inteiro2=uint8(logico2);
I=sharpened2.*inteiro2;
figure
imshow(I)
title('Imagem limiarizada 215')

figure
imshow(logico2)
title('Imagem limiarizada binária')

% Remoção de falsos positivos filtro com filtro morfológico de abertura
BW2 = bwmorph(I,'open',100);
figure
imshow(BW2)
title('Filtro morfológico de abertura 100x')

% n sei o que é uma operação morfológica, achado do paulão
se = strel('disk',10);
afterOpening = imopen(BW2,se);
figure
imshow(afterOpening);
title('Eliminando discos com  raio menor que 10')

bordas = edge(afterOpening,'sobel');
figure
imshow(bordas)
title('Filtro de abertura com detecção de bordas sobel')

% transformando em RGB a imagem com a borda do tumor
aux=bordas;
[l,c]=size(bordas);
rgbImage=cat(3,bordas,aux,zeros(l,c));
figure
imshow(rgbImage)
title('Imagem RGB depois do filtro sobel para detecção de bordas')

%transformando imagem original em 3 dimensões
J_rgb=cat(3,J,J,J);

%Adicionando a imagem com a borda do tumor à imagem original de tamanho
%reduzido
I=J_rgb;
[x,y,z]=size(J_rgb);
for i=1:1:x
    for j=1:1:y
        for k=1:1:z
            if rgbImage(i,j,k)~=0
                I(i,j,k)=rgbImage(i,j,k);
            end
        end
    end
end
imshow(I)
title('Imagem final indicando o tumor')