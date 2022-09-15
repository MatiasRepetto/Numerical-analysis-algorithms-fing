%clear all
%clearvars

A_j = Aug_1;
B = Aug_1(:,length(b)+1)';
A_j(:,length(b)+1) = [];

iterations = input('Ingrese la cantidad de iteraciones a realizar: ')

D = diag(diag(A_j));
L = tril(A_j,-1);
U = triu(A_j,1);
N = -(L + U);
Xj = zeros(iterations, length(B));

Dinv = inv(D);
Q_j = Dinv*N

r_j=max(abs(eig(Q_j)))

for i = 1:iterations
   Xj(i+1,:) = Dinv*B'+Q_j*Xj(i,:)';
end

printf('Solucion de todas las iteraciones: \n')

