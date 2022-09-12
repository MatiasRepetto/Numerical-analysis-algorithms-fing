%clear all
%clearvars

A_j = A%Aug;
B = b%Aug(:,98)';
%A_j(:,98) = [];
iterations = input('Ingrese la cantidad de iteraciones a realizar: ')

D = diag(diag(A_j));
L = tril(A_j,-1);
U = triu(A_j,1);
R = L + U;
Xj = zeros(iterations, length(B));

Dinv = inv(D);
Q_j = Dinv*R

for i = 1:iterations
   Xj(i+1,:) = Dinv*B'-Q_j*Xj(i,:)';
end

printf('Solucion de todas las iteraciones: \n')
disp(Xj)

