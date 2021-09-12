% ----------------------
% Ej 11 Pr 6 - MetNum 2012
% 26/10/12 - JPZ
% resolucion usando euler.
% se debe modificar el metodo para mejorar resultados.
% ----------------------
clear all, close all


dt    = 1e-2 ;
alpha = 0.01 ;

t     = 0 : dt : 20 ;
Nt    = length(t) ;

Y     = zeros ( 2 , Nt );
Y     = [ 20 ; 150 ] ;

for i=2:Nt
  Yk = Y(:,i-1) ;
  Y(:,i) = Yk + dt * [ 2*Yk(1) - alpha * Yk(2)*Yk(1) ; ...
                       -Yk(2) + alpha * Yk(2)*Yk(1) ] ;
end

figure
plot( Y(1,:),Y(2,:),'linewidth',1.5)
hold on
plot( Y(1,1),Y(2,1),'x-r')
plot( Y(1,1+5/dt),Y(2,1+5/dt),'^-m')
plot( Y(1,1+15/dt),Y(2,1+15/dt),'^-m')
plot( Y(1,end),Y(2,end),'s-g')
grid on
legend('recorrido','inicial','periodo 1','periodo 3','final')
xlabel('conejos')
ylabel('zorros')
title('plano de fases')
print('fases_ej11pr6.jpg','-djpg')

