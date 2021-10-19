function clase = clasificador_KNN(clases,numClases,numRepresentantes,n_vecinos,vecDesc)
    distancias=zeros(1,numRepresentantes,numClases);

    for aux=1:numClases
        distancias(:,:,aux)=vecnorm(vecDesc-clases(:,:,aux));
    end

    dmins = sort(distancias);

    mins = dmins(:,1:n_vecinos,1);
    rclases = ones(1,n_vecinos);

    for aux=1:n_vecinos
        for aux2=2:numClases
            for aux3=1:numRepresentantes
                if dmins(1,aux3,aux2)< mins(1,aux)
                    mins(1,aux) = dmins(1,aux3,aux2);
                    rclases(1,aux) = aux2;
                    dmins(1,aux3,aux2) = NaN;
                end
            end
        end
    end
    
    display(mins);
    rclases(mins>50)=-1;
    display(rclases);
    
    clase=mode(rclases,2);
end