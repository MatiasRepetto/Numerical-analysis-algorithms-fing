%Algoritmo2_problema_p1 grupo: 25 --- Ledesma, Repetto, Porcal, Rocha
pkg load statistics
Iteraciones = 0 
encontro = 0
noencontro = 0
epsilon = 10^(-10) %epsilon maquina
Dx = []
Dx(1) = 1 

for c = 2:5
  aux = normrnd(0,1)
  if aux < 0
    aux = max(-1, aux)
  else
    aux = min(1, aux)
  endif
  Dx(c) = aux
endfor

Y = rand(length(Dx))

do
  
  Iteraciones = Iteraciones+1
  [U,T] = schur(Y)
  [~,idx] = sort(abs(Dx), 'descend');
  lambda = Dx(idx)
  for i1= 1:length(Dx)
    Diag(i1) = T(i1,i1)
  endfor
  lambda1 = []
  for i2 = 1:length(Dx)
    lambda1(i2) = 0
  endfor
  for i = 1: length(lambda)
      valor = 9999999999
      posicion = 1
      for j = 1:length(Dx)
          if (lambda1(j) == 0) && (abs(lambda(i) - Diag(j))) < valor 
              valor = abs(lambda(i) - Diag(j))
              posicion = j
          endif
      endfor
      lambda1(posicion) = lambda(i)
  endfor
  Tp = T
  for i4= 1:length(Dx)
    Tp(i4,i4) = lambda1(i4)
  endfor

  X = U*Tp*U'
  X(1,3)=0
  X(1,4)=0
  X(2,4)=0
  X(2,5)=0
  X(3,1)=0
  X(3,5)=0
  X(4,1)=0
  X(4,2)=0
  X(5,2)=0
  X(5,3)=0
  for j1=1:5
    sum12 = 0
    for j2=1:5
      sum12 = sum12 + X(j1,j2)
    endfor
    for j3=1:5
      X(j1,j3)=(X(j1,j3)/sum12)
    endfor
  endfor
  Y = X
  Y(Y<0)=0

  
until (norm((X-Y),"fro") < epsilon) || Iteraciones > 5000

if (Iteraciones <= 5000)
  encontro = encontro + 1
else
  noencontro = noencontro + 1
endif

printf("========================================================\n")

Vectorlambda = Dx
Iteraciones
X
Y
encontro
noencontro
AutovaloresRespuesta = eig(Y)

printf("========================================================\n")