%
% Ej 1 Pr 3 Usando biparticion
%
function Ej1_Pr3_2011_biparticion

a = -1 ;
b = 100 ;

x0 = (b-a)/2 +a;

% arranca iteracion
xi = x0 ;

fin = 0 ;
i = 0;
X = xi;

fprintf('\nComienzan iteraciones\n')
while fin == 0
   i=i+1;
   fprintf('\n iteracion: %g ',i)

   % cuentas
   f = fun(xi);

   if f>0
      b = xi  ;
   elseif f < 0
      a = xi;
   else
      fprintf('encontramos la raiz')
   end
      xi = (a+b)/2
   
   % almacenar x
   X=[X ; xi];
   
   
   
   % condicion de parada
   fin_it = i>200 ;
   fin_fun = abs(f) < 1e-10 ;
   fin_int = (b-a) < 1e-15 ;
   fin = fin_it | fin_fun | fin_int ;
   if fin==1
      fin_it, fin_fun,fin_int,
   end
end   

Error = abs( X - sqrt(2) );

plot(X)
grid on

% grafica errores para ver velocidad de convergencia
x = log(Error(1:(end-1) ) );
y = log(Error(2:end) ) ;

figure
plot(x,y)
xlabel('Log(e^{(k)})')
ylabel('Log(e^{(k+1)})')
grid on

hold on

plot(x,x+log(.5))
xlabel('Log(e^{(k)})')
ylabel('Log(e^{(k+1)})')

function f=fun(x)
f = x^2-2;

