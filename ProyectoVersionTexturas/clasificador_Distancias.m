function clase = clasificador_Distancias(vecDesc, medias,numClases)
    distancias=zeros(numClases,1);
    for aux=1:numClases
        distancias(aux,1)=norm(vecDesc-[medias(1,aux), medias(2,aux)]);
    end
    disp(distancias);
    minimo=min(distancias);
    clase=find(distancias==minimo);
end