clc
clear
close all

% genero datos y ruido
N=1000;
t=linspace(0,10,N)';
yexactos=10*t.^2-100*t+210;
Y=yexactos+(randn(N,1)-0)*50;

% ajuste por Ec Normales MinCuad

A=[t.^2,t,ones(N,1)];

xEcNorm=(A'*A)\(A'*Y)

% ajuste por QR MinCuad

[Q1,R1] = qr(A,'0');

whos("Q1","R1")

xQR=R1\(Q1'*Y)

% resolver sistema indeterminado Ax=Y con \

x=A\Y

% ajuste por SVD MinCuad

[U1,S1,V1] = svd(A,'econ');

whos("S1","V1","U1")

xSVD = V1*inv(S1)*U1'*Y

% grafica de funcion original, datos con ruido y funcion ajustada

plot(t,Y,'*k')
hold on
plot(t,xEcNorm(1)*t.^2+xEcNorm(2)*t+xEcNorm(3),'-r')
plot(t,yexactos,'-b')
legend('datos con ruido','funcion ajustada','funcion original')
xlabel('t')
ylabel('y')
title('Ajuste por Minimos Cuadrados de Datos Con Ruido Normal Gaussiano')
hold off