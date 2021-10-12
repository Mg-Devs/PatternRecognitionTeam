function [mConfusion,promedio] = holdOne(clasificador,clases,medias,numClases,numRepresentantes,n_vecinos)
    mc=zeros(numClases,numClases);
    vecDesc=zeros(2,1);
    
    for i=1:numClases
        for j=1:numRepresentantes
            vecDesc=clases(:,j,i);
            auxClases = clases;
            auxClases(:,j,:) = [];
            switch clasificador
                case 1 %Distancias
                    clase=clasificador_Distancias(vecDesc, medias,numClases);
                    mc(i,clase)=mc(i,clase)+1;
                case 2 %Bayes
                    clase=clasificador_Bayes(vecDesc,auxClases,numClases,medias,numRepresentantes-1,size(auxClases,1));
                    mc(i,clase)=mc(i,clase)+1;
                case 3 %Mahalanobis
                    clase=clasificador_Mahalanobis(vecDesc,auxClases,medias,numClases,numRepresentantes-1);
                    mc(i,clase)=mc(i,clase)+1;
                case 4 %KNN
                    clase=clasificador_KNN(auxClases,numClases,numRepresentantes-1,n_vecinos,vecDesc);
                    mc(i,clase)=mc(i,clase)+1;
            end
        end
    end
    disp(mc);
    promedio=0;
    for i=1:numClases
        mConfusion(i,i)=(mc(i,i)/numRepresentantes)*100;
        promedio=promedio+mConfusion(i,i);
    end
    promedio=promedio/numClases;
    %mConfusion=mc;
end

