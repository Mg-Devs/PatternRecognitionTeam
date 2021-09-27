function clase = clasificador_Mahalanobis(vecDesc,clases,medias,numClases,numRepresentantes)
    distancias=zeros(numClases,1);
    for aux=1:numClases
        resta=clases(:,:,aux)-medias(:,aux);
        varianzaAux=(1/numRepresentantes)*((resta)*(resta'));
        resta2=vecDesc(:,:)-medias(:,aux);
        distanciaAux=resta2'*(inv(varianzaAux))*resta2;
        distancias(aux,1)=distanciaAux;
    end
    disp(distancias);
    minimo=min(distancias)
    
    if minimo < 500
        clase=find(distancias==minimo);
    else
        clase = -1;
    end
end