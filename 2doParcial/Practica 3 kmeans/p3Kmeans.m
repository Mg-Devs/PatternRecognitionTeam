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



numMuestras=200;
k=input("Ingrese el número de clusters (k): ");


%----Creando muestras en la Imagen----
muestras = zeros(2,numMuestras);
%muestras = crearMuestras(numMuestras, n, m)

% muestras(1,:)=randi([-100,500],1,numMuestras);
% muestras(2,:)=randi([-100,500],1,numMuestras);

muestras(1,1:50)=randi([-100,-50],1,50);
muestras(2,1:50)=randi([-50,0],1,50);
muestras(1,51:100)=randi([0,50],1,50);
muestras(2,51:100)=randi([-25,25],1,50);
muestras(1,101:150)=randi([-100,-50],1,50);
muestras(2,101:150)=randi([50,150],1,50);
muestras(1,151:200)=randi([100,150],1,50);
muestras(2,151:200)=randi([150,250],1,50);

%disp('Muestras')
%disp(muestras);

%----Graficando Muestras----
figure(1)
grid on
hold on
plot(muestras(1,:),muestras(2,:),'.g','MarkerSize',15);

%----K_means----
[clusters, centroides]=kmeans(k,numMuestras,muestras);
disp('Centroides')
disp(centroides);

figure(2)
grid on
hold on
for aux=1:k
    color=rand(1,3);
    cstr=strcat('Clase',{' '},string(aux));
    cstr2=strcat('Centroide',{' '},string(aux));
    c = find(clusters(3,:) == aux);
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