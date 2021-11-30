function [imgBW]=leerImagen(contador)
	%IMAG(contador).BMP
    if(contador>0 && contador<10)
        direccion=strcat('BD/IMAG00',string(contador),'.BMP');
    elseif (contador>9 && contador<100)
        direccion=strcat('BD/IMAG0',string(contador),'.BMP');
    else 
        direccion=strcat('BD/IMAG',string(contador),'.BMP');
    end
    fprintf('Direccion=%s',direccion)
	%figure(contador)
	img=imread(direccion);
	%imshow(img)
	%figure(contador+1)
	imgBW=im2bw(img);
	%imshow(imgBW)
end