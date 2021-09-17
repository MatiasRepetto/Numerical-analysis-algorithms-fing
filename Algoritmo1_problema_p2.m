% Algoritmo 1: Algoritmo para (p2), Grupo Ledesma,Repetto,Porcal,Rocha 

%clearvars %limpiamos variables
valido = 0
encontro = 0
noencontro = 0
Iteraciones = 0 
epsilon = 10^(-10) %epsilon maquina
Dx = [(rand-(1/3))*100,(rand-(1/3))*100,(rand-(1/3))*100,(rand-(1/3))*100]  %Vector lambda
Dx = sort(Dx,'descend')
Y = rand(length(Dx)) %Matriz Random Y positiva
Y = Y+Y' %Hace simetrica Y

do
  
  Iteraciones = Iteraciones+1;
  [autovec,autoval] = eig(Y)
  Dy = autoval
  Vy = rot90(rot90(autovec))
  Vyt = Vy'
  X = Vy*diag(Dx)*Vyt
  X = ((0.5)*(X + X'))
  Y = X
  Y(Y<0)=0
  
until (norm((X-Y),"fro") < epsilon) | (Iteraciones > 1000)

if (Iteraciones <= 1000)
  encontro = encontro + 1;
else
  noencontro = noencontro + 1;
endif
 
printf("========================================================\n")

Vectorlambda = Dx
Iteraciones
X
Y
encontro
AutovaloresRespuesta = eig(Y)

printf("========================================================\n")