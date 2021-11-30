function [clusters, medias] = kmeans(kMedias, numMuestras, muestras)
    centroides = zeros(2,kMedias);
    medias = zeros(2,kMedias);
    clusters = zeros(3, numMuestras);
%     for i = 1:kMedias
%        centroides(1,i)=randi([0 2]);
%        centroides(2,i)=randi([50 250]);
%     end
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
        numIteraciones = numIteraciones + 1;
        if(isequal(centroidesAux,centroides) || isequal(numIteraciones,maxIteraciones))
            break;
        end
    end  
    
    for i = 1:kMedias
        c = find(clusters(3,:) == i);
        medias(:,i) = mean(clusters(1:2, c),2);
    end
end