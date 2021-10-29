function centroides = calcCentroides(clusters, kMedias, numMuestras)
    centroides = zeros(3, kMedias);
    for i = 1:kMedias
        n=1;
        for j = 1:numMuestras
            if(clusters(6,j) == i)
                centroides(:, i) = centroides(:, i) + clusters(3:5, j);
                n = n + 1;
            end
        end
        centroides(:,i) = centroides(:,i)/n;
    end
end