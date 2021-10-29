% Equipo 8
% Práctica 3 Kmeans
% Parcial 2
clc
clear all
close all
warning off all

numClases=4; %K
numMuestras=200;

%----Abrir Imagen----
img=imread('Banderas/022-bandera.jpg');
figure(1)
[m,n,dim]=size(img);
dato=imref2d(size(img));
imshow(img,dato)

%----Creando muestras en la Imagen----
muestras = zeros(2,numMuestras);
%muestras = crearMuestras(numMuestras, n, m)
muestras(1,:)=randi([0,n],1,numMuestras);
muestras(2,:)=randi([0,m],1,numMuestras);
%disp('Muestras')
%disp(muestras);

%----Graficando Muestras----
grid on
hold on
plot(muestras(1,:),muestras(2,:),'.g','MarkerSize',15);
%----Obteniendo RGB  de las muestras----
muestasRGB=zeros(3,numMuestras);
for i=1:numMuestras
    muestrasRGB(:,i)=impixel(img,muestras(1,i),muestras(2,i));
end
%disp('Muestras RGB')
%disp(muestrasRGB)

%----K_means----
%centroides=zeros(3,numClases);
[gruposF,numElementos]=k_means(numClases,muestrasRGB,numMuestras,muestras);
disp('numElementos')
disp(numElementos)

figure(2)
imshow(img,dato)
grid on
hold on
[f,c]=size(numElementos);
for aux=1:numClases
    color=rand(1,3);
    cstr=strcat('Clase',{' '},string(aux));
    x=0;
    y=0;
    for aux2=1:numElementos(aux)
        x(aux2)=gruposF(1,aux2,aux);
        y(aux2)=gruposF(2,aux2,aux);
        %plot(gruposF(1,aux2,aux),gruposF(2,aux2,aux),'.','MarkerSize',15,'DisplayName',cstr,'color',color)
    end
    plot(x,y,'.','MarkerSize',15,'DisplayName',cstr,'color',color)
    clear x
    clear y
end
xlabel('Atributo 1')
ylabel('Atributo 2')
legend
