%
% Codigo para resolucion de parte E de Ej 5 Pr 1
%
% NO se utiliza un algoritmo apropiado como se describe en la parte D.
% para ello se podria utilizar algoritmos como Jacobi o Thomas.
%

function Ejercicio5_Pr2_2011

close all

% Datos del problema
a = 0 ; %limite izquierdo
b = 5 ; % limite derecho
alfa = 0 ;
beta = sin(5) ; 

% valor de N PARA TANTEAR
N = 200 ; % divisiones

% paso
h = (b-a) / N ;

x = [a:h:b]' ; % discretizacion del dominio

G = fung(x) ;
F = funf(x) ;

% Construyo matriz
A = zeros(N-1); ti= zeros(N-1,1);

for i = 2:(N-2)   

   A (i,[ i-1 : i+1 ]) = [1/h^2 G(i)-2/h^2 1/h^2 ];
   ti(i) = F(i) ;
   
end

A(1,[1 2]) = [G(1)-2/h^2 1/h^2] ;
A(N-1,[N-2 N-1]) = [1/h^2 G(N-1)-2/h^2 ] ;
ti(1) = F(1) - alfa/h^2 ;
ti(N-1) = F(N-1) - beta/h^2 ;

y = A\ti ;

Y = [alfa; y; beta ] ;

plot(x,Y,'b-s','markersize',15)
hold on

aux = (a:.1:b) ; sin(aux)
plot(aux ,sin(aux),'r-o','markersize',10)

% propiedades grafico
title('Ejercicio 5 Pr 2')
xlabel('x'), ylabel('y')
grid on, legend('aprox','real')

% salida grafico
print('figura.png','-dpng')

% ------------------------
function g = fung (x) 
g = exp(x) ;

% ------------------------
function f = funf (x) 
f =  sin(x) .* (exp(x) -1) ;

