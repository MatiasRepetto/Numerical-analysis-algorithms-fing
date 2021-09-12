function [yAprox,yExacta] = ecDif(a,b,N);
alfa = sin(a);
beta = sin(b);
h = (b-a)/N;
x = zeros(N-1,1);
A = zeros(N-1);
terminoIndep = zeros(N-1,1);
for i =1:N-1;
	x(i) = a + i*h;
	A(i,i) = (g(x(i))*(h^2)-2);
	terminoIndep(i) = f(x(i))*h^2;
	if (i == 1)
		A(1,2) = 1;
		terminoIndep(i) = terminoIndep(i)-alfa;
	else
	if (i == N-1)
		A(N-1,N-2)=1;
		terminoIndep(i) = terminoIndep(i)-beta;
	else
		A(i,i+1)=1;
		A(i,i-1)=1;
	end
	end
end

yAprox = A\terminoIndep;
yExacta = sin(x);
end

function salida = f(x)
salida = sin(x)*(exp(x)-1);
end

function ge = g(x)
ge = exp(x);
end