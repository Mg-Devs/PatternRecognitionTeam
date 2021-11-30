function tipoObj = defObjeto(centroide)
    %Los tipo 1 son Tornillos
    if (centroide(1) > 40 && centroide(1) < 60) && (centroide(2) > 50 && centroide(2) < 60)
        tipoObj = 1;
    
    %Los tipo 2 son Llaves
    elseif (centroide(1) > 45 && centroide(1) < 65) && (centroide(2) > 90 && centroide(2) < 110) 
        tipoObj = 2;
    
    %Los tipo 3 son Armellas
    elseif (centroide(1) > 60 && centroide(1) < 80) && (centroide(2) > 70 && centroide(2) < 80)
        tipoObj = 3;
    
    %Los tipo 4 son Rondanas
    elseif (centroide(1) > 80 && centroide(1) < 100) && (centroide(2) > 30 && centroide(2) < 40)
        tipoObj = 4;
    
    elseif (centroide(1) > 128 && centroide(1) < 136) && (centroide(2) > 40 && centroide(2) < 70)
        tipoObj = 5;
    else
        tipoObj = 6;
    end
end