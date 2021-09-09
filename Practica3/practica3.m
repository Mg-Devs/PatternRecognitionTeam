%Práctica 3
%Equipo 8
clc
clear all
close all
warning off all

numDimensiones=2;
numRepresentantes=5;
numClases=3;


clases=zeros(numDimensiones,numRepresentantes,numClases);
clases(:,:,1)=[0 0 1 0 2;0 1 1 1 1]; %Clase 1
clases(:,:,2)=[5 5 4 6 6;5 6 5 5 4]; %Clase 2
clases(:,:,3)=[9 10 11 10 9;10 11 9 12 12]; %Clase 3
medias=zeros(2,numClases);
medias(:,1)=mean(clases(:,:,1),2);
medias(:,2)=mean(clases(:,:,2),2);
medias(:,3)=mean(clases(:,:,3),2);

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
    fprintf('\t4) Todos\n');
    clasificador = input('Elige un número: ');
    
    switch clasificador
    	case 1 %Distancias
    		fprintf('Clasificador Distancia Euclidiana\n');
    		clase=clasificador_Distancias(vecDesc, medias,numClases);
    	case 2 %Bayes
    		fprintf('Clasificador Bayes\n');
    		clase=clasificador_Bayes(vecDesc,clases,numClases,medias,numRepresentantes,numDimensiones);
    	case 3 %Mahalanobis
    		fprintf('Clasificador Mahalanobis\n');
    		clase=clasificador_Mahalanobis(vecDesc,clases,medias,numClases,numRepresentantes);
    	case 4 %Todos
    		fprintf('Clasificador Distancia Euclidiana\n');
    		clase=clasificador_Distancias(vecDesc, medias,numClases);
    		if clase == -1
		        fprintf('\nEl vector no pertenece a ninguna clase conocida.\n');
		    else
		        fprintf('\nEl vector desconocido pertenece a la Clase: %d.\n',clase);
		    end
		    fprintf('Clasificador Bayes\n');
    		clase=clasificador_Bayes(vecDesc,clases,numClases,medias,numRepresentantes,numDimensiones);
			if clase == -1
		        fprintf('\nEl vector no pertenece a ninguna clase conocida.\n');
		    else
		        fprintf('\nEl vector desconocido pertenece a la Clase: %d.\n',clase);
		    end
		    fprintf('Clasificador Mahalanobis\n');
    		clase=clasificador_Mahalanobis(vecDesc,clases,medias,numClases,numRepresentantes);
    		if clase == -1
		        fprintf('\nEl vector no pertenece a ninguna clase conocida.\n');
		    else
		        fprintf('\nEl vector desconocido pertenece a la Clase: %d.\n',clase);
		    end
    	otherwise
    		fprintf('Error, elige un clasificador válido.\n');
    end
    
    if clase == -1 & clasificador~=4
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