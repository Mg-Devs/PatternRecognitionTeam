%Practica 5 Main
%Equipo 8

clc
clear all
close all
warning off all

repetir = 1;

while true
    fprintf('¿Qué inciso deseas ejecutar?\n');
    fprintf('\t1) Compuerta AND\n');
    fprintf('\t2) CUBO\n'); 
    inciso = input('Elige un número: ');
    
    switch inciso
        case 1
            repetir=practica5a();
        case 2
            repetir=practica5b();
        otherwise
            fprintf('Error, elije un inciso válido.\n')
    
    end
    if repetir ~= 1
        break;
    end 
end

disp('-----Fin de proceso-----')