%Tercer Parcial
%Práctica 2
%Equipo 8

clc 
clear all
close all
warning off all

inicio=1;
fin=114;

for aux=inicio:fin
    imgAux=leerImagen(aux);
    fprintf('Mostrando Imagen %d: \n',aux);
    
end
disp('Fin de proceso...')