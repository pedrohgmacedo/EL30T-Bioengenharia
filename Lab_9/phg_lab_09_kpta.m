%% pre processamento
cancer = imread("mal5.gif");
% [l, c] = size(cancer);
% lado = zeros(l, 6);
% topo = zeros(6, c);
% rst = zeros(6,6);
% cancer = [ rst topo rst
%            lado cancer lado
%            rst topo rst];
cancer = cancer(7:end-6, 7:end-6);
image(cancer);
%% segmentação
%limiarizar
cancer_limiarizado = cancer;
cancer_limiarizado(cancer >= 76) = 1;
cancer_limiarizado(cancer < 76) = 0;
image(cancer_limiarizado)

% filtro morfológico de abertura para remoção de fundo
cancer_com_filtro_morfologico = bwmorph(cancer_limiarizado, 'open', 26);

cancer_sem_fundo = cancer.*uint8(cancer_com_filtro_morfologico);

imshow(cancer_sem_fundo)

%% Realce de nódulos
% filtro passa alta pra detectar e realçar os nódulos
h = [-0.65 -0.4 3 -1];
cancer_nodulos_enfatizados = imfilter(cancer_sem_fundo, h);

% aumento seletivo de contraste a.k.a. funcão histeq
cancer_contraste = histeq(cancer_nodulos_enfatizados);

figure(1)
imshow(cancer_sem_fundo)
figure(2)
imshow(cancer_nodulos_enfatizados)
figure(3)
imshow(cancer_contraste)