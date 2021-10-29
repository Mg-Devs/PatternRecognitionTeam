function bandera=compararCentroideMuestras(centroides,muestra,n)
    bandera=1; %Se puede agregar como nuevo centroide la muestra
    for i=1:n
        if muestra==centroides(:,i)
            bandera=0;
            break
        end
    end
end