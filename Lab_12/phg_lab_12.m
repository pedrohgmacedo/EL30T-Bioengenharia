%% BIOENGENHARIA - LABORATORIO 12
%
% Aluno: Pedro Henrique Garcia Macedo - R.A.: 1829696


%% Ex 1. a

% para a imagem 1,1
jpg_image = imread("p_17_1.jpg");
ui8_gray_img = rgb2gray(jpg_image);
d_img = double(ui8_gray_img);
nd_img = d_img/max(max(d_img));
nd_x = 123; nd_y = 90;
% wtf no region growing estao trocadas as coords
log_grown_img_11 = regiongrowing(nd_img, nd_y, nd_x, 0.05);
imshow(log_grown_img_11+nd_img);

% para a imagem 2,1
jpg_image = imread("p_17_1.jpg");
ui8_gray_img = rgb2gray(jpg_image);
d_img = double(ui8_gray_img);
nd_img = d_img/max(max(d_img));
nd_x = 91; nd_y = 453;
log_grown_img_21 = regiongrowing(nd_img, nd_y, nd_x, 0.05);
imshow(log_grown_img_21+nd_img);


% plots com ambas selecionadas
figure(1)
log_grown_img_all = log_grown_img_21 + log_grown_img_11;
% como nd_img está normalizada, essa soma está apenas aumentando a
% intensidade do nd_img, que já está normalizado
imshow(log_grown_img_all+nd_img)
title('plot com ambas selecionadas')


% bordas para a 1,1
% utiliza 2 thresholds
ui8_part_gray_img = ui8_gray_img;
ui8_part_gray_img(343:end, :) = 0;

thr = 95;
thr2 = 110;
ui8_thr_part_gray_img = ui8_part_gray_img;
ui8_thr_part_gray_img(ui8_thr_part_gray_img < thr) = 0;
ui8_thr_part_gray_img(ui8_thr_part_gray_img > thr2) = 0;
ui8_thr_part_gray_img2 = ui8_thr_part_gray_img;
log_gauss_img = edge(ui8_thr_part_gray_img2, 'log');


% bordas para a 2,1

% threshold com partição
% acima de x = 54 tudo deve ser preto pra img 2,1
ui8_part_gray_img = ui8_gray_img;
ui8_part_gray_img(1:342, :) = 0;

thr = 150;
ui8_thr_part_gray_img = ui8_part_gray_img;
ui8_thr_part_gray_img(ui8_thr_part_gray_img < 240) = 0;
imshow(ui8_thr_part_gray_img)

%
log_gauss_img = edge(ui8_thr_part_gray_img, 'log');

figure(1)
imshow(log_gauss_img);
title('bordas do tumor gaussiana')
figure(2)
imshow(ui8_thr_part_gray_img)
title('imagem só com thr+part')
figure(3)
imshow(log_gauss_img+nd_img);
title('imagem tumor circulado')

%% Ex 2. a
imshowpair(fixed, moving,'Scaling','joint')
[optimizer, metric] = imregconfig('multimodal')
optimizer.InitialRadius = 0.009;
optimizer.Epsilon = 1.5e-4;
optimizer.GrowthFactor = 1.01;
optimizer.MaximumIterations = 300;





