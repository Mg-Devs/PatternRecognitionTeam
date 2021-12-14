% Equipo 8
% Práctica 3 Kmeans
% Parcial 2
clc
clear all
close all
warning off all

numMuestras=600;

offset=[1 1; 3 3; 5 5; -5 -5];

%----Abrir Imagen----
A = imread('paisajes/IMG08.jpg');
A = imresize(A,0.5);
figure(1)
imshow(A)

BW = im2bw(A);
imshow(BW)
gcm = graycomatrix(BW,'Offset',offset);
stats = graycoprops(gcm,'all')

A2 = imread('paisajes/IMG35.jpg');
A2 = imresize(A2,0.5);
figure(1)
imshow(A2)

BW2 = im2bw(A2);
imshow(BW2)
gcm2 = graycomatrix(BW2,'Offset',offset);
stats2 = graycoprops(gcm2,'all')
mean(stats2.Contrast)

A3 = imread('paisajes/IMG65.jpg');
A3 = imresize(A3,0.5);
figure(1)
imshow(A3)

BW3 = im2bw(A3);
imshow(BW3)
gcm3 = graycomatrix(BW3,'Offset',offset);
stats3 = graycoprops(gcm3,'all')
mean(stats3.Contrast)

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