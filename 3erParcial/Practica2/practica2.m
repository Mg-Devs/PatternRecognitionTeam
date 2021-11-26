%Tercer Parcial
%Práctica 2
%Equipo 8
clc 
clear all
close all
warning off all
%1 5  9 10 11 %45

inicio=78;
fin=80;
for aux=inicio:fin
    imgAux=leerImagen(aux);
    %fprintf('Mostrando Imagen %d: \n',aux);
    figure(aux)
    imshow(imgAux);
    contadores=zeros(1,5); %Tornillos, Rondanas, Armellas, Llaves Allen, No se cómo se llama
    objetos=regionprops(imgAux,'Perimeter','Area','Centroid','BoundingBox');
    for k=1:length(objetos)
        caja=objetos(k).BoundingBox;
        perimetro=objetos(k).Perimeter;
        area=objetos(k).Area;
        circularidad=(4*area*pi)/(perimetro^2);
        if (area>50)
            if(area>320 && area<425 && perimetro>100 && perimetro<130) %Tornillos
                rectangle('Position',[caja(1),caja(2),caja(3),caja(4)],'EdgeColor','c','LineWidth',2);
                text(objetos(k).Centroid(1),objetos(k).Centroid(2),'Tornillo','Color','c');
                contadores(1)=contadores(1)+1;
%                 fprintf('TORNILLO.\n')
%                 fprintf('Objeto %d: \n',k)
%                 fprintf('\tCentroide=(%d,%d)\n',objetos(k).Centroid(1),objetos(k).Centroid(2))
%                 fprintf('\tArea=%d\n',area);
%                 fprintf('\tPerimetro=%d\n',perimetro);
%                 fprintf('\tCircularidad=%d\n',circularidad);
            elseif(area>611 && area<730 || perimetro>85 && perimetro<100 && circularidad>0.90 && circularidad<1.1) %Rondanas
                rectangle('Position',[caja(1),caja(2),caja(3),caja(4)],'EdgeColor','g','LineWidth',2);
                text(objetos(k).Centroid(1),objetos(k).Centroid(2),'Rondana','Color','g');
                contadores(2)=contadores(2)+1;
%                 fprintf('Rondana.\n')
%                 fprintf('Objeto %d: \n',k)
%                 fprintf('\tCentroide=(%d,%d)\n',objetos(k).Centroid(1),objetos(k).Centroid(2))
%                 fprintf('\tArea=%d\n',area);
%                 fprintf('\tPerimetro=%d\n',perimetro);
%                 fprintf('\tCircularidad=%d\n',circularidad);
            elseif(area>471 && area<610 && perimetro>150 && perimetro<250) %Armellas
                rectangle('Position',[caja(1),caja(2),caja(3),caja(4)],'EdgeColor','r','LineWidth',2);
                text(objetos(k).Centroid(1),objetos(k).Centroid(2),'Armella','Color','r');
                contadores(3)=contadores(3)+1;
%                 fprintf('Armella.\n')
%                 fprintf('Objeto %d: \n',k)
%                 fprintf('\tCentroide=(%d,%d)\n',objetos(k).Centroid(1),objetos(k).Centroid(2))
%                 fprintf('\tArea=%d\n',area);
%                 fprintf('\tPerimetro=%d\n',perimetro);
%                 fprintf('\tCircularidad=%d\n',circularidad);
            elseif(area>400 && area<470 && perimetro>200 && perimetro<250) %Llaves Allen
                rectangle('Position',[caja(1),caja(2),caja(3),caja(4)],'EdgeColor','m','LineWidth',2);
                text(objetos(k).Centroid(1),objetos(k).Centroid(2),'Llaves Allen','Color','m');
%                 fprintf('Llaves Allen.\n')
%                 fprintf('Objeto %d: \n',k)
%                 fprintf('\tCentroide=(%d,%d)\n',objetos(k).Centroid(1),objetos(k).Centroid(2))
%                 fprintf('\tArea=%d\n',area);
%                 fprintf('\tPerimetro=%d\n',perimetro);
%                 fprintf('\tCircularidad=%d\n',circularidad);
                contadores(4)=contadores(4)+1;
            else 
                rectangle('Position',[caja(1),caja(2),caja(3),caja(4)],'EdgeColor','y','LineWidth',2);
                text(objetos(k).Centroid(1),objetos(k).Centroid(2),'Otro','Color','y');
                contadores(5)=contadores(5)+1;
%                 fprintf('OTRO.\n')
%                 fprintf('Objeto %d: \n',k)
%                 fprintf('\tCentroide=(%d,%d)\n',objetos(k).Centroid(1),objetos(k).Centroid(2))
%                 fprintf('\tArea=%d\n',area);
%                 fprintf('\tPerimetro=%d\n',perimetro);
%                 fprintf('\tCircularidad=%d\n',circularidad);
            end 
        end
    end
    fprintf('Imagen: %d\n',aux);
    fprintf('El número total de figuras es: %d\n',sum(contadores));
    fprintf('\tTornillos: %d\n',contadores(1));
    fprintf('\tRondanas: %d\n',contadores(2));
    fprintf('\tArmellas: %d\n',contadores(3));
    fprintf('\tLlaves Allen: %d\n',contadores(4));
    fprintf('\tOtro: %d\n',contadores(5));
    clear contadores;
end
disp('Fin de proceso...')
