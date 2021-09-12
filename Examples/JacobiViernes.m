function [sol,error] = JacobiViernes(A,b,x0,tol,maxIter)
%Esto funciona si x0 y b estan definidos como vectores columna
n = length(b);
Dinv = zeros(n);
D = zeros(n);
for i = 1:n;
	D(i,i) = A(i,i);
	Dinv(i,i) = 1/A(i,i);
end
xk = x0;
aux = zeros(n,1);
iteraciones = 0;
condicion = tol + 1;
iterados = zeros(n,maxIter + 1);
iterados(:,1) = x0;

while (iteraciones < maxIter) && (condicion > tol)
	aux = xk;
	xk = Dinv*b - Dinv*(A-D)*xk; 
	iteraciones = iteraciones + 1;
	condicion = norm(xk - aux);
	iterados(:,iteraciones + 1) = xk;
end

iterados = iterados(:,(1:iteraciones + 1));

if (iteraciones < maxIter)
	fprintf('Termine por condicion de norma \n')
else
	fprintf('Termine por condicion de iteraciones \n')
end

sol = xk;
[n,largo] = size(iterados);
error = zeros(largo,1);

for i = 1:largo;
	error(i) = norm(sol-iterados(:,i));
end

end
	