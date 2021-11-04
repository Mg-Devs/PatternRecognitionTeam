%PruebaToken
%Equipo 8
%Parcial 2
%Ejercicio AlgCadena Visto en Clase
clc
clear all
close all
warning off all
%          x1 2 3 4 5 6 7 8 9 10
muestras=[0.5 3 2 1 5 4 6 5 6 7;
          0.5 8 2 1 3 8 3 4 4 5];
numMuestras=10;
umbral=15;
figure(1)
grid on
plot(muestras(1,:),muestras(2,:),'.r','MarkerSize',20);

[gruposF,numElementos]=algCadena(muestras,numMuestras,umbral)

figure(2)
grid on
hold on
[f,c]=size(numElementos);
for aux=1:c
    color=rand(1,3);
    cstr=strcat('Clase',{' '},string(aux));
    for aux2=1:numElementos(aux)
        x(aux2)=gruposF(1,aux2,aux);
        y(aux2)=gruposF(2,aux2,aux);
        %plot(gruposF(1,aux2,aux),gruposF(2,aux2,aux),'.','MarkerSize',15,'DisplayName',cstr,'color',color)
    end
    plot(x,y,'.','MarkerSize',15,'DisplayName',cstr,'color',color)
    clear x
    clear y
end
xlabel('Atributo 1')
ylabel('Atributo 2')
legend

disp('fin de proceso...')