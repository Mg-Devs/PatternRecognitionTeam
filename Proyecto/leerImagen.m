function [img]=leerImagen(contador)
	%IMAG(contador).BMP
    if contador < 10
        direccion=strcat('paisajes/IMG0',string(contador),'.jpg');
    else 
        direccion=strcat('paisajes/IMG',string(contador),'.jpg');
    end
    fprintf('Direccion=%s',direccion)
	%figure(contador)
	img=imread(direccion);
    img = imresize(img,0.5);
	%imshow(img)
	%figure(contador+1)
	%imshow(imgBW)
end