function [copiaClases] = reordenarRepresentantes(clases, numClases, numRepresentantes)
    if(numRepresentantes>10)
        valorDeSeparacion = randi(10, 1, 1);
    else
        valorDeSeparacion = randi(numRepresentantes,1,1);
    end
    copiaClases = clases;
    for i = 1:numClases
        for j = 1:numRepresentantes-valorDeSeparacion
            aux = copiaClases(:,j,i);
            copiaClases(:,j,i) = copiaClases(:, j+valorDeSeparacion, i);
            copiaClases(:,j+valorDeSeparacion,i) = aux;
        end
    end
end

