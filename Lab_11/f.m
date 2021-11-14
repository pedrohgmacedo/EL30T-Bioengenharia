clear
clc
I = imread("p_16_7.jpg");
[r,g,b] = imsplit(I);

% fazer thresholding para pizels maior que 80
threshold = 80;
r(r<threshold) = 0;
g(g<threshold) = 0;
b(b<threshold) = 0;

% crescer a região em vermelho
x = 431; y = 334;
x1 = 363;
x2 = 626;
y1 = 163;
y2 = 430;
r = double(r);

J_red=limited_regiongrowing(r,x,y,x1,x2,y1,y2,0.2)

imshow(J_red)


