%Tercer Parcial
%Práctica 2
%Equipo 8

clc 
clear all
close all
warning off all
%1 5  9 10 11 
inicio=11;
fin=11;
for aux=inicio:fin
    imgAux=leerImagen(aux);
    fprintf('Mostrando Imagen %d: \n',aux);
    figure(aux)
    imshow(imgAux);
    objetos=regionprops(imgAux,'Perimeter','Area','Centroid','BoundingBox');
    for k=1:length(objetos)
        caja=objetos(k).BoundingBox;
        perimetro=objetos(k).Perimeter;
        area=objetos(k).Area;
        circularidad=(4*area*pi)/(perimetro^2);
        fprintf('Objeto %d:\n',k)
        fprintf('\tCentroide=(%d,%d)\n',objetos(k).Centroid(1),objetos(k).Centroid(2))
        fprintf('\tArea=%d\n',area);
        fprintf('\tPerimetro=%d\n',perimetro);
        fprintf('\tCircularidad=%d\n',circularidad);
    
%         if(area>10000)
%             rectangle('Position',[caja(1),caja(2),caja(3),caja(4)],'EdgeColor','b','LineWidth',2);
%         else
%             rectangle('Position',[caja(1),caja(2),caja(3),caja(4)],'EdgeColor','r','LineWidth',2);
%         end
%         
%         
%         if(perimetro^2/objetos(k).Area>18)
%             text(objetos(k).Centroid(1),objetos(k).Centroid(2),'TRIANGULO','Color','r');
%         elseif(perimetro^2/objetos(k).Area<14.3)
%             text(objetos(k).Centroid(1),objetos(k).Centroid(2),'CIRCULO','Color','g');
%         else
%             text(objetos(k).Centroid(1),objetos(k).Centroid(2),'CUADRADO','Color','y');
%         end
    end    
end
disp('Fin de proceso...')
