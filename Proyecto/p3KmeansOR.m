% Equipo 8
% Práctica 3 Kmeans
% Parcial 2
clc
clear all
close all
warning off all

numMuestras=500;

%----Abrir Imagen----
%img=imread('Banderas/005-bandera.jpg');
img = imread('00000006.jpg');
img = imresize(img,0.5);
figure(1)
[m,n,dim]=size(img);
dato=imref2d(size(img));
imshow(img,dato)
img=rgb2lab(img);

k=4;

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
varMinima = 0;
distancias = zeros(1, k);
for veces = 1:10
    [clusters, centroides]=kmeans(k,numMuestras,muestrasRGB);
    for aux = 1:k
        c = find(clusters(6,:) == aux);
        distancias(1,aux) = norm(clusters(1:2,c) - centroides(:,aux)); 
    end
    varianza = var(distancias); 
    if varMinima == 0
        varMinima = varianza;
        clustersAux = clusters;
        centroidesAux = centroides;
        cualFueMejor = veces;
    end
    if varianza < varMinima
        varMinima = varianza;
        clustersAux = clusters;
        centroidesAux = centroides;
        cualFueMejor = veces;
    end
end
clusters = clustersAux;
centroides = centroidesAux;
disp('Centroides')
disp(centroides);

for aux = 1:k
    c = find(clusters(6,:) == aux);
    elementos = size(c);
    fprintf("La clase %d tiene %d elementos\n", aux, elementos(2));
end

figure(2);
clf;
grid on;
hold on;
for aux=1:k
    color=rand(1,3);
    cstr=strcat('Clase',{' '},string(aux));
    cstr2=strcat('Centroide',{' '},string(aux));
    c = find(clusters(6,:) == aux);
    x = clusters(1,c);
    y = clusters(2,c);
    plot(x,y, '.','MarkerSize',15,'DisplayName',cstr,'color',color)
    plot(centroides(1,aux), centroides(2,aux),'+','MarkerSize',20,'DisplayName',cstr2,'color',color)
end
xlabel('Atributo 1')
ylabel('Atributo 2')
legend

figure(3)
imgf=lab2rgb(img);
imshow(imgf,dato);
grid off
hold on
for aux=1:k
    color=rand(1,3);
    cstr=strcat('Clase',{' '},string(aux));
    cstr2=strcat('Centroide',{' '},string(aux));
    c = find(clusters(6,:) == aux);
    x = clusters(1,c);
    y = clusters(2,c);
    plot(x,y,'.','MarkerSize',15,'DisplayName',cstr,'color',color)
    plot(centroides(1,aux), centroides(2,aux),'+','MarkerSize',20,'DisplayName',cstr2,'color',color)
    clear x
    clear y
end
xlabel('Atributo 1')
ylabel('Atributo 2')
legend