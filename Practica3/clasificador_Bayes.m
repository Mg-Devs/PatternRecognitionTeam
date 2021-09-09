function clase = clasificador_Bayes(vecDesc,clases,numClases,medias,numRepresentantes,numDimensiones)
    probabilidades=zeros(numClases,1);
    for aux=1:numClases    
        restaVarAux=clases(:,:,aux)-medias(:,aux);
        varianzaAux=(1/numRepresentantes)*(restaVarAux*(restaVarAux'));
        restaVMAux=vecDesc-medias(:,aux);
        a=(-0.5)*(restaVMAux')*inv(varianzaAux)*restaVMAux;
        b=(1/power(2*pi,numDimensiones/2))*(1/power(det(varianzaAux),0.5));
        probAux=b*exp(a);   
        probabilidades(aux,1)=probAux;
    end
    fprintf('Probabilidades sin normalizar\n');
    disp(probabilidades);
    sumaProb=sum(probabilidades(:,1));
    probNormalizadas=zeros(numClases,1);
    for aux=1:numClases
       probNormalizadas(aux,1)=(probabilidades(aux,1)/sumaProb)*100;
    end

    disp(probNormalizadas)
    fprintf('Suma de las probabilidades normalizadas: %d. \n',sum(probNormalizadas))

    umbral = max(probabilidades);
    maximo=max(probNormalizadas);
    
    if umbral < 1e-50
        clase = -1;
    else
        clase=find(probNormalizadas==maximo);
    end
end