function [imgBW]=leerImagen(contador)
	%IMAG(contador).BMP
    direccion=strcat('Praderas/img-',string(contador),'.jpg');
    fprintf('Direccion=%s',direccion)
	%figure(contador)
	img=imread(direccion);
	%imshow(img)
	%figure(contador+1)
	imgBW=im2bw(img);
	%imshow(imgBW)
end