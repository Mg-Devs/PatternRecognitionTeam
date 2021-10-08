%Equipo 8
%Parcial 2
%Práctica 1  
clc
clear all
close all
warning off all

numRepresentantes=100;
numClases=4;
%----Abrir Imagen----
img=imread('ImagenPrueba1.jpg');
figure(1)
[m,n]=size(img);
imshow(img)

%----Convertir a Coordenadas----
figure(2)
grid on
hold on
dato=imref2d(size(img));
imshow(img,dato)
%----Cargar Clases----
%Rangos
rangosPrueba=zeros(2,2,numClases);
rangosPrueba(:,:,1)=[0 900; 0 100];     %Cielo
rangosPrueba(:,:,2)=[620 810; 190 290]; %Roca
rangosPrueba(:,:,3)=[0 900; 290 599];   %Arena
rangosPrueba(:,:,4)=[0 600; 110 200];   %Montaña

%disp(rangosPrueba);
%Puntos Aleatorios
clases=zeros(2,numRepresentantes,2,numClases);
for i=1:numClases
    clases(:,:,1,i)=randi(rangosPrueba(1,:,i),2,numRepresentantes); %X
    clases(:,:,2,i)=randi(rangosPrueba(2,:,i),2,numRepresentantes); %Y
end
%disp(clases)

%GRAFICANDO SOBRE EL PLANO DE LA IMAGEN COOR PIXELARES
z=zeros(numRepresentantes,3,numClases);
for i=1:numClases
    z(:,:,i)=impixel(img,clases(1,:,1,i),clases(2,:,2,i));
end
%disp(z)
%Entrada del punto a probar
fprintf('Entrada del Vector desconocido: \n');
%fprintf('Coordenada en X: ');
puntoX=input('Coordenada en X: ');
%fprintf('Coordenada en Y: ');
puntoY=input('Coordenada en Y: ');
puntoPrueba=[puntoX;puntoY];
%Ploteando
for i=1:numClases
	    cstr=strcat('Clase',{' '},string(i));
	    plot(clases(1,:,1,i),clases(2,:,2,i),'.','MarkerSize',10,'DisplayName',cstr,'color',rand(1,3))
end
plot(puntoPrueba(1,:),puntoPrueba(2,:),'.k','MarkerSize',10,'MarkerFaceColor','k','DisplayName','P. Prueba')
legend
title('Imagen');



disp('fin de proceso...')