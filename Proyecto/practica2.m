%Tercer Parcial
%Práctica 2
%Equipo 8
clc 
clear all
close all
warning off all
%1 5  9 10 11 %45

inicio=1;
fin=92;
descriptores=zeros(3);
contador=1;
offsets0 = [(1:40)' zeros(40,1)];
for aux=inicio:fin
    cantidad = 0;
    imgAux=leerImagen(aux);
    %[rows, columns] = size(imgAux);
    %areaImagen = rows * columns;
    %fprintf('Mostrando Imagen %d: \n',aux);
    %imshow(imgAux);
    BW=im2bw(imgAux);
    gcm = graycomatrix(BW,'Offset',offsets0);
    texture=graycoprops(gcm,{'Contrast','Correlation','Energy'});
    descriptores(:,contador) = [mean(texture.Contrast)*100 mean(texture.Correlation)*100 mean(texture.Energy)*100];
    contador = contador+1;
    %Contrast: [0.0075 0.0152 0.0126 0.0341]
    %Correlation: [0.9829 0.9653 0.9713 0.9226]
    %Energy: [0.5539 0.5455 0.5481 0.5261]
    %Homogeneity: [0.9963 0.9924 0.9937 0.9829]
end

km = 3;
minSSE = realmax;
for i = 1:20
    [clusters, centroides]=kmeans(km,contador-1,descriptores);
    SSE=0;
    if sum(isnan(centroides(:))) > 0
        SSE = realmax;
    else
        for k = 1:contador-1
            distancias=zeros(km,1);
            for l = 1:km
                distancias(l,1) = norm(clusters(1:3,k)-centroides(:,l));
            end
            minimo=min(distancias);
            SSE = SSE + minimo^2;
        end
    end
    if isequal(minSSE, realmax) || minSSE > SSE
        clustersAux = clusters;
        centroidesAux = centroides;
        minSSE = SSE;
    end
end
clusters = clustersAux;
centroides = centroidesAux;
disp('Centroides')
disp(centroides);
size

for aux = 1:k
    c = find(clusters(4,:) == aux);
    elementos = size(c);
    fprintf("La clase %d tiene %d elementos\n", aux, elementos(2));
end

centroides(:,6) = [0, 0, 0];
while(1)
    figure(1);
    clf;
    grid on;
    hold on;
    for aux=1:km
        color=rand(1,3);
        cstr=strcat('Clase',{' '},string(aux));
        cstr2=strcat('Centroide',{' '},string(aux));
        c = find(clusters(4,:) == aux);
        x = clusters(1,c);
        y = clusters(2,c);
        z = clusters(3,c);
        plot3(x,y,z,'.','MarkerSize',15,'DisplayName',cstr,'color',color)
        plot3(centroides(1,aux), centroides(2,aux),centroides(3,aux),'+','MarkerSize',20,'DisplayName',cstr2,'color',color)
        clear x
        clear y
    end
    xlabel('Atributo 1')
    ylabel('Atributo 2')
    legend
    fprintf("Ingrese el numero de la imagen que desea: (1/114)\n")
    aux = input("");
    figure(2)
    clf;
    imgAux=leerImagen(aux);
    [rows, columns] = size(imgAux);
    areaImagen = rows * columns;
    %fprintf('Mostrando Imagen %d: \n',aux);
    figure(2)
    imshow(imgAux);
    contadores=zeros(1,6); %Tornillos, Rondanas, Armellas, Llaves Allen, No se cómo se llama
    objetos=regionprops(imgAux,'Perimeter','Area','Centroid','BoundingBox', 'MajorAxisLength');
    for k=1:length(objetos)
        vectDesconocido = zeros(2);
        caja=objetos(k).BoundingBox;
        perimetro=objetos(k).Perimeter;
        area=objetos(k).Area;
        majorAxisLength = objetos(k).MajorAxisLength;
        if (area>50)
            figure(2);
            areaProporcional=(area/areaImagen)*10000;
            vectDesconocido = [areaProporcional majorAxisLength];
            clase = clasificador_Distancias(vectDesconocido, centroides, km);
%             clase = clasificador_Mahalanobis(vectDesconocido, clusters, centroides, km, contador-1);
%             clase = clasificador_Bayes(vectDesconocido,descriptores,km,centroides,contador-1,2);
            tipoObj = defObjeto(centroides(:,clase));
            if isequal(tipoObj, 1) %Tornillos
                rectangle('Position',[caja(1),caja(2),caja(3),caja(4)],'EdgeColor','c','LineWidth',2);
                text(objetos(k).Centroid(1),objetos(k).Centroid(2),'Tornillo','Color','c');
                contadores(1)=contadores(1)+1;
            elseif isequal(tipoObj, 2) %Llaves Allen
                rectangle('Position',[caja(1),caja(2),caja(3),caja(4)],'EdgeColor','g','LineWidth',2);
                text(objetos(k).Centroid(1),objetos(k).Centroid(2),'Llave Allen','Color','g');
                contadores(2)=contadores(2)+1;
            elseif isequal(tipoObj, 3) %Armellas
                rectangle('Position',[caja(1),caja(2),caja(3),caja(4)],'EdgeColor','r','LineWidth',2);
                text(objetos(k).Centroid(1),objetos(k).Centroid(2),'Armella','Color','r');
                contadores(3)=contadores(3)+1;
            elseif isequal(tipoObj, 4) %Rondanas
                rectangle('Position',[caja(1),caja(2),caja(3),caja(4)],'EdgeColor','m','LineWidth',2);
                text(objetos(k).Centroid(1),objetos(k).Centroid(2),'Rondana','Color','m');
                contadores(4)=contadores(4)+1;
            elseif isequal(tipoObj, 5) %ColadePato
                rectangle('Position',[caja(1),caja(2),caja(3),caja(4)],'EdgeColor','y','LineWidth',2);
                text(objetos(k).Centroid(1),objetos(k).Centroid(2),'Cola de Pato','Color','y');
                contadores(5)=contadores(5)+1;
            else
                rectangle('Position',[caja(1),caja(2),caja(3),caja(4)],'EdgeColor','b','LineWidth',2);
                text(objetos(k).Centroid(1),objetos(k).Centroid(2),'Otro','Color','b');
                contadores(6)=contadores(6)+1;
            end 
            hold on
            figure(1);
            plot(vectDesconocido(1), vectDesconocido(2), 'x','MarkerSize',15,'DisplayName','VectDesconocido','color','k')
        end
    end
    fprintf('Imagen: %d\n',aux);
    fprintf('El número total de figuras es: %d\n',sum(contadores));
    fprintf('\tTornillos: %d\n',contadores(1));
    fprintf('\tRondanas: %d\n',contadores(4));
    fprintf('\tArmellas: %d\n',contadores(3));
    fprintf('\tLlaves Allen: %d\n',contadores(2));
    fprintf('\tColas De Pato: %d\n',contadores(5));
    fprintf('\tOtros: %d\n',contadores(6));
    clear contadores;
    fprintf("Desea identificar otra imagen?\n1) Si\n2) No\n");
    opcion = input("");
    if isequal(opcion, 2)
        break;
    end
end

disp('Fin de proceso...')
