function centroides = calcCentroides(clusters, kMedias, numMuestras)
    centroides = zeros(3, kMedias);
    for i = 1:kMedias
        n=1;
        for j = 1:numMuestras
            if isequal(clusters(4,j), i)
                centroides(:, i) = centroides(:, i) + clusters(1:3, j);
                n = n + 1;
            end
        end
        centroides(:,i) = centroides(:,i)/n;
    end
end