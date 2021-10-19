function [clases, medias] = crearClases(numClases,numRepresentantes)
    %Rangos
    rangosPrueba=zeros(2,2,numClases); %(Rango en X, Rango en Y, Clase a la que pertenece)
    rangosPrueba(:,:,1)=[0 900; 0 100];     %Cielo
    rangosPrueba(:,:,2)=[620 810; 190 290]; %Roca
    rangosPrueba(:,:,3)=[0 900; 290 599];   %Arena
    rangosPrueba(:,:,4)=[0 600; 110 200];   %Montaña
    
    clases = zeros(2,100,4);
    medias=zeros(2,numClases);
    
    %----Puntos Aleatorios----
    for i = 1: numRepresentantes
        %Cielo
        clases(1,i,1) = randi(rangosPrueba(1,:,1)); %X
        clases(2,i,1) = randi(rangosPrueba(2,:,1)); %Y
    
        %Roca 
        clases(1,i,2) = randi(rangosPrueba(1,:,2)); %X
        clases(2,i,2) = randi(rangosPrueba(2,:,2)); %Y
    
        %Arena
        clases(1,i,3) = randi(rangosPrueba(1,:,3)); %X
        clases(2,i,3) = randi(rangosPrueba(2,:,3)); %Y
    
        %Montaña
        clases(1,i,4) = randi(rangosPrueba(1,:,4)); %X
        clases(2,i,4) = randi(rangosPrueba(2,:,4)); %Y
    end
    
    for i = 1: numClases
        medias(1,i) = mean(clases(1,:,i));
        medias(2,i) = mean(clases(2,:,i));
    end
    
end
