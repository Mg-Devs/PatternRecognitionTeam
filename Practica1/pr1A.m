%Práctica 1
clc
clear all
close all
warning off all %Apaga los warnings
%--------------------------------------------------------------------------
%Parámetros
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
    fprintf('Escribe la disperción de la Clase %d: ',aux);
    aX=input('');
    disperciones(aux,1)=aX;
end
fprintf('Disperciones:\n');
disp(disperciones');

%Crear clases y calcular medias
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
while 1
	%Entrada del vector desconocido
	fprintf('Entrada del Vector desconocido: \n')
	vecX=input('    Coordenada en X: ');
	vecY=input('    Coordenada en Y: ');
	vecDesc=[vecX;vecY];
    %Calculando Distancias
	distancias=zeros(numClases,1);
	for aux=1:numClases
	    distancias(aux,1)=norm(vecDesc-medias(:,aux));
	end

<<<<<<< HEAD
	minimo=min(distancias);
	clase=find(distancias==minimo);
	fprintf('El vector desconocido pertenece a la Clase  %d.\n',clase);

	%GRAFICANDO CLASES
	figure(1)
	plot(vecDesc(1,:),vecDesc(2,:),'ko','MarkerSize',6,'MarkerFaceColor','k','DisplayName','Vector Desc')
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
	xlabel('Atributo X')
	ylabel('Atributo Y')
	title('Gráfica de datos')
	legend
    
	bandera=upper(input('¿Desea ingrsar otro vector? Y/N: ', 's'));
	if bandera=='N'
		break
    end
    clf
end

disp('-----------FIN------------')
=======
opc = 1;

while true 
    %Entrada del vector desconocido
    fprintf('\nEntrada del Vector desconocido: \n')
    vecX=input('    Coordenada en X: ');
    vecY=input('    Coordenada en Y: ');
    vecDesc=[vecX;vecY];

    distancias=zeros(numClases,1);
    for aux=1:numClases
        distancias(aux,1)=norm(vecDesc-medias(:,aux));
    end

    minimo=min(distancias);
    clase=find(distancias==minimo);
    fprintf('El vector desconocido pertenece a la clase=%d\n',clase);

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
    
    fprintf('¿Deseas probar otro vector?\n');
    fprintf('\t1) Si\n');
    fprintf('\t2) No\n');
    
    res = input('Elige un numero: ');
    
    if res ~= 1
        break;
    end
    
    clf;

end

disp('-----------FIN------------')
>>>>>>> b65f76c3cf25e97aa0d58f02a0bc08f324718608
