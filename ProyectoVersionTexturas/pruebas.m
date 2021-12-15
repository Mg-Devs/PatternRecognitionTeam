clc 
clear all
close all
warning off all

centroides = zeros(4,100);
centroidesPorImg = zeros(3,3);
cent = 1;
tipoPM = 1;
while tipoPM < 3
    muestras = 1;
    while muestras < 10
        ciclos = 1;
        while ciclos < 3
            switch tipoPM
    %             case 1
    %             switch ciclos
    %                 case 1 
    %                     aux = strcat('playas/arena',string(muestras),'.jpg');
    %                     clase = strcat('Arena',string(muestras));
    %                 case 2
    %                     aux = strcat('playas/mar',string(muestras),'.jpg');
    %                     clase = strcat('Mar',string(muestras));
    %                 case 3
    %                     aux = strcat('playas/cielo',string(muestras),'.jpg');
    %                     clase = strcat('Cielo',string(muestras));
    %                 case 4
    %                     aux = strcat('playas/otros5.jpg');
    %                     clase = strcat('Otros',string(muestras));
    %             end
                case 1
                    switch ciclos
                        case 1 
                            color = 'b';
                            if muestras < 10
                                aux = strcat('montanias/cielo0',string(muestras),'.jpg');
                            else
                                aux = strcat('montanias/cielo',string(muestras),'.jpg');
                            end
                            clase = strcat('CieloM',string(muestras));
                            tipo = 1;
                        case 2
                            color = 'k';
                            if muestras < 10
                                aux = strcat('montanias/montania0',string(muestras),'.jpg');
                            else
                                aux = strcat('montanias/montania',string(muestras),'.jpg');
                            end
                            clase = strcat('Montania',string(muestras));
                            tipo = 2;
                    end
                case 2
                    switch ciclos
                        case 1 
                            color = 'b';
                            if muestras < 10
                                aux = strcat('praderas/cielo0',string(muestras),'.jpg');
                            else
                                aux = strcat('praderas/cielo',string(muestras),'.jpg');
                            end
                            clase = strcat('CieloP',string(muestras));
                            tipo = 1;
                        case 2
                            color = 'g';
                            if muestras < 10
                                aux = strcat('praderas/pradera0',string(muestras),'.jpg');
                            else
                                aux = strcat('praderas/pradera',string(muestras),'.jpg');
                            end
                            clase = strcat('Pradera',string(muestras));
                            tipo = 3;
                    end
            end
            imgAux=imread(aux);
            [rows, columns] = size(imgAux);
            tamanio = 20;

            imgGris = rgb2gray(imgAux);
            entropia = entropyfilt(imgGris);
            filas = fix(rows/tamanio);
            columnas = fix((columns/3)/tamanio);
            numeroDeCrops = filas*columnas;
            variasGLCM = zeros(8,8,numeroDeCrops);
            entropias = zeros(1,numeroDeCrops);
            valores = zeros(3,numeroDeCrops);
            h=1;
            for i=0:columnas-1
                for j=0:filas-1
                    if h ~= numeroDeCrops
                        cropImg = imcrop(imgGris,[i*tamanio,j*tamanio,tamanio,tamanio]);
                        b = cropImg > 0;
                        if length(find(b == 0)) > 10
                        else
                            glcms = graycomatrix(cropImg);
                            variasGLCM(:,:,h) = glcms;
                            entropias(:,h) = entropy(cropImg);
                            h = h + 1;
                        end
                    end
                end
            end
            for i=1:h-1
                if isnan(graycoprops(variasGLCM(:,:,i),'contrast').Contrast)
                    valores(1,i) = valores(1,i-1);
                else
                    valores(1,i) = graycoprops(variasGLCM(:,:,i),'contrast').Contrast*100;
                end

                if isnan(graycoprops(variasGLCM(:,:,i),'correlation').Correlation)
                    if i == 1
                        valores(2,i) = 0;
                    else
                        valores(2,i) = valores(2,i-1);
                    end
                else
                    valores(2,i) = graycoprops(variasGLCM(:,:,i),'correlation').Correlation*100;
                end

                if isnan(graycoprops(variasGLCM(:,:,i),'energy').Energy)
                    valores(3,i) = valores(3,i-1);
                else
                    valores(3,i) = graycoprops(variasGLCM(:,:,i),'energy').Energy*100;
                end
            end

    %         figure(5)
    %         grid on;
    %         hold on;
    %         for i=1:h-1
    %                 plot3(entropias(1,i), valores(2,i), valores(3,i), '.', 'MarkerSize',15, 'Color', color);
    %     %             plot(valores(3,i), valores(2,i), '.', 'MarkerSize',15, 'Color', color);
    %         end
    %         xlabel('Atributo 1')
    %         ylabel('Atributo 2')

            centroides(1,cent) = mean(entropias(1,1:h-1));
            centroides(2,cent) = mean(valores(2,1:h-1));
            centroides(3,cent) = mean(valores(3,1:h-1));
            centroides(4,cent) = tipo;

            ciclos = ciclos + 1;
            cent = cent + 1;
        end
        muestras = muestras + 1;
    end
    tipoPM = tipoPM + 1;
end
    
b = centroides > 0;
c = find(b == 1);
nuevosCentroides = zeros(4,fix(length(c)/4));
for i = 1:length(c)/4
    nuevosCentroides(:,i) = centroides(:,i);
end
cielos = find(nuevosCentroides(4,:) == 1);
montanias = find(nuevosCentroides(4,:) == 2);
praderas = find(nuevosCentroides(4,:) == 3);

