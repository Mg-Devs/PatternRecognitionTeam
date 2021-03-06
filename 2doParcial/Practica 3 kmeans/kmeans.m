function [clusters, centroides] = kmeans(kMedias, numMuestras, muestras)
    centroides = zeros(2,kMedias);
    clusters = zeros(3, numMuestras);
    for i = 1:kMedias
       centroides(:,i)=muestras(:,randi([1 numMuestras]));
    end
    clusters(1:2,:) = muestras;
    maxIteraciones = 200;  
    numIteraciones = 1;
    while(true)
        centroidesAux = centroides;
        for i = 1:numMuestras
            clusters(3,i) = detCluster(clusters(1:2,i), centroides, kMedias);
        end
        centroides = calcCentroides(clusters, kMedias, numMuestras);
        if(centroidesAux == centroides) | (numIteraciones == maxIteraciones)
            break;
        end
        numIteraciones = numIteraciones + 1;
    end    
end