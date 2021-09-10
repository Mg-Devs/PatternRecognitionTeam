function [clases, medias] = crearClasesYMedias(numClases,numRepresentantes,centroides,dispersiones)
    clases=zeros(2,numRepresentantes,numClases);
    medias=zeros(2,numClases);
    cAux=zeros(2,numRepresentantes);
    for aux=1:numClases
        %cAux=(randn(2,numRepresentantes)+centroides(aux,1))*disperciones(aux,1);
        %cAux=randn(2,numRepresentantes);
        %cAux(1,:)=(cAux(1,:)+centroides(aux,1))*disperciones(aux,1);
        %cAux(2,:)=cAux(2,:)+centroides(aux,2)*disperciones(aux,1);
        cxAux=(randn(1,numRepresentantes)+centroides(1,aux))*dispersiones(aux,1);
        cyAux=(randn(1,numRepresentantes)+centroides(2,aux))*dispersiones(aux,1);
        cAux(1,:)=cxAux;
        cAux(2,:)=cyAux;
        clases(:,:,aux)=cAux;
        medias(:,aux)=mean(clases(:,:,aux),2);
    end
end