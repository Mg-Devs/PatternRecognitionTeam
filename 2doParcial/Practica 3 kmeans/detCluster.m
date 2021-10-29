function clase = detCluster(vecDesc, centroides, numClases)
    distancias=zeros(numClases,1);
    for aux=1:numClases
        distancias(aux,1)=norm(vecDesc-centroides(:,aux));
    end
    minimo=min(distancias);
    
    clase=find(distancias==minimo);
end