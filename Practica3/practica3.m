%Práctica 3
%Equipo 8
clc
clear all
close all
warning off all

numDimensiones=2;
numRepresentantes=5;
numClases=3;


clases=zeros(numDimensiones,numRepresentantes,numClases);
clases(:,:,1)=[0 0 1 0 2;0 1 1 1 1]; %Clase 1
clases(:,:,2)=[5 5 4 6 6;5 6 5 5 4]; %Clase 2
clases(:,:,3)=[9 10 11 10 9;10 11 9 12 12]; %Clase 3
medias=zeros(2,numClases);
medias(:,1)=mean(clases(:,:,1),2);
medias(:,2)=mean(clases(:,:,2),2);
medias(:,3)=mean(clases(:,:,3),2);

vecDesc=[10;10];

claseMaha=clasificador_Mahalanobis(vecDesc,clases,medias,numClases,numRepresentantes);
claseDist=clasificador_Distancias(vecDesc, medias,numClases);
claseBaye=clasificador_Bayes(vecDesc,clases,numClases,medias,numRepresentantes,numDimensiones);
fprintf('El vector pertence a la clase %d. MAHA\n',claseMaha);
fprintf('El vector pertence a la clase %d. DIST\n',claseDist);
fprintf('El vector pertence a la clase %d. BAYE\n',claseBaye);
