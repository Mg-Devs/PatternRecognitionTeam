%Equipo 8
%Práctica 5a
function repetir=practica5a()

    AND_GATE = [0 0 0;
                0 1 0;
                1 0 0;
                1 1 1];
    w = zeros(1,3);
    r = 0;

    for aux=1:3
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

    fprintf('fsal = %.2f x1 + %.2f x2 %.2f\n',w(1),w(2),w(3));

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

    fprintf('¿Deseas repetir el procedimiento?\n');
    fprintf('\t1) Si\n');
    fprintf('\t2) No\n');
    repetir = input('Elige un número: ');
    if repetir==1
        clf;
    end 
end