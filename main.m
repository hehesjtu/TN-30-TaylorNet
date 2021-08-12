%% This is the sourse code of the Project: TaylorNet
% The first author is : He Jiang
% This code is for single image detail enhancement
clc;clear all;warning off;close all;
img = imread('comic.png');
[m,n,d] =size(img);
m = floor(m/4)*4; n = floor(n/4)*4;
tau = 3;
LayerNumber = 30;
img = double(img(1:m,1:n,:));
Taylorlayer = zeros(m,n,d,LayerNumber);
Weights = zeros(m,n,d,LayerNumber);
ResFeature = 0;
Taylorlayer(:,:,:,1) = double(get_layer(img));
Weights(:,:,:,1) = tau;
tic
for k = 2:LayerNumber
    Taylorlayer(:,:,:,k) = get_layer(Taylorlayer(:,:,:,k-1));
end
for k =2:LayerNumber
    Weights(:,:,:,k) = get_weight(Taylorlayer(:,:,:,k),k);
    clear Taylorlayer(:,:,:,k);
end
for k =1:LayerNumber
    ResFeature = ResFeature + Taylorlayer(:,:,:,k).*Weights(:,:,:,k);
end
img_enhance = img + tau*ResFeature;
img_enhance = uint8(img_enhance);
disp("running time is:");
toc
imwrite(img_enhance,'comic_enhance.png');
figure;
imshow([img,img_enhance]);


