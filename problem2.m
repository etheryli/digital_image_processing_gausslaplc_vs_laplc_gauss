clear all;
close all;
clc;

% read in original
image = imread('lena_gray.bmp');

% introduce poisson noise
noise = imnoise(image,'poisson');
%figure, imshow(noise);

% write noise file
imwrite(noise, 'lena_gray_noise.tif');

% filters:
% same window size 3x3 for both
% sigma of 4
h1 = fspecial('gaussian', 3, 4.0);
% alpha of 0.2
h2 = fspecial('laplacian'); 

% Applying Gaussian then Laplacian
gauss = imfilter(noise, h1, 'replicate');
gauss_laplc_mask = imfilter(gauss, h2, 'replicate');

gauss_lalpc = gauss - gauss_laplc_mask;

imwrite(gauss_lalpc, 'lena_gray_gauss_laplc.tif');

% Applying Laplacian then Gaussian
laplc_mask = imfilter(noise, h2, 'replicate');
laplc = image - laplc_mask;

laplc_gauss = imfilter(laplc, h1, 'replicate');

imwrite(laplc_gauss, 'lena_gray_laplc_gauss.tif');

%figure, imshow(gauss_lalpc);
%figure, imshow(laplc);