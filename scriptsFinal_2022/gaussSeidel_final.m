%clear all
%clearvars

A_gs = Aug;
B = Aug(:,98)';
A_gs(:,98) = [];
iterations = input('Ingrese la cantidad de iteraciones a realizar: ')

D = diag(diag(A_gs));
U = -triu(A_gs,1);
P = tril(A_gs,-1);
N = D + P;

Xgs = zeros(iterations, length(B));
Ninv = inv(N);
Q_gs = Ninv*U

for i = 1:iterations
   Xgs(i+1,:) = (Ninv*B')+(Q_gs*Xgs(i,:)');
end

printf('Solucion de todas las iteraciones: \n')
disp(Xgs)

