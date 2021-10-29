% Equipo 8
% Práctica 3 Kmeans
% Parcial 2
clc
clear all
close all
warning off all

numMuestras=200;
k=input("Ingrese el número de clusters (k): ");

%----Abrir Imagen----
img=imread('Banderas/018-bandera.jpg');
figure(1)
[m,n,dim]=size(img);
dato=imref2d(size(img));
imshow(img,dato)

%----Creando muestras en la Imagen----
muestras = zeros(2,numMuestras);
%muestras = crearMuestras(numMuestras, n, m)

muestras(1,:)=randi([1,n-1],1,numMuestras);
muestras(2,:)=randi([1,m-1],1,numMuestras);
%disp('Muestras')
%disp(muestras);

%----Graficando Muestras----
grid off
hold on
plot(muestras(1,:),muestras(2,:),'.g','MarkerSize',15);
promVarMax=0;
cualFueMejor=0;
varianzas = zeros(1,k);

%----Obteniendo RGB  de las muestras----
muestrasRGB=zeros(5,numMuestras);
muestrasRGB(1:2,:)=muestras;
for i=1:numMuestras
    muestrasRGB(3:5,i)=impixel(img,muestras(1,i),muestras(2,i));
end

%----K_means----
for veces = 1:10
    [clusters, centroides]=kmeans(k,numMuestras,muestrasRGB);
end
disp('Centroides')
disp(centroides);

figure(2)
imshow(img,dato)
grid off
hold on
for aux=1:k
    color=rand(1,3);
    cstr=strcat('Clase',{' '},string(aux));
    c = find(clusters(6,:) == aux);
    x = clusters(1,c);
    y = clusters(2,c);
    plot(x,y,'.','MarkerSize',15,'DisplayName',cstr,'color',color)
    clear x
    clear y
end
xlabel('Atributo 1')
ylabel('Atributo 2')
legend
