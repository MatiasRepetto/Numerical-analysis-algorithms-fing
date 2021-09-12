% ------------------------------------
% Descomposicion LU 
% ------------------------------------
% Descomposicion P*A=L*U 
% Se usa la estrategia de pivoteo parcial y
% se realizan las permutaciones en un vector de indices.
%

% actualizado: 26/06/11  OK  Octave 3.2
% ------------------------------------

function [P L U] = DescompLU (A)

% chequeo
if det(A)==0,
   determinante = det(A)
   error('La matriz A debe ser no singular')
end
 
% Definimos variables
[n n]=size(A); %tamaño del problema.
L=zeros(n); %Reserva memoria para la matriz L.
v=1:n; %vector de índices de permutacion.

for k=1:n-1
    %búsqueda del max en columna
    %m es el maximo, im es el indice
    [m,im]=max(abs(A(v(k:n),k))); 
    
     %realiza la permutación sólo si es necesario 
    if im>1                    
       im=im+k-1;
       aux=v(k);
       v(k)=v(im);
       v(im)=aux;
    end
    for i=k+1:n %escaleriza
        %L almacena los multiplicadores
        L(v(i),k)=A(v(i),k)/A(v(k),k);
        A(v(i),:)=A(v(i),:)-L(v(i),k)*A(v(k),:);
    end  
end

P=eye(n);
P=P(v,:); %matriz de permutación
L=L(v,:)+eye(n);
U=A(v,:); 


