%clear all
%clearvars

A = Aug;
B = Aug(:,98);
A(:,98) = [];
iterations = input('Ingrese la cantidad de iteraciones a realizar: ')

D = diag(diag(A))
L = tril(A,-1)
U = triu(A,1)
R = L + U
Xj = zeros(iterations, length(B))

Dinv = inv(D)

for i = 1:iterations
   Xj(i+1,:) = Dinv*(B'-R*Xj(i,:)');
end

printf('Solucion de todas las iteraciones: \n')
disp(Xj)

