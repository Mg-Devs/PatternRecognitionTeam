%Equipo 8
%Parcial 2
%Práctica 2  
clc
clear all
close all
warning off all

numClases=4;
numRepresentantes=100;

%----Abrir Imagen----
img=imread('ImagenPrueba1.jpg');
figure(1)
[m,n]=size(img);
dato=imref2d(size(img));
imshow(img,dato)

%----Establecer las clases de la imágen
[clases, medias] = crearClases(numClases,numRepresentantes);

%----Graficando sobre el plano de la imagen en coordenadas pixelares
Z1 = impixel(img,clases(1,:,1),clases(2,:,1));  %Cielo 
Z2 = impixel(img,clases(1,:,2),clases(2,:,2));  %Roca
Z3 = impixel(img,clases(1,:,3),clases(2,:,3));  %Arena
Z4 = impixel(img,clases(1,:,4),clases(2,:,4));  %Montaña

%---- While TRUE
while true
    %----Solicitar el vector desconocido
    px=input('dame la coord del vector en x = ')
    py=input('dame la coord del vector en y = ')

    vecDesc=[px;py];

    P1=impixel(img,vecDesc(1,:),vecDesc(2,:));
    
    %----Elegir el clasificador
    fprintf('¿Qué clasificador deseas utilizar?\n');
    fprintf('\t1) Distancia Euclidiana\n');
    fprintf('\t2) Bayes\n'); 
    fprintf('\t3) Mahalanobis\n');
    fprintf('\t4) KNN\n');
    fprintf('\t5) Todos\n');
    clasificador = input('Elige un número: ');
    
    switch clasificador
        case 1
            fprintf('Clasificador Distancia Euclidiana\n');
            clase=clasificador_Distancias(vecDesc, medias,numClases);
        case 2
            fprintf('Clasificador Bayes\n');
            clase=clasificador_Bayes(vecDesc,clases,numClases,medias,numRepresentantes,size(clases,1));
        case 3
            fprintf('Clasificador Mahalanobis\n');
            clase=clasificador_Mahalanobis(vecDesc,clases,medias,numClases,numRepresentantes);
        case 4
            fprintf('Clasificador KNN\n');
            clase=clasificador_KNN(clases,numClases,numRepresentantes,3,vecDesc);
        case 5
            %Clasificador de distancias euclidianas
            fprintf('\nClasificador Distancia Euclidiana\n');
            clase=clasificador_Distancias(vecDesc, medias,numClases);
            if clase == -1
                fprintf('\tEl vector no pertenece a ninguna clase conocida.\n');
            else
                elemento = definirClase(clase)
                fprintf('\tEl vector desconocido pertenece a la Clase: %s.\n',elemento);
            end
            
            %Clasificador Bayesiano
            fprintf('\nClasificador Bayes\n');
            clase=clasificador_Bayes(vecDesc,clases,numClases,medias,numRepresentantes,size(clases,1));
            if clase == -1
                fprintf('\tEl vector no pertenece a ninguna clase conocida.\n');
            else
                elemento = definirClase(clase)
                fprintf('\tEl vector desconocido pertenece a la Clase: %s.\n',elemento);
            end
            
            %Clasificador de Mahalanobis
            fprintf('\nClasificador Mahalanobis\n');
            clase=clasificador_Mahalanobis(vecDesc,clases,medias,numClases,numRepresentantes);
            if clase == -1
                fprintf('\tEl vector no pertenece a ninguna clase conocida.\n');
            else
                elemento = definirClase(clase)
                fprintf('\tEl vector desconocido pertenece a la Clase: %s.\n',elemento);
            end
            
            %Clasificador KNN
            fprintf('\nClasificador KNN\n');
            clase=clasificador_KNN(clases,numClases,numRepresentantes,3,vecDesc);
            if clase == -1
                fprintf('\tEl vector no pertenece a ninguna clase conocida.\n');
            else
                elemento = definirClase(clase)
                fprintf('\tEl vector desconocido pertenece a la Clase: %s.\n',elemento);
            end
            
        otherwise
            fprintf('Error, elige un clasificador válido.\n');
    end
    
    %----Preguntar si desea realizar el proceso nuevamente
    if clasificador~=5
        if clase == -1
            fprintf('\tEl vector no pertenece a ninguna clase conocida.\n');
        else
            elemento = definirClase(clase)
            fprintf('\tEl vector desconocido pertenece a la Clase: %s.\n',elemento);
        end
    end
    
    %----Plotear las clases y el vector desconocido
    grid on
    hold on

    plot(clases(1,:,1),clases(2,:,1),'oy','MarkerSize',10)  %Cielo
    plot(clases(1,:,2),clases(2,:,2),'og','MarkerSize',10)  %Roca
    plot(clases(1,:,3),clases(2,:,3),'or','MarkerSize',10)  %Arena 
    plot(clases(1,:,4),clases(2,:,4),'ob','MarkerSize',10)  %Montaña
    plot(vecDesc(1,:),vecDesc(2,:),'oy','MarkerSize',10,'MarkerFaceColor','y')
    
    fprintf('¿Deseas probar otro vector?\n');
    fprintf('\t1) Si\n');
    fprintf('\t2) No\n');
    res = input('Elige un número: ');
    if res ~= 1
        break;
    end    
    clf;
end    