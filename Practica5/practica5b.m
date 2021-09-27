%Practica 5a 
%Equipo 8

clc
clear all
close all
warning off all

C1 = [1 0 1 1;
      0 0 0 1;
      1 0 0 0];
  
C2 = [0 0 1 0;
      0 1 1 1;
      1 1 1 0];
  
w = zeros(1,4);
r = 0;
        
for aux=1:4
    fprintf('Escribe el peso w%d: ',aux);
    w(aux)=input('');
end
r = input('Ingresa el coeficiende te aprendizaje r: ');

display("Valores Iniciales de W:");
display(w);

iteration = 1;
while 1
    wAux = w;
    for aux=1:4
        Xn = C1(:,aux).';
        Xn(4) = 1;
        fsal = Xn*w.';
        if(fsal >= 0)
            w = w - r*Xn;
        end
        
        Xn = C2(:,aux).';
        Xn(4) = 1;
        fsal = Xn*w.';
        if(fsal <= 0)
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

fprintf('fsal = %.2f x1 + %.2f x2 + %.2f x3 %.2f\n',w(1),w(2),w(3),w(4));

figure(1)
grid on
hold on


plot3(C1(1,:),C1(2,:),C1(3,:),'.','MarkerSize',15,'DisplayName','Clase 1','color','r');
plot3(C2(1,:),C2(2,:),C2(3,:),'+','MarkerSize',12,'DisplayName','Clase 2','color','r');

z = @(x,y) (-w(1)*x - w(2)*y - w(4))/w(3);
fs = fsurf(z,[0 1 0 1]);
fs.FaceColor = 'cyan';
fs.FaceAlpha = .1;
fs.DisplayName='Plano';


xlabel('Eje X')
ylabel('Ejey Y')
zlabel('Ejey Z')
title('Gráfica de datos')
legend
