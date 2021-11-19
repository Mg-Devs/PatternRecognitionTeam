clc 
clear all
close all
warning off all

%Triangulo, circulo, cuadrado
shapes =zeros(1,3);

%Programa para identificar y reconocer objetos geométricos dento de una 
%imagen Binaria

figure(1)
%---- Leer imagen
a = imread('ImagenPrueba\004-ImagenPrueba.bmp');

%---- Imágen bidimensional
c=im2bw(a);
imshow(c);

%Analizando las propiedades geométricas de la figura
objetos = regionprops(c,'Perimeter','Area','Centroid','BoundingBox');

for i = 1:length(objetos)
    caja = objetos(i).BoundingBox;
    
    if(objetos(i).Area>10000)    
        rectangle('Position',[caja(1),caja(2),caja(3),caja(4)],'EdgeColor','b','LIneWidth',2);
    else
        rectangle('Position',[caja(1),caja(2),caja(3),caja(4)],'EdgeColor','r','LIneWidth',2);
    end
    
    if(objetos(i).Perimeter^2/objetos(i).Area>18)
        text(objetos(i).Centroid(1),objetos(i).Centroid(2),'TRIANGULO','Color','r');
        shapes(1) = shapes(1)+1;
    elseif(objetos(i).Perimeter^2/objetos(i).Area<14.3)
        text(objetos(i).Centroid(1),objetos(i).Centroid(2),'CIRCULO','Color','g');
        shapes(2) = shapes(2)+1;
    else
        text(objetos(i).Centroid(1),objetos(i).Centroid(2),'CUADRADO','Color','b');
        shapes(3) = shapes(3)+1;
    end
    
end

fprintf('El número total de figuras es: %d\n',sum(shapes));
fprintf('Triangulos: %d\n',shapes(1));
fprintf('Circulos: %d\n',shapes(2));
fprintf('Cuadrados: %d\n',shapes(3));

disp('Fin de proceso...')