%clear all
%clearvars

A = Aug;
B = Aug(:,98);
A(:,98) = [];
iterations = input('Ingrese la cantidad de iteraciones a realizar: ')

D = diag(diag(A))
U = triu(A,1)
N = D + U
P = -tril(A,-1)
Xgs = zeros(iterations, length(B))
Ninv = inv(N)

for i = 1:iterations
   Xgs(i+1,:) = (Ninv*B')+(Ninv*P*Xgs(i,:)');
end

printf('Solucion de todas las iteraciones: \n')
disp(Xgs)

