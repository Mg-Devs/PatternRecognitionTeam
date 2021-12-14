function [clusters, medias] = kmeans(kMedias, numMuestras, muestras)
    centroides = zeros(3,kMedias);
    medias = zeros(3,kMedias);
    clusters = zeros(4, numMuestras);
%     for i = 1:kMedias
%        centroides(1,i)=randi([0 2]);
%        centroides(2,i)=randi([50 250]);
%     end
    for i = 1:kMedias
       centroides(:,i)=muestras(:,randi([1 numMuestras]));
    end
    clusters(1:3,:) = muestras;
    maxIteraciones = 200;  
    numIteraciones = 1;
    while(true)
        centroidesAux = centroides;
        for i = 1:numMuestras
            clusters(4,i) = detCluster(clusters(1:3,i), centroides, kMedias);
        end
        centroides = calcCentroides(clusters, kMedias, numMuestras);
        numIteraciones = numIteraciones + 1;
        if(isequal(centroidesAux,centroides) || isequal(numIteraciones,maxIteraciones))
            break;
        end
    end  
    
    for i = 1:kMedias
        c = find(clusters(4,:) == i);
        medias(:,i) = mean(clusters(1:3, c),2);
    end
end