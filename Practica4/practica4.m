%Practica 4 
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
end
fprintf('Dispersiones:\n');
disp(dispersiones');

%Crear clases:
[clases,medias]=crearClasesYMedias(numClases,numRepresentantes,centroides,dispersiones);
%fprintf('Clases:\n');
%disp(clases);
%fprintf('Medias:\n');
%disp(medias);

%---------------CICLO INFINITO---------------------
while true 
    %Entrada del vector desconocido
    fprintf('\nEntrada del Vector desconocido: \n')
    vecX=input('    Coordenada en X: ');
    vecY=input('    Coordenada en Y: ');
    vecDesc=[vecX;vecY];

    fprintf('¿Qué clasificador deseas utilizar?\n');
    fprintf('\t1) Distancia Euclidiana\n');
    fprintf('\t2) Bayes\n'); 
    fprintf('\t3) Mahalanobis\n');
    fprintf('\t4) Mahalanobis\n');
    fprintf('\t5) Todos\n');
    clasificador = input('Elige un número: ');
    
    switch clasificador
    	case 1 %Distancias
    		fprintf('Clasificador Distancia Euclidiana\n');
    		clase=clasificador_Distancias(vecDesc, medias,numClases);
    	case 2 %Bayes
    		fprintf('Clasificador Bayes\n');
    		clase=clasificador_Bayes(vecDesc,clases,numClases,medias,numRepresentantes,size(clases,1));
    	case 3 %Mahalanobis
    		fprintf('Clasificador Mahalanobis\n');
    		clase=clasificador_Mahalanobis(vecDesc,clases,medias,numClases,numRepresentantes);
        case 4 %KNN
            n_vecinos = input('Ingresa el numero de vecinos (Debe ser impar): ');
    		fprintf('Clasificador KNN\n');
    		clase=clasificador_KNN(vecDesc,clases,medias,numClases,numRepresentantes);
    	case 5 %Todos
            n_vecinos = input('Ingresa el numero de vecinos para el clasificador KNN (Debe ser impar): ');
    		fprintf('\nClasificador Distancia Euclidiana\n');
    		clase=clasificador_Distancias(vecDesc, medias,numClases);
    		if clase == -1
		        fprintf('\n\tEl vector no pertenece a ninguna clase conocida.\n');
		    else
		        fprintf('\n\tEl vector desconocido pertenece a la Clase: %d.\n',clase);
		    end
		    fprintf('Clasificador Bayes\n');
    		clase=clasificador_Bayes(vecDesc,clases,numClases,medias,numRepresentantes,size(clases,1));
			if clase == -1
		        fprintf('\n\tEl vector no pertenece a ninguna clase conocida.\n');
		    else
		        fprintf('\n\tEl vector desconocido pertenece a la Clase: %d.\n',clase);
		    end
		    fprintf('Clasificador Mahalanobis\n');
    		clase=clasificador_Mahalanobis(vecDesc,clases,medias,numClases,numRepresentantes);
    		if clase == -1
		        fprintf('\n\tEl vector no pertenece a ninguna clase conocida.\n');
		    else
		        fprintf('\n\tEl vector desconocido pertenece a la Clase: %d.\n',clase);
            end
            fprintf('Clasificador KNN\n');
    		clase=clasificador_KNN(vecDesc,clases,medias,numClases,numRepresentantes);
            if clase == -1
		        fprintf('\n\tEl vector no pertenece a ninguna clase conocida.\n');
		    else
		        fprintf('\n\tEl vector desconocido pertenece a la Clase: %d.\n',clase);
            end
    	otherwise
    		fprintf('Error, elige un clasificador válido.\n');
    end
    
    if clase == -1 & clasificador~=5
        fprintf('\nEl vector no pertenece a ninguna clase conocida.\n');
    else
        fprintf('\nEl vector desconocido pertenece a la Clase: %d.\n',clase);
    end

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
    plot(vecDesc(1,:),vecDesc(2,:),'ko','MarkerSize',6,'MarkerFaceColor','k','DisplayName','Vector Desc')
    xlabel('Eje X')
    ylabel('Ejey Y')
    title('Gráfica de datos')
    legend
    
    fprintf('¿Deseas probar otro vector?\n');
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