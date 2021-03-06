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
    fprintf('Escribe la dispersión de la Clase %d: ',aux);
    aX=input('');
    dispersiones(aux,1)=aX;
    %dispersiones(aux,1)=2;
end
fprintf('Dispersiones:\n');
disp(dispersiones');

%Crear clases:
[clases,medias]=crearClasesYMedias(numClases,numRepresentantes,centroides,dispersiones);
%fprintf('Clases:\n');
%disp(clases);
%fprintf('Medias:\n');
%disp(medias);

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
mcCrossValidation=zeros(numClases,numClases);
mcCrossValidationAux=zeros(numClases,numClases);
mcHoldOne=zeros(numClases,numClases);
promedios=zeros(1,3);
%---------------CICLO INFINITO---------------------
while true 
    fprintf('\n\n¿Qué clasificador deseas probar?\n');
    fprintf('\t1) Distancia Euclidiana\n');
    fprintf('\t2) Bayes\n'); 
    fprintf('\t3) Mahalanobis\n');
    fprintf('\t4) KNN\n');
    fprintf('\t5) Todos\n');
    clasificador = input('Elige un número: ');
    
    n_vecinos = 0;
    if clasificador>=4
        n_vecinos=input('Ingresa el numero de vecinos para el clasificador KNN (Debe ser impar): ');
    end
    
    if clasificador ~= 5
        switch clasificador
            case 1 %Distancias
                fprintf('Clasificador Distancia Euclidiana\n');
            case 2 %Bayes
                fprintf('Clasificador Bayes\n');
            case 3 %Mahalanobis
                fprintf('Clasificador Mahalanobis\n');
            case 4 %KNN
                fprintf('Clasificador KNN\n');
            otherwise
                fprintf('Error, elige un clasificador válido.\n');
                break;
        end
        
        %Método Resustitución
        disp('Método de Resustitución:');
        [mcResustitucion,promedios(1,1)]=resustitucion(clasificador,clases,medias,numClases,numRepresentantes,n_vecinos);
        disp('Matriz de confusion:');
        disp(mcResustitucion);
        fprintf('Promedio Total: %f\n',promedios(1,1));
        %Método Cross-Validation
        disp('Método de Cross-Validation:');
        sumaDePromedios = 0;
        for i = 1:20
            copiaClases = reordenarRepresentantes(clases, numClases, numRepresentantes);
            mitadClases = copiaClases(:,1:floor(numRepresentantes/2),:);
            mitadMedias = mean(mitadClases,2);
            valoresDePrueba = copiaClases(:,floor(numRepresentantes/2)+1:numRepresentantes,:);
            
            [mcCrossValidationAux,sumaDePromedios] = crossValidation(clasificador,mitadClases,mitadMedias,numClases, floor(numRepresentantes/2), valoresDePrueba,n_vecinos);
            promedios(1,2) = promedios(1,2) + sumaDePromedios;
            mcCrossValidation = mcCrossValidation + mcCrossValidationAux;
        end
        promedios(1,2) = promedios(1,2)/20;
        mcCrossValidation = mcCrossValidation/20;
        fix = max(max(mcCrossValidation));
        if (fix > 100); fix = fix-100; else; fix = 0; end
        mcCrossValidation = mcCrossValidation - fix;
        mcCrossValidation(mcCrossValidation<0) = 0;
        promedios(promedios>100) = 100 - fix;
        disp('Matriz de confusion:');
        disp(mcCrossValidation);
        fprintf('Promedio Total: %f\n',promedios(1,2));
        %Método Hold One
        disp('Método Hold-One:');
        [mcHoldOne,promedios(1,3)]=holdOne(clasificador,clases,medias,numClases,numRepresentantes,n_vecinos);
        disp('Matriz de confusion:');
        disp(mcHoldOne);
        fprintf('Promedio Total: %f\n',promedios(1,3));

        %Graficando Resultados
        figure(2)
        grid on;
        hold on;
        x=[1:numClases];
        plot(x,sum(mcResustitucion,1),'.-','MarkerSize',20,'DisplayName','Resustitución')
        plot(x,sum(mcCrossValidation,1),'.-','MarkerSize',20,'DisplayName','CrossValidation')
        plot(x,sum(mcHoldOne,1),'.-','MarkerSize',20,'DisplayName','HoldOne')
        xlabel('Eje X')
        ylabel('Ejey Y')
        title('Gráfica de Resultados')
        legend

        fprintf('\n¿Deseas probar otro clasificador?\n');
        fprintf('\t1) Si\n');
        fprintf('\t2) No\n');
        res = input('Elige un número: ');
        if res ~= 1
            break;
        end
        clf;
    
    else
        names = ["Distancia Euclidiana","Bayes","Mahalanobis","KNN"];
        for aux=1:4
            fprintf('\n\n-------------------------------------------\n');
            switch aux
                case 1 %Distancias
                    fprintf('Clasificador Distancia Euclidiana\n');
                case 2 %Bayes
                    fprintf('Clasificador Bayes\n');
                case 3 %Mahalanobis
                    fprintf('Clasificador Mahalanobis\n');
                case 4 %KNN
                    fprintf('Clasificador KNN\n');
            end

            %Método Resustitución
            disp('Método de Resustitución:');
            [mcResustitucion,promedios(1,1)]=resustitucion(aux,clases,medias,numClases,numRepresentantes,n_vecinos);
            disp('Matriz de confusion:');
            disp(mcResustitucion);
            fprintf('Promedio Total: %f\n',promedios(1,1));
            %Método Cross-Validation
            disp('Método de Cross-Validation:');
            sumaDePromedios = 0;
            for i = 1:20
                copiaClases = reordenarRepresentantes(clases, numClases, numRepresentantes);
                mitadClases = copiaClases(:,1:floor(numRepresentantes/2),:);
                mitadMedias = mean(mitadClases,2);
                valoresDePrueba = copiaClases(:,floor(numRepresentantes/2)+1:numRepresentantes,:);

                [mcCrossValidationAux,sumaDePromedios] = crossValidation(aux,mitadClases,mitadMedias,numClases, floor(numRepresentantes/2), valoresDePrueba,n_vecinos);
                promedios(1,2) = promedios(1,2) + sumaDePromedios;
                mcCrossValidation = mcCrossValidation + mcCrossValidationAux;
            end
            promedios(1,2) = promedios(1,2)/20;
            mcCrossValidation = mcCrossValidation/20;
            fix = max(max(mcCrossValidation));
            if (fix > 100); fix = fix-100; else; fix = 0; end
            mcCrossValidation = mcCrossValidation - fix;
            mcCrossValidation(mcCrossValidation<0) = 0;
            promedios(promedios>100) = 100 - fix;
            disp('Matriz de confusion:');
            disp(mcCrossValidation);
            fprintf('Promedio Total: %f\n',promedios(1,2));
            %Método Hold One
            disp('Método Hold-One:');
            [mcHoldOne,promedios(1,3)]=holdOne(aux,clases,medias,numClases,numRepresentantes,n_vecinos);
            disp('Matriz de confusion:');
            disp(mcHoldOne);
            fprintf('Promedio Total: %f\n',promedios(1,3));

            %Graficando Resultados
            figure(aux+1)
            grid on;
            hold on;
            x=[1:numClases];
            plot(x,sum(mcResustitucion,1),'.-','MarkerSize',20,'DisplayName','Resustitución')
            plot(x,sum(mcCrossValidation,1),'.-','MarkerSize',20,'DisplayName','CrossValidation')
            plot(x,sum(mcHoldOne,1),'.-','MarkerSize',20,'DisplayName','HoldOne')
            xlabel('Eje X')
            ylabel('Ejey Y')
            title(strcat('Gráfica de Resultados - ',names(aux)))
            legend
        end
        
        fprintf('\n¿Deseas probar otro clasificador?\n');
        fprintf('\t1) Si\n');
        fprintf('\t2) No\n');
        res = input('Elige un número: ');
        if res ~= 1
            break;
        end
        clf;
        
    end
end
disp('Gracias')
disp('-----------FIN------------')