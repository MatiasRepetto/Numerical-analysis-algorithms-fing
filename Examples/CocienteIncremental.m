% ------------------------------------
% Error en calculo de derivadas en Punto Flotante
% ------------------------------------
% En este script calcula la cota del Error en Punto Flotante
% al calcular df/dx con f(x) = exp(x) en x=1 como (exp(1+h)-exp(1))/h
% variando el paso h.
% 
% actualizado: 26/06/11  OK  Octave 3.2
% ------------------------------------

fprintf('Calculando...\n')
% Defino los valores de "h" a usar
c = sqrt(eps/2);  % eps = epsilon de maquina
h = linspace(c/10,10*c,500); 

% Calculo los cocientes incrementales
Dif = (exp(1+h)-exp(1))./h;

% Evalúo el error absoluto cometido
e_abs = abs(Dif-exp(1));

% Calculo la cota para el error absoluto
cota = 1/2*exp(1)*h+2*exp(1)*eps/2./h ;

fprintf('Graficando...\n')
% Grafico el error empirico y la cota
plot(h,e_abs,'-r',h,cota,':b')
axis([min(h),max(h),min([cota,e_abs]),max([cota,e_abs])]);
grid on
legend('Error Absoluto Empírico','Cota del Error Absoluto');
xlabel('h'); ylabel('Error_{abs}');
