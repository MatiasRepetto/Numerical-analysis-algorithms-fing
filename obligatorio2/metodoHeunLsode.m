load tiempos.mat;
tmp = tiempos;
tmp(152) = -1;
tmp(153) = 2;
tmp = sort(tmp);
f = @(t,y)(y^(2))*(1-3*t)-3*y; % Parte derecha de la EDO
t0 = tmp(1); %valor inicial del tiempo
%y0 = 1.0832; %Valor incial de la variable
%h = (tmp(153)-tmp(1))/153; %Tamaño de salto entre los valores de evaluacion en las iteraciones
tn = tmp(153); % hasta que punto queremos que el programa resuelva
n = 152; % calcula las iteraciones que hay que hacer para llegar a el punto a evaluar


if y0 == 1.0832 || y0 == 1.0861
  function ydot = faux (y,t)
    ydot = -(1-3*t)+3*y; %ecuacion diferencial con el cambio de variable u = y^(-1)
  endfunction
  y(1) = 1/y0; % setea valores iniciales
  yLsode = lsode("faux",1/y0,(t=linspace(tmp(1), tmp(153), 1000))');
  yLsode = 1./yLsode;
  for i=1:n
  h = abs(tmp(i+1) - tmp(i));
	p(i+1) = y(i) + h*faux(tmp(i), y(i)); % metodo heun
	y(i+1) = y(i) + (h/2)*(faux(tmp(i), y(i))+faux(tmp(i+1),p(i+1))); % metodo heun
  end
  y = 1./y;
else
  function ydot = faux (y,t)
    ydot = (y^(2))*(1-3*t)-3*y;
  endfunction
  y(1) = y0; % setea valores iniciales
  yLsode =lsode("faux",y0,(t=linspace(tmp(1), tmp(153), 1000))');
  for i=1:n
  h = abs(tmp(i+1) - tmp(i));
	p(i+1) = y(i) + h*f(tmp(i), y(i)); % metodo heun
	y(i+1) = y(i) + (h/2)*(f(tmp(i), y(i))+f(tmp(i+1),p(i+1))); % metodo heun
  end
end
figure
plot(tmp,y,t,yLsode)
title(['Metodo de Heun para y0 = ' num2str(y0) ' y Lsode para y0 = ' num2str(y0)]) %numtostr para hacer titulo modular
legend('Heun','Lsode')
xlabel('Time')
ylabel('Y value')
xlim([-1 2])
