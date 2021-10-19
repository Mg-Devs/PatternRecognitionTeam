function [grupos,contadores]=algCadena(muestras,numMuestras,umbral)
    %grupos => 2xNumElementosxNumGrupos
    grupos(:,1,1)=muestras(:,1)
    numGrupos=1;
    contadores(1)=1;
    medias(:,1)=mean(grupos(:,1,1),2)
    for i=2:numMuestras
        for j=1:numGrupos
            disp('---------------------')
            fprintf('i=%d, j=%d\n',i,j)
            %CalcularDistancia
            distAux=norm(muestras(:,i)-medias(:,j))
            %distAux=norm(muestras(:,i)-grupos(:,contadores(j),j))
            fprintf('x%d: (%d,%d)-(%d,%d)=%f\n',i,muestras(1,i),muestras(2,i),medias(1,j),medias(2,j),distAux);
            %Condición
            if distAux<umbral %Se agrega al grupo
                bandera=1;
                break
            else %Se crea nuevo grupo
                bandera=0;
            end
        end
        if bandera==1
            contadores(j)=contadores(j)+1;
            grupos(:,contadores(j),j)=muestras(:,i);
        else
            disp('---Creando Nuevo Grupo---')
            numGrupos=numGrupos+1;
            contadores(j+1)=1;
            grupos(:,contadores(j+1),j+1)=muestras(:,i);
        end
        medias=calcularMedias(grupos,numGrupos,contadores);
        %disp(contadores)
        %disp(grupos)
        %disp(medias)
    end
end