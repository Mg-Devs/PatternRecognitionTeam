clc
clear all
close all
warning off all
%este programa convierte las coord espaciales del plano cartesiano a las
% coord de una imagen 

h=imread('./paris.jpg');
figure(1)
[m,n]=size(h);
imshow(h)

figure(2)
dato=imref2d(size(h));
imshow(h,dato)

% figure(3)
% impixel(h)

c1X=randi([50,650],1,100)
c1Y=randi([50,250],1,100);

c2X=randi([50,650],1,100);
c2Y=randi([300,420],1,100);

c3X=randi([250,400],1,100);
c3Y=randi([25,300],1,100);

clases=zeros(2,100,3);
clases(1,:,1)=c1X;
clases(2,:,1)=c1Y;
clases(1,:,2)=c2X;
clases(2,:,2)=c2Y;
clases(1,:,3)=c3X;
clases(2,:,3)=c3Y;

display(clases);
%%% GRAFICANDO SOBRE EL PLANO DE LA IMAGEN COOR PIXELARES

Z1=impixel(h,clases(1,:,1),clases(2,:,1));
Z2=impixel(h,clases(1,:,2),clases(2,:,2));
Z3=impixel(h,clases(1,:,2),clases(2,:,2));

px=input('dame la coord del vector en x = ')
py=input('dame la coord del vector en y = ')

punto=[px;py];

P1=impixel(h,punto(1,:),punto(2,:));



grid on
hold on
plot(c1X(1,:),c1Y(1,:),'ob','MarkerSize',10)
plot(c2X(1,:),c2Y(1,:),'or','MarkerSize',10)
plot(c3X(1,:),c3Y(1,:),'og','MarkerSize',10)
plot(punto(1,:),punto(2,:),'oy','MarkerSize',10,'MarkerFaceColor','y')



disp('fin de proceso...')