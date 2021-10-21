function y = calcularMedias(grupos, numGrupos,contadores)
    y=zeros(2, numGrupos);
    for aux=1:numGrupos
        if contadores(aux)==1
            y(:,aux)=grupos(:,1,aux);
        else
            y(:,aux)=mean(grupos(:,:,aux),2);
        end
    end
end
