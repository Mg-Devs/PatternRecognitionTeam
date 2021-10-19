function elemento = definirClase(clase)
    switch clase
        case 1
            elemento = 'Cielo';
        case 2
            elemento = 'Roca';
        case 3
            elemento = 'Montaña';
        case 4
            elemento = 'Arena';
        otherwise
            elemento = 'Clase desconocida';
    end
end