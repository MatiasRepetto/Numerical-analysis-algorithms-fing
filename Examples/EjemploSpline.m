function EjemploSpline()
%ejemplo de Interp Splines

xdata = [0:1:12];
ydata = sin(xdata/2)*10+3*xdata+1;
xint = linspace(0,12,1000);

alfa = 8;
beta = 7.8;


%interpolacion con splines

[x,y] = Splines(xdata,ydata,xint,alfa,beta);

%grafico

subplot(1,2,1)
plot(x,y,'-b',xdata,ydata,'or','markersize',12)
xlabel('t')
title('Interpolacion con Splines')
subplot(1,2,2)
plot(x,abs(sin(x/2)*10+3*x+1-y),'.k')
xlabel('t')
title('Error |Spline-F(x)|')

endfunction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [xint,yint] = Splines(xdata,ydata,xint,alfa,beta)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% INTERPOLACION CON SPLINES %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% "xdata" e "ydata" son los datos a interpolar, deben tener el mismo largo.
%%%%% "xint" son los puntos en los cuales se interpola.
%%%%% "alfa" es la pendiente de la spline en el primer nodo
%%%%% "beta" es la pendiente de la spline en el ultimo nodo

n = length(xdata);

% Calcula coeficientes para armar matriz del sistema.
hi = xdata(2:end)-xdata(1:end-1);
Deltai = ydata(2:end)-ydata(1:end-1);

% Arma Sistema Tridiagonal (n-2)x(n-2). No se incluye "d1" ni "dn" como incognitas.

d1 = alfa;
dn = beta;

diagp = 4./hi(1:n-2) + 4./hi(2:n-1);
diaginf = 2./hi(2:n-2);
diagsup = 2./hi(2:n-2);

M = zeros(n-2,n-2);
M = diag(diagp,0)+diag(diaginf,-1)+diag(diagsup,+1);

b = 6*Deltai(1:n-2)./(hi(1:n-2).^2) + 6*Deltai(2:n-1)./(hi(2:n-1).^2);
b(1) = b(1) - 2/hi(1)*d1;
b(n-2) = b(n-2) - 2/hi(n-1)*dn;

% Resuelve Sistema y halla vector de pendientes en nodos (di).

d = M\b';
d = [d1;d;dn];

% Calcula el interpolante con spline para cada punto en "xint".

N = length(xint);
yint = zeros(1,N);

for j=1:N
    k = max(min([find(xint(j)<xdata,1)-1,n-1]),1);
    x = xint(j);
    xk = xdata(k);
    yk = ydata(k);
    dk = d(k);
    dk1 = d(k+1);
    hk = hi(k);
    Deltak = Deltai(k);
    t = (x - xk)/hk;
    yint(j) = yk + t*Deltak + t*(t-1)*(Deltak-hk*dk)+...
              t^2*(t-1)*(hk*(dk+dk1)-2*Deltak);
end

endfunction