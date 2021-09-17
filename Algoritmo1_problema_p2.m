% Algoritmo 1: Algoritmo para (p2), Grupo Ledesma,Repetto,Porcal,Rocha 

clearvars %limpiamos variables
Iteraciones = 0 
epsilon = 10^(-10) %epsilon maquina
Dx = [3,1,-1,-1,-1,-1]  %Vector lambda
Dx = sort(Dx,'descend')
Y = rand(length(Dx)) %Matriz Random Y positiva
Y = Y+Y' %Hace simetrica Y

do
  
  Iteraciones = Iteraciones+1;
  [autovec,autoval] = eig(Y)
  Dy = autoval
  Vy = rot90(rot90(autovec))
  Vyt = Vy'
  Y = Vy*Dy*Vyt
  X = Vy*diag(Dx)*Vyt
  X = ((1/2)*(X + X'))
  Y = X
  Y(Y<0)=0
  
until norm((X-Y),"fro")<epsilon | Iteraciones > 1000

if (Iteraciones <= 1000)
  encontro = true;
else
  encontro = false;
endif
 
printf("========================================================\n")

Vectorlambda = Dx
Iteraciones
X
Y
encontro
AutovaloresRespuesta = eig(Y)

printf("========================================================\n")