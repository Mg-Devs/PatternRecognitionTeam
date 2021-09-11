function clase = clasificador_KNN(vecDesc,k,clases,numClases,numRepresentantes)
	%Calculando las distancias
	distancias=zeros(numClases,numRepresentantes);
	distanciasTotales=zeros(1,numClases*numRepresentantes);
	cont=1;
	for i=1:numClases
	    for j=1:numRepresentantes
	        distanciaAux=norm(vecDesc-clases(:,j,i));
	        distancias(i,j)=distanciaAux; 
	        distanciasTotales(1,cont)=distanciaAux;
	        cont=cont+1;
	    end
	end
	%Imprimir en Formato
	% for i=1:numClases
	%     for j=1:numRepresentantes
	%         fprintf('d(x, r%d, C%d)=%f\n',j,i,distancias(i,j));
	%     end
	% end
	%Ordenar distancias
	distanciasTotales=sort(distanciasTotales);
	%Encontrando las Distancias
    contClases=zeros(numClases,1);
	for i=1:numClases 
	    for j=1:k
	        distanciaBuscada=distanciasTotales(1,j);
	        for l=1:numRepresentantes
	           if(distancias(i,l)==distanciaBuscada & sum(contClases)<k)
	              contClases(i,1)=contClases(i,1)+1;
	              break;
	           end
	        end
	    end
	end
	disp(contClases)
	maximo=max(contClases);
	clase=find(contClases==maximo);
end

