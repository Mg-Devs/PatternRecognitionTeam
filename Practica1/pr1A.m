%Práctica 1
clc
clear all
close all
warning off all %Apaga los warnings
%--------------------------------------------------------------------------
%Variables
fprintf('¿Cuántas clases quieres? ')
numClases=input('')
%numClases=2;
fprintf('¿Cuántos representates por clase quieres? ')
numRepresentantes=input('')
numRepresentantes=200;
%Centroides
centroides=zeros(numClases,1);
for aux=1:numClases
    fprintf('Escribe el centroide de la Clase %d: ',aux)
	aX=input('')
    centroides(aux,1)=aX;
end
fprintf('Centroides:\n')
disp(centroides)

%Disperción
%
% No me acuerdo de esto
%

%Crear clases:
clases=zeros(2*numClases,numRepresentantes);
medias=zeros(2*numClases,1);
aux1=1;
for aux=1:numClases
    cAux=randn(2,numRepresentantes)+centroides(aux,1);
    clases(aux1:aux1+1,1:numRepresentantes)=cAux;
    mediaAux=(1/numRepresentantes)*[sum(cAux(1,:)) ; sum(cAux(2,:))]
    medias(aux1:aux1+1,1)=mediaAux
    aux1=aux1+2;
end
fprintf('Clases:\n')
disp(clases)

%--------------------------------------------------------------------------
%Entrada del vector desconocido
fprintf('Entrada del Vector desconocido: \n')
vecX=input('    Coordenada en X: ')
vecY=input('    Coordenada en Y: ')
vecDesc=[vecX;vecY]






%GRAFICANDO CLASES
figure(1)
plot(vecDesc(1,:),vecDesc(2,:),'ko','MarkerSize',10,'MarkerFaceColor','k','DisplayName','Vector Desc')
grid on
hold on
colores={'r','g','c','m','y'};
cont=1;
for aux=1:2:(2*numClases)
    cstr=strcat('Clase',{' '},string(cont));
	%plot(clases(aux,:),clases(aux+1,:),'o','MarkerSize',10,'MarkerFaceColor','r','DisplayName',cstr)
    plot(clases(aux,:),clases(aux+1,:),'.','MarkerSize',10,'DisplayName',cstr)
    cont=cont+1;
end
cont=1;
for aux=1:2:(2*numClases)
    mstr=strcat('Media',{' '},string(cont));
	%plot(medias(aux,1),medias(aux+1,1),'d','MarkerSize',12,'MarkerFaceColor','b','MarkerEdgeColor','k','DisplayName',mstr)
    plot(medias(aux,1),medias(aux+1,1),'+','MarkerSize',12,'DisplayName',mstr)
    cont=cont+1;
end
xlabel('Atributo X')
ylabel('Atributo Y')
title('Gráfica de datos')
legend



disp('-----------FIN------------')