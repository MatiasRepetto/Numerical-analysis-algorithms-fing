xd = tiempos;
xd(152) = -1;
xd(153) = 2;
xd = sort(xd);

val_inic =  [0.9142;0.8655;1.0861;1.0832];

time = linspace(-1,2,1000);


function [temp,yint,sprima_i, sseg] = Splines(xd,y,temp)

fprima1 = ((y(1))^2)*(1-3*xd(1))-3*(y(1));
fprima151 = ((y(153))^2)*(1-3*xd(153))-3*(y(153));


n = length(xd);
temp = sort(temp);
hi = xd(2:end)-xd(1:end-1);
Deltai = y(2:end)-y(1:end-1);

d1 = fprima1;
dn = fprima151;

diagp = 4./hi(1:n-2) + 4./hi(2:n-1);
diaginf = 2./hi(2:n-2);
diagsup = 2./hi(2:n-2);

M = zeros(n-2,n-2);
M = diag(diagp,0)+diag(diaginf,-1)+diag(diagsup,+1);

b = 6*Deltai(1:n-2)./(hi(1:n-2).^2) + 6*Deltai(2:n-1)./(hi(2:n-1).^2);
b(1) = b(1) - 2/hi(1)*d1;
b(n-2) = b(n-2) - 2/hi(n-1)*dn;

d = M\b';
d = [d1;d;dn];

N = length(temp);
yint = zeros(1,N);
sprima_i = zeros(1,N);
sseg = zeros(1,N);

for j=1:N
    k = max(min([find(temp(j)<xd,1)-1,n-1]),1);
    x = temp(j);
    xk = xd(k);
    yk = y(k);
    dk = d(k);
    dk1 = d(k+1);
    hk = hi(k);
    Deltak = Deltai(k);
    t = (x - xk)/hk;
    yint(j) = yk + t*Deltak + t*(t-1)*(Deltak-hk*dk)+...
              t^2*(t-1)*(hk*(dk+dk1)-2*Deltak);

    sprima_i(j) = (Deltak + (2*t - 1)*(Deltak - hk*dk) + (3*t^2 -  2*t)*(hk*(dk + dk1) - 2*Deltak))/ hk;
    sseg(j) = (2*(Deltak - hk*dk) + (6*t - 2)*(hk*(dk + dk1) - 2*Deltak))/hk;

end

endfunction

  y0 = val_inic(1);
  C = (1-(1/y0))*exp(3);
  y_sol1 = -1./(C*exp(3*time)+time);
  metodoHeunLsode
  [x,y1,sprima1,sseg1] = Splines(xd,y,time);
  #t1 = t;
  yLsode1 = yLsode;

  y0 = val_inic(2);
  C = (1-(1/y0))*exp(3);
  y_sol2 = -1./(C*exp(3*time)+time);
  metodoHeunLsode
  [x,y2,sprima2,sseg2] = Splines(xd,y,time);
  #t2 = t;
  yLsode2 = yLsode;

  y0 = val_inic(3);
  C = (1-(1/y0))*exp(3);
  y_sol3 = -1./(C*exp(3*time)+time);
  metodoHeunLsode
  [x,y3,sprima3,sseg3] = Splines(xd,y,time);
  #t3 = t;
  yLsode3 = yLsode;

  y0 = val_inic(4);
  C = (1-(1/y0))*exp(3);
  y_sol4 = -1./(C*exp(3*time)+time);
  metodoHeunLsode
  [x,y4,sprima4,sseg4] = Splines(xd,y,time);
  #t4 = t;
  yLsode4 = yLsode;

figure

%plot(x,y1)
%plot(x,y2)
plot(time,y_sol3,time,y_sol4)
%plot(x,yLsode1)
%plot(x,yLsode2)
title('Solucion Exacta')

legend('yexacta3 (y0=1.0861)','yexacta4 (y0=1.0832)')
xlabel('Time')
ylabel('Y value')
xlim([-1 2])

figure

%plot(x,y1)
%plot(x,y2)
plot(time,y_sol1,time,y_sol2)
%plot(x,yLsode1)
%plot(x,yLsode2)
title('Solucion Exacta')

legend('yexacta1 (y0=0.9142)','yexacta2 (y0=0.8655)')
xlabel('Time')
ylabel('Y value')
xlim([-1 2])

%figure
%hold on
%plot(x,y3)
%plot(x,y4)
%plot(x,yLsode3)
%plot(x,yLsode4)

%title('Interpolacion con Splines f3 y f4')

%legend('y3 (y0=1.0861)','y4 (y0=1.0832)','yexacta3 (y0=0.9142)','yexacta4 (y0=0.8655)', 'yLsode3 (y0=1.0861)', 'yLsode4 (y0=1.0832)')
%xlabel('Time')
%ylabel('Y value')
%xlim([-1 2])

%{
figure
hold on
plot(x, sprima1)
plot(x, sprima2)

title('Derivada primera de las funciones splines f1 y f2')

legend('yprima1 (y0=0.9142)','yprima2 (y0=0.8655)')
xlabel('Time')
ylabel('Yprima value')
xlim([-1 2])

figure
hold on
plot(x, sprima3)
plot(x, sprima4)

title('Derivada primera de las funciones splines f3 y f4')

legend('yprima3 (y0=1.0861)','yprima4 (y0=1.0832)')
xlabel('Time')
ylabel('Yprima value')
xlim([-1 2])
%}

#figure
#hold on
#plot(x, sseg1)
#plot(x, sseg2)
%subplot(1,2,1)
%plot(x,y,'-b',xd,y,'or','markersize',12)
%xlabel('t')
%title('Interpolacion con Splines')
%subplot(1,2,2)
%plot(x,abs(sin(x/2)*10+3*x+1-y),'.k')
%xlabel('t')
%title('Error |Spline-F(x)|')
