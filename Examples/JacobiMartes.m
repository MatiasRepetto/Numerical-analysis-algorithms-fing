function [sol,error] = JacobiMartes(A,b,x0,tol,maxIter)
% Para que esta función ande se deben definir x0 y b como columnas
n = length(b);
xk = x0;
iteraciones = 0;

condicion = norm(A*x0-b);
iterados = zeros(n,maxIter);
iterados(:,1) = x0;

while (iteraciones < maxIter) && (condicion > tol)

	aux = xk;
	for i = 1:n;
		xk(i) = (b(i) - A(i,:)*aux + A(i,i)*aux(i))/A(i,i);
	end
	
	condicion = norm(A*xk-b);
	iteraciones = iteraciones + 1;
	iterados(:,iteraciones + 1) = xk;

end

sol = xk;

iterados = iterados(:,1:(iteraciones + 1));
error = zeros(iteraciones + 1,1);
for i = 1:length(error);
	error(i) = norm(iterados(:,i)-sol);
end
	
end
	