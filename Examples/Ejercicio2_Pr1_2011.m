% ------------------
% Ejercicio 2 - Practico 1 - 2011
% ------------------

function Ejercicio2_Pr1_2011

close all % cierra todas las ventanas de octave (como graficos)

maxit =100;

% valores iniciales 
% modificar valores para parte a y b
fprintf(' --- Valores iniciales --- \n')
x = 1/3 
y = 1/3 

% vectores para almacenar coordenadas x e y
X = parte_decimal (x) ;
Y = parte_decimal (y) ;

% Calculo
fprintf('\n --- Arranca iteracion --- \n')
for i = 1 : maxit
   
   [x,y] = iteracion(x,y)

   % almaceno para graficar
   X = [ X x ] ;
   Y = [ Y y ] ;
      
end

% Grafico
% punto inicial 
plot(X(1),Y(1),'g-^','markersize',30) % g : verde -^ triangulo
hold on
plot(X,Y,'b-x','markersize',10)
% punto final
plot(X(end),Y(end),'r-s','markersize',30) % r : rojo -s cuadrado

title('Puntos iteraciones ej 2')
xlabel(' x ')
ylabel(' y ')
grid on

% guardo grafico en formato png
% png
print('GraficoPr1Ej2.png','-dpng')
% o
% eps
print('GraficoPr1Ej2.eps','-depsc2')
% existen mas formatos...

% =================================================
% ========== comienza funcion parte decimal =======

function d = parte_decimal (x)

d = x - floor(x) ;



% =================================================
% ========== comienza funcion de iteracion ========

function [x,y]= iteracion(x,y)

aux = x ;
x = parte_decimal ( 2*x + y ) ;
y = parte_decimal ( aux + y ) ;

endfunction
