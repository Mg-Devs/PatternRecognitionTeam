function [clusters, medias] = kmeans(kMedias, numMuestras, muestras)
    centroides = zeros(3,kMedias);
    medias = zeros(2,kMedias);
    clusters = zeros(6, numMuestras);
    for i = 1:kMedias
       centroides(:,i)=muestras(3:5,randi([1 numMuestras]));
    end
    clusters(1:5,:) = muestras;
    maxIteraciones = 200;  
    numIteraciones = 1;
    figure(16);
    clf
    grid on;
    hold on;
    plot3(muestras(3,:), muestras(4,:), muestras(5,:), '.','MarkerSize',10,'color','k');
    while(true)
        centroidesAux = centroides;
        for i = 1:numMuestras
            clusters(6,i) = detCluster(clusters(3:5,i), centroides, kMedias);
        end
        centroides = calcCentroides(clusters, kMedias, numMuestras);
        if(centroidesAux == centroides) | (numIteraciones == maxIteraciones)
            break;
        end
        numIteraciones = numIteraciones + 1;
    end    
    disp('Numero de iteraciones: ')
    disp(numIteraciones)
    color=rand(1,3);
    cstr=strcat('Iteracion',{' '},string(numIteraciones));
    plot3(centroides(1,:), centroides(2,:), centroides(3,:), '+','MarkerSize',10,'color',color, 'DisplayName', cstr);
    for i = 1:kMedias
        c = find(clusters(6,:) == i);
        medias(:,i) = mean(clusters(1:2, c),2);
    end
    legend
end