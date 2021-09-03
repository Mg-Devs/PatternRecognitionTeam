function clase = clasificador_Distancias(vecDesc, medias,numClases)
    distancias=zeros(numClases,1);
    for aux=1:numClases
        distancias(aux,1)=norm(vecDesc-medias(:,aux));
    end
    minimo=min(distancias);
    
    if minimo < 50
        clase=find(distancias==minimo);
    else
        clase = -1;
    end
end