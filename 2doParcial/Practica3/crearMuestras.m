function [muestras] = crearMuestras(numMuestras, n, m)
    muestras = zeros(2,numMuestras);
    
    %----Puntos Aleatorios----
    %for i = 1: numRepresentantes
    %    muestras(1,i)= randi([0 n]);
    %    muestras(2,i)= randi([0 m]);
    %end
    muestras(1,:)=randi([0,n],1,numMuestras);
    muestras(2,:)=randi([0,m],1,numMuestras);
    
 %   for i = 1: numClases
 %       medias(1,i) = mean(clases(1,:,i));
 %       medias(2,i) = mean(clases(2,:,i));
 %   end
    
end