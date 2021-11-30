function tipoObj = defObjeto(centroide)
    %Los tipo 1 son Tornillos
    if (centroide(1) > 36 && centroide(1) < 60) && (centroide(2) > 100 && centroide(2) < 150)
        tipoObj = 1;
    
    %Los tipo 2 son Llaves
    elseif (centroide(1) > 42 && centroide(1) < 80) && (centroide(2) > 200 && centroide(2) < 250)
        tipoObj = 2;
    
    %Los tipo 3 son Armellas
    elseif (centroide(1) > 60 && centroide(1) < 80) && (centroide(2) > 150 || centroide(2) < 182)
        tipoObj = 3;
    
    %Los tipo 4 son Rondanas
    elseif (centroide(1) > 75 && centroide(1) < 95) && (centroide(2) > 85 && centroide(2) < 100)
        tipoObj = 4;
    
    else
        tipoObj = 5;
    end
end