centroidesPorImagen(1,1) = mean(nuevosCentroides(1,cielos));
centroidesPorImagen(2,1) = mean(nuevosCentroides(2,cielos));
centroidesPorImagen(3,1) = mean(nuevosCentroides(3,cielos));

centroidesPorImagen(1,2) = mean(nuevosCentroides(1,montanias));
centroidesPorImagen(2,2) = mean(nuevosCentroides(2,montanias));
centroidesPorImagen(3,2) = mean(nuevosCentroides(3,montanias));

centroidesPorImagen(1,3) = mean(nuevosCentroides(1,praderas));
centroidesPorImagen(2,3) = mean(nuevosCentroides(2,praderas));
centroidesPorImagen(3,3) = mean(nuevosCentroides(3,praderas));

%Parte de clasificaion
 
while true
    fprintf("Ingrese el numero de la imagen que desea: (1/34, 64/92)\n")
    num = input("");
    if num < 10
        aux = strcat('paisajes/IMG0',string(num),'.jpg');
    else
        aux = strcat('paisajes/IMG',string(num),'.jpg');
    end
    imgAux=imread(aux);
    [rows, columns] = size(imgAux);
    imgGris = rgb2gray(imgAux);
    [L,N] = superpixels(imgGris, 50);
    filas = fix(rows/tamanio);
    columnas = fix((columns/3)/tamanio);
    numeroDeCrops = filas*columnas;
    valores = zeros(3,N);
    entropias = zeros(3,N);
    h = 1;
    for partesDelSup = 1:N
        parte = L == partesDelSup;
        nuevoGris = imgGris;
        for i = 1:(rows)
            for j =1:(columns/3 )
                nuevoGris(i,j) = fix(parte(i,j)) * fix(imgGris(i,j));
            end
        end
        r = 1;
        rAnterior = r;
        for i=0:columnas-1
                for j=0:filas-1
                    if h ~= numeroDeCrops
                        cropImg = imcrop(nuevoGris,[i*tamanio,j*tamanio,tamanio,tamanio]);
                        b = cropImg > 0;
                        if length(find(b == 0)) > 10
                        else
                            glcms = graycomatrix(cropImg);
                            variasGLCM(:,:,h) = glcms;
                            entropias(1,h) = entropy(cropImg);
                            
                            glcms = graycomatrix(cropImg);
                            variasGLCM(:,:,h) = glcms;
                            if isnan(graycoprops(variasGLCM(:,:,h),'correlation').Correlation)
                                if h == 1
                                    valores(2,h) = 0;
                                else
                                    valores(2,h) = valores(2,h-1);
                                end
                            else
                                valores(2,h) = graycoprops(variasGLCM(:,:,h),'correlation').Correlation*100;
                            end

                            if isnan(graycoprops(variasGLCM(:,:,h),'energy').Energy)
                                valores(3,h) = valores(3,h-1);
                            else
                                valores(3,h) = graycoprops(variasGLCM(:,:,h),'energy').Energy*100;
                            end

                            h = h + 1;
                            r = r + 1;
                            break;
                        end
                    end
                    if r ~= rAnterior
                        break;
                    end
                end
                if r ~= rAnterior
                    break;
                end
        end
    end
    figure(6)
    clf;
    hold on;
    grid on;
    plot3(centroidesPorImagen(1, 1), centroidesPorImagen(2,1), centroidesPorImagen(3,1), '.', 'MarkerSize',15, 'Color', 'b');
    plot3(centroidesPorImagen(1, 2), centroidesPorImagen(2,2), centroidesPorImagen(3,2), '.', 'MarkerSize',15, 'Color', 'k');
    plot3(centroidesPorImagen(1, 3), centroidesPorImagen(2,3), centroidesPorImagen(3,3), '.', 'MarkerSize',15, 'Color', 'g');

    plot3(nuevosCentroides(1, cielos), nuevosCentroides(2,cielos), nuevosCentroides(3,cielos), '+', 'MarkerSize',15, 'Color', 'b');
    plot3(nuevosCentroides(1, montanias), nuevosCentroides(2,montanias), nuevosCentroides(3,montanias), '+', 'MarkerSize',15,  'Color', 'k');
    plot3(nuevosCentroides(1, praderas), nuevosCentroides(2,praderas), nuevosCentroides(3,praderas), '+', 'MarkerSize',15, 'Color', 'g');
    
    caracteristicas = entropias + valores;
    plot3(caracteristicas(1, :), caracteristicas(2,:), caracteristicas(3,:), '.', 'MarkerSize',15, 'Color', 'r');
    tipos = zeros(1,N);
    for i=1:N
        tipos(i) = clasificador_Distancias(caracteristicas(i), centroidesPorImagen, 3);%1 es cielo 2 montania 3 pradera
%         tipos(i) = clasificador_Bayes(caracteristicas(i), nuevosCentroides, 3, centroidesPorImagen, N, 3, cielos, montanias, praderas);
    end
    cielo = length(find(tipos == 1));
    montanias = length(find(tipos == 2));
    praderas = length(find(tipos == 3));
    figure(1)
    BW = boundarymask(L); 
    imshow(imoverlay(imgAux,BW,'cyan'),'InitialMagnification',67);
    if(montanias > praderas)
        fprintf("Es una montania\n");
    else
        fprintf("Es una pradera\n");
    end
    fprintf("Desea identificar otra imagen?\n1) Si\n2) No\n");
    opcion = input("");
    if isequal(opcion, 2)
        break;
    end
end
disp('Fin de proceso...')