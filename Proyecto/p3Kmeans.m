% Equipo 8
% Práctica 3 Kmeans
% Parcial 2
clc
clear all
close all
warning off all

numMuestras=600;

%----Abrir Imagen----
A = imread('paisajes/IMG08.jpg');
A = imresize(A,0.5);
figure(1)
imshow(A)

BW = im2bw(A);
imshow(BW)
gcm = graycomatrix(BW);
stats = graycoprops(gcm,'all')
mean2(stats)

Alab = rgb2lab(A);
figure(2)
imshow(Alab)

[L,N] = superpixels(Alab,1000,'isInputLab',true);
BW = boundarymask(L);
figure(3)
imshow(imoverlay(A,BW,'cyan'))

pixelIdxList = label2idx(L);

[m,n] = size(L);
meanColor = zeros(m,n,3,'single');
for i = 1:N
    meanColor(pixelIdxList{i}) = mean(Alab(pixelIdxList{i}));
    meanColor(pixelIdxList{i}+m*n) = mean(Alab(pixelIdxList{i}+m*n));
    meanColor(pixelIdxList{i}+2*m*n) = mean(Alab(pixelIdxList{i}+2*m*n));
end

numColors = 5;
[Lout,cmap] = imsegkmeans(meanColor,numColors,'numAttempts',2);
cmap = lab2rgb(cmap);
figure(4)
imshow(label2rgb(Lout))
figure(5)
imshow(double(Lout),cmap)