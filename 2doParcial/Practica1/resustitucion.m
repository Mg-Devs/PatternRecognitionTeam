function [mConfusion,promedio] = resustitucion(clasificador,clases,medias,numClases,numRepresentantes)
    mc=zeros(numClases,numClases);
    vecDesc=zeros(2,1);
    if clasificador==4
        n_vecinos=input('Ingresa el numero de vecinos para el clasificador KNN (Debe ser impar): ');
    end
    for i=1:numClases
        for j=1:numRepresentantes
            vecDesc=clases(:,j,i);
            switch clasificador
                case 1 %Distancias
                    fprintf('Clasificador Distancia Euclidiana\n');
                    clase=clasificador_Distancias(vecDesc, medias,numClases);
                    mc(i,clase)=mc(i,clase)+1;
                case 2 %Bayes
                    fprintf('Clasificador Bayes\n');
                    clase=clasificador_Bayes(vecDesc,clases,numClases,medias,numRepresentantes,size(clases,1));
                    mc(i,clase)=mc(i,clase)+1;
                case 3 %Mahalanobis
                    fprintf('Clasificador Mahalanobis\n');
                    clase=clasificador_Mahalanobis(vecDesc,clases,medias,numClases,numRepresentantes);
                    mc(i,clase)=mc(i,clase)+1;
                case 4 %KNN
                    fprintf('Clasificador KNN\n');
                    clase=clasificador_KNN(clases,numClases,numRepresentantes,n_vecinos,vecDesc);
                    mc(i,clase)=mc(i,clase)+1;
                otherwise
                    fprintf('Error, elige un clasificador válido.\n');
                    break;
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