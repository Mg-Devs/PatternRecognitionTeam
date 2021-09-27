%Practica 5a 
%Equipo 8

clc
clear all
close all
warning off all

AND_GATE = [0 0 0;
            0 1 0;
            1 0 0;
            1 1 1]
        
w = [1 1 1];
r = 1;

display("Valores Iniciales de W:");
display(w);

iteration = 1;
while iteration < 20
    wAux = w;
    for aux=1:4
        Xn = [AND_GATE(aux,1) AND_GATE(aux,2) 1];
        fsal = Xn*w.';
        if(fsal >= 0 && AND_GATE(aux,3) == 0)
            w = w - r*Xn;
        end
        if(fsal <= 0 && AND_GATE(aux,3) == 1)
            w = w + r*Xn;
        end
    end
    
    if(~isequal(w,wAux))
        fprintf('Iteracion %d: \n',iteration);
        display(w.');
    else
        break;
    end
    iteration = iteration + 1;
end

fprintf('fsal = %d x + %d x %d\n',w(1),w(2),w(3));

figure(1)
grid on
hold on


plot(AND_GATE(1:3,1),AND_GATE(1:3,2),'.','MarkerSize',15,'DisplayName','Clase 1','color','r')
plot(AND_GATE(4,1),AND_GATE(4,2),'+','MarkerSize',12,'DisplayName','Clase 2','color','r')
plot([-w(3)/w(1) 0],[0 -w(3)/w(2)])


xlabel('Eje X')
ylabel('Ejey Y')
title('Gráfica de datos')
legend
