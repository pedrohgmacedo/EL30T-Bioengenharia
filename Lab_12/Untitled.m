% this reads the image pair
Fixed = imread('p_17_2_a.jpg');
Moving = imread('p_17_2_b.jpg');
Moving = rgb2gray(Moving);

% this view the 2 images
imshow(Moving);
imshow(Fixed);

% shows the image side by side 
% this visualizer functions, such as 'falsecolor', 
% and alpha blended images
imshowpair(Fixed, Moving, 'falsecolor');
%% Image registration

% inensity-based algorithms require grayscale
Moving = imread('p_17_2_a.jpg');
Fixed = imread('p_17_2_b.jpg');
Moving = rgb2gray(Moving);
Fixed = rgb2gray(Fixed);

% configures the imregconfig toolbox
[optimizer, metric] = imregconfig('Multimodal');

% default registration
% what happens? -> the moving image is transformed to be like
% the fixed picture.
registered = imregister(Moving, Fixed,... 
                        'similarity', optimizer, metric);
figure;
imshowpair(registered, Fixed);
figure;
imshowpair(Moving, Fixed, 'montage')
