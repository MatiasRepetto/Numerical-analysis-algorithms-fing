load tiempos.mat;
tmp = tiempos;
tmp(152) = -1;
tmp = sort(tmp);
f = @(t,y)(y^(2))*(1-3*t)-3*y; % Parte derecha de la EDO
t0 = tmp(1); %valor inicial del tiempo
y0 = 1.0861; %Valor incial de la variable
h = (tmp(152)-tmp(1))/152; %Tamaño de salto entre los valores de evaluacion en las iteraciones
tn = tmp(152); % hasta que punto queremos que el programa resuelva
n = 151; % calcula las iteraciones que hay que hacer para llegar a el punto a evaluar
y(1) = y0; % setea valores iniciales
for i=1:n
	p(i+1) = y(i) + h*f(tmp(i), y(i)); % metodo heun
	y(i+1) = y(i) + (h/2)*(f(tmp(i), y(i))+f(tmp(i+1),p(i+1))); % metodo heun
end


if y0 == 1.0832 || y0 == 1.0861
  function ydot = faux (y,t)
    ydot = -(1-3*t)-((-3*y^(-1))/(y^(-2))); %ecuacion diferencial con el cambio de variable u = y^(-1)
  endfunction
  yLsode =lsode("faux",y0,(t=linspace(tmp(1), tmp(152), 152))');
  yLsode = 1./yLsode;
else
  function ydot = faux (y,t)
    ydot = (y^(2))*(1-3*t)-3*y;
  endfunction
  yLsode =lsode("faux",y0,(t=linspace(tmp(1), tmp(152), 152))');
end
figure
plot(tmp,y,t,yLsode)
title(['Metodo de Heun para y0 = ' num2str(y0) ' y Lsode para y0 = ' num2str(y0)]) %numtostr para hacer titulo modular
legend('Heun','Lsode')
xlabel('Time')
ylabel('Y value')
xlim([-1 2])