function elemento = definirClase(clase)
    switch clase
        case 1
            elemento = 'Cielo';
        case 2
            elemento = 'Roca';
        case 3
            elemento = 'Arena';
        case 4
            elemento = 'Montaña';
        otherwise
            elemento = 'Clase desconocida';
    end
end