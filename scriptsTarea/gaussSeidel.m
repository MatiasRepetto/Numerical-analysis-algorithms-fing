clear all
clearvars

A = [7 2 1;1 5 2;1 3 8] %estas matrices son de ejemplo
B = [128 69 95]%estas matrices son de ejemplo
iterations = input('Ingrese la cantidad de iteraciones a realizar: ')

D = diag(diag(A))
U = triu(A,1)
N = D + U
P = -tril(A,-1)
Xs = zeros(iterations, length(B))
Ninv = inv(N)

for i = 1:iterations
   Xs(i+1,:) = (Ninv*B')+(Ninv*P*Xs(i,:)');
end

printf('Solucion de todas las iteraciones: \n')
disp(Xs)

