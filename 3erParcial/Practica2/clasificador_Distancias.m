function clase = clasificador_Distancias(vecDesc, medias,numClases)
    distancias=zeros(numClases,1);
    for aux=1:numClases
        distancias(aux,1)=norm(vecDesc-medias(:,aux));
    end
    disp(distancias);
    minimo=min(distancias);
    clase=find(distancias==minimo);
end