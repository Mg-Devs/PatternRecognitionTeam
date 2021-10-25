function nuevosCentroides=calcularCentroides(gruposRGB,numMiembros,k)
     nuevosCentroides=zeros(3,k);
     for i=1:k
         if numMiembros(i)~=0
             suma=zeros(3,1);
             for j=1:numMiembros(i)
                 suma(:,1)=suma(:,1)+gruposRGB(:,j,i);
             end
             %nuevosCentroides()=muestras
             nuevosCentroides(:,i)=suma/numMiembros(1,i);
             clear suma
         end
     end
end