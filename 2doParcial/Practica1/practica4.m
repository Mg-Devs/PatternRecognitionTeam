%Practica 1
%Equipo 8

clc
clear all
close all
warning off all

numClases=input('¿Cuántas clases quieres?: ');
numRepresentantes=input('¿Cuántos representates por clase quieres?: ');

%Centroides
centroides=zeros(2,numClases);
fprintf('\n');
for aux=1:numClases
    fprintf('Escribe el centroide en X de la Clase %d: ',aux);
    aX=input('');
    fprintf('Escribe el centroide en Y de la Clase %d: ',aux);
    aY=input('');
    centroides(1,aux)=aX;
    centroides(2,aux)=aY;
end
fprintf('Centroides:\n');
disp(centroides);

%Dispersión
dispersiones=zeros(numClases,1);
fprintf('\n');
for aux=1:numClases
    %fprintf('Escribe la dispersión de la Clase %d: ',aux);
    %aX=input('');
    %dispersiones(aux,1)=aX;
    dispersiones(aux,1)=2;
end
fprintf('Dispersiones:\n');
disp(dispersiones');

%Crear clases:
[clases,medias]=crearClasesYMedias(numClases,numRepresentantes,centroides,dispersiones);
fprintf('Clases:\n');
disp(clases);
fprintf('Medias:\n');
disp(medias);

%GRAFICANDO CLASES
figure(1)
grid on
hold on
for aux=1:numClases
    cstr=strcat('Clase',{' '},string(aux));
    plot(clases(1,:,aux),clases(2,:,aux),'.','MarkerSize',15,'DisplayName',cstr,'color',rand(1,3))
end
for aux=1:numClases
    mstr=strcat('Media',{' '},string(aux));
    plot(medias(1,aux),medias(2,aux),'+','MarkerSize',12,'DisplayName',mstr,'color',rand(1,3))
end
%plot(vecDesc(1,:),vecDesc(2,:),'ko','MarkerSize',6,'MarkerFaceColor','k','DisplayName','Vector Desc')
xlabel('Eje X')
ylabel('Ejey Y')
title('Gráfica de Clases')
legend

%Matrices de Confusión:
mcResustitucion=zeros(numClases,numClases);
%mcCrossValidation=zeros(1,1);
%mcHoldOne=zeros(1,1);
promedios=zeros(1,3);
%---------------CICLO INFINITO---------------------
while true 
    fprintf('¿Qué clasificador deseas probar?\n');
    fprintf('\t1) Distancia Euclidiana\n');
    fprintf('\t2) Bayes\n'); 
    fprintf('\t3) Mahalanobis\n');
    fprintf('\t4) KNN\n');
    %fprintf('\t5) Todos\n');
    clasificador = input('Elige un número: ');

    %Método Resustitución
    [mcResustitucion,promedios(1,1)]=resustitucion(clasificador,clases,medias,numClases,numRepresentantes);
    disp('Método de Resustitución:');
    disp(mcResustitucion);
    fprintf('Promedio Total: %f',promedios(1,1));
    %Método Cross-Validation
    %mcCrossValidation=crossValidation();
    %disp('Método de Cross-Validation:');
    %disp(mcCrossValidation);
    %Método Hold One
    %mcCrossValidation=crossValidation();
    %disp('Método de Cross-Validation:');
    %disp(mcCrossValidation);
    
    
    %Graficando Resultados
    figure(2)
    grid on
    hold on
    x=zeros(1,numClases);
    y=zeros(1,numClases);
    for aux=1:numClases
        %x(:,aux)=aux*numRepresentantes;
        x(:,aux)=aux;
        y(:,aux)=mcResustitucion(aux,aux);
    end 
    plot(x,y,'.','MarkerSize',20,'DisplayName','Resustitución'),'Color',[0,0,0];
    xlabel('Eje X')
    ylabel('Ejey Y')
    title('Gráfica de Resultados')
    legend

    fprintf('¿Deseas probar otro clasificador?\n');
    fprintf('\t1) Si\n');
    fprintf('\t2) No\n');
    res = input('Elige un número: ');
    if res ~= 1
        break;
    end
    clf;
end
disp('Gracias')
disp('-----------FIN------------')