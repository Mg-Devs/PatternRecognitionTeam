function [grupos,numMiembros] = k_means(k,muestrasRGB,numMuestras,muestras)
    centroides=zeros(3,k);
    
    distanciasAux=zeros(1,k);
    numMiembros=zeros(1,k);
    gruposRGB=zeros(3,1,k);
    grupos=zeros(2,1,k);
    
    i=1;
    j=1;
    while j<=k
        if compararCentroideMuestras(centroides,muestrasRGB(:,i),j)==1
            centroides(:,j)=muestrasRGB(:,i);
            gruposRGB(:,1,j)=muestrasRGB(:,i);
            grupos(:,1,j)=muestras(:,i);
            numMiembros(1,j)=1;
            j=j+1;
        end
        i=i+1;
    end
    disp('Centroides Iniciales')
    disp(centroides)
    
    %---------Ciclo infinito----------
    clear gruposRGB
    clear grupos
    clear numMiemros
    centroidesAux=zeros(3,k);
    maxIteraciones=1000;
    cont=0;
    while cont<maxIteraciones
        numMiembros=zeros(1,k);
        gruposRGB=zeros(3,1,k);
        grupos=zeros(2,1,k);
        centroidesAux=centroides;
        %disp('CentroidesAux');
        %disp(centroidesAux);
        
        for i=1:numMuestras
            for j=1:k
                distanciasAux(j)=norm(muestrasRGB(:,i)-centroides(:,j));
            end
            %fprintf('Distancias de muestra %d',i);
            %disp(distanciasAux);
            minimo=min(distanciasAux);
            w=find(distanciasAux==minimo);
            sz=size(w);
            if sz==[1 0]
                pos=w(1);
            else 
                pos=w(1,1);
            end
            %[f,c]=size(w);
            %if c~=0
            %    pos=w(1,1);
            %else 
            %    pos=w(1);
            %end
            %fprintf('POSICION %d\n',pos)
            numMiembros(1,pos)=numMiembros(1,pos)+1;
            %disp('Miembros por clase')
            %disp(numMiembros);
            gruposRGB(:,numMiembros(pos),pos)=muestrasRGB(:,i);
            grupos(:,numMiembros(pos),pos)=muestras(:,i);
            %Calcular nuevo centroide
            centroides=calcularCentroides(gruposRGB,numMiembros,k);
            %disp('NUEVOS Centroides');
            %disp(centroides);
        end
        %disp('Miembros por clase')
        %disp(numMiembros);
        %disp('Centroides');
        %disp(centroides);
        if cont+1<maxIteraciones
            if centroidesAux==centroides
                %disp('Centroides iguales ALTO')
                break;
            else 
                %disp('Centroides Diferentes SIGUE')
                clear gruposRGB
                clear grupos
                clear numMiemros
            end
        end
        cont=cont+1;
    end
    fprintf('Numero de Iteraciones = %d.\n',cont)
    disp('Centroides Finales')
    disp(centroides)
end