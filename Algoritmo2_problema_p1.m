%Algoritmo2_problema_p1 grupo: 25 --- Ledesma, Repetto, Porcal, Rocha

Iteraciones = 0 
operacionlambda = 0
encontro = 0
noencontro = 0
restdxtx = 0
auxiliarmenor = 1000000
epsilon = 10^(-10) %epsilon maquina
Dx = [1+i, 1-i, 2+i, 2-i]
Y = rand(length(Dx)) %Matriz Random Y positiva

do
  
  Iteraciones = Iteraciones+1
  [U,T] = schur(Y,'complex')
  permutaciondex = perms(Dx)
  [fil, col] = size(permutaciondex)
  for i1 = 1:fil
    opercionlambda = 0
    for i2 = 1:col
      vectoriter(i2) = permutaciondex(i1,i2) 
    endfor
    for i3 = 1:length(Dx)
      operacionlambda = operacionlambda + (abs((vectoriter(i3)-T(i3,i3))))^(2)
    endfor
    if auxiliarmenor > operacionlambda
      auxiliarmenor = operacionlambda
      vectorfinal = vectoriter
    endif
  endfor
  for i4= 1:length(Dx)
    T(i4,i4) = vectorfinal(i4)
  endfor
  X = U*T*U'
  Y = X
  Y(Y<0)=0
  
until (norm((X-Y),"fro") < epsilon) || Iteraciones > 5000

if (Iteraciones <= 1000)
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