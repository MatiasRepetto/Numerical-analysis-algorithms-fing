iteracionprueba = 0
iteracionestotales = 0
noencontrototal = 0
encontrototal = 0
tic
do
  Iteraciones = 0 
  encontro = 0
  noencontro = 0
  epsilon = 10^(-10) %epsilon maquina
  x1 = ((rand-(1/3))*100)+((rand-(1/3))*100)*1i
  x2 = ((rand-(1/3))*100)+((rand-(1/3))*100)*1i
  x3 = ((rand-(1/3))*100)+((rand-(1/3))*100)*1i
  Dx = [x1, conj(x1), x2, conj(x2), x3, conj(x3)]
  Y = rand(length(Dx)) %Matriz Random Y positiva

  do
  
    Iteraciones = Iteraciones+1
    [U,T] = schur(Y, "complex")
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
    Y = X
    Y(Y<0)=0
    Y = real(Y)
  
  until (norm((X-Y),"fro") < epsilon) || Iteraciones > 5000

  if (Iteraciones <= 5000)
    encontro = encontro + 1
  else
    noencontro = noencontro + 1
  endif
  
  iteracionprueba = iteracionprueba + 1
  encontrototal = encontrototal + encontro
  noencontrototal = noencontrototal + noencontro
  iteracionestotales = iteracionestotales + Iteraciones
  
until iteracionprueba>100
toc

printf("========================================================\n")

iteracionestotales
iteracionprueba
encontrototal
noencontrototal

printf("========================================================\n")