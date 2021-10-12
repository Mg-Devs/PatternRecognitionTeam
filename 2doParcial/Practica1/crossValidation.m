function [crossValidation,promedio] = crossValidation(clasificador,clases,medias,numClases,numRepresentantes, valoresDePrueba,n_vecinos)
    mc=zeros(numClases,numClases);
    vecDesc=zeros(2,1);
    for i=1:numClases
        for j=1:numRepresentantes
            vecDesc=valoresDePrueba(:,j,i);
            switch clasificador
                case 1 %Distancias
                    clase=clasificador_Distancias(vecDesc, medias,numClases);
                    mc(i,clase)=mc(i,clase)+1;
                case 2 %Bayes
                    clase=clasificador_Bayes(vecDesc,clases,numClases,medias,numRepresentantes,size(clases,1));
                    mc(i,clase)=mc(i,clase)+1;
                case 3 %Mahalanobis
                    clase=clasificador_Mahalanobis(vecDesc,clases,medias,numClases,numRepresentantes);
                    mc(i,clase)=mc(i,clase)+1;
                case 4 %KNN
                    clase=clasificador_KNN(clases,numClases,numRepresentantes,n_vecinos,vecDesc);
                    mc(i,clase)=mc(i,clase)+1;
            end
        end
    end
    disp(mc);
    promedio=0;
    for i=1:numClases
        crossValidation(i,i)=(mc(i,i)/numRepresentantes)*100;
        promedio=promedio+crossValidation(i,i);
    end
    promedio=promedio/numClases;
    %mConfusion=mc;
end