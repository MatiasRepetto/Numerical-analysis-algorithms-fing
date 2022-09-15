%clear all
%clearvars

A_gs = Aug_1;
B = Aug_1(:,length(b)+1)';
A_gs(:,length(b)+1) = [];
iterations = input('Ingrese la cantidad de iteraciones a realizar: ')

D = diag(diag(A_gs));
U = triu(A_gs,1);
L = tril(A_gs,-1);
M = D + L;

Xgs = zeros(iterations, length(B));
N = -U;
Q_gs = inv(M)*N

r_gs = max(abs(eig(Q_gs)))
r_gs
for i = 1:iterations
   Xgs(i+1,:) = (inv(M)*B')+(Q_gs*Xgs(i,:)');
end

printf('Solucion de todas las iteraciones: \n')


