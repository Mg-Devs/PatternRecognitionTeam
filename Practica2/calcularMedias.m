function y = calcularMedias(clases, numClases)
    y=zeros(2, numClases);
    for aux=1:numClases
        y(:,aux)=mean(clases(:,:,aux),2);
    end
end

