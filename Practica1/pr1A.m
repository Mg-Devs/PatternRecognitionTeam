%Práctica 1
clc
clear all
close all
warning off all %Apaga los warnings
%--------------------------------------------------------------------------
%Variables
numClases=input('¿Cuántas clases quieres?: ');
numRepresentantes=input('¿Cuántos representates por clase quieres?: ');

%Centroides
centroides=zeros(numClases,1);
fprintf('\n');
for aux=1:numClases
    fprintf('Escribe el centroide de la Clase %d: ',aux);
    aX=input('');
    centroides(aux,1)=aX;
end
fprintf('Centroides:\n');
disp(centroides');

%Disperción
disperciones=zeros(numClases,1);
fprintf('\n');
for aux=1:numClases
    fprintf('Escribe la dispercion de la Clase %d: ',aux);
    aX=input('');
    disperciones(aux,1)=aX;
end
fprintf('Disperciones:\n');
disp(disperciones');

%Crear clases:
clases=zeros(2,numRepresentantes,numClases);
medias=zeros(2,numClases)
aux1=1;
for aux=1:numClases
    cAux=(randn(2,numRepresentantes)+centroides(aux,1))*disperciones(aux,1);
    clases(:,:,aux)=cAux;
    medias(:,aux)=mean(clases(:,:,aux),2);
end
fprintf('Clases:\n');
disp(clases);
fprintf('Medias:\n');
disp(medias);

%--------------------------------------------------------------------------

%Entrada del vector desconocido
fprintf('Entrada del Vector desconocido: \n')
vecX=input('    Coordenada en X: ');
vecY=input('    Coordenada en Y: ');
vecDesc=[vecX;vecY];

%GRAFICANDO CLASES
figure(1)
plot(vecDesc(1,:),vecDesc(2,:),'ko','MarkerSize',6,'MarkerFaceColor','k','DisplayName','Vector Desc')
grid on
hold on
for aux=1:numClases
    cstr=strcat('Clase',{' '},string(aux));
	%plot(clases(aux,:),clases(aux+1,:),'o','MarkerSize',10,'MarkerFaceColor','r','DisplayName',cstr)
    plot(clases(1,:,aux),clases(2,:,aux),'.','MarkerSize',15,'DisplayName',cstr,'color',rand(1,3))
end

for aux=1:numClases
    mstr=strcat('Media',{' '},string(aux));
	%plot(medias(aux,1),medias(aux+1,1),'d','MarkerSize',12,'MarkerFaceColor','b','MarkerEdgeColor','k','DisplayName',mstr)
    plot(medias(1,aux),medias(2,aux),'+','MarkerSize',12,'DisplayName',mstr,'color',rand(1,3))
end
xlabel('Atributo X')
ylabel('Atributo Y')
title('Gráfica de datos')
legend



disp('-----------FIN------------')