% Algoritmo 1: Algoritmo para (p2), Grupo Ledesma,Repetto,Porcal,Rocha 

clearvars %limpiamos variables
Iteraciones = 0 
cantidadlambda = 3 %Numero de entradas del vector lambda
epsilon = 10^(-10) %epsilon maquina
Dx = [32,12,1]  %Vector lambda
Y = rand(cantidadlambda) %Matriz Random Y positiva
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
until norm((X-Y),"fro")<epsilon %| Iteraciones>256


printf("========================================================\n")

Iteraciones
X
Y
NormaDiferencia = norm((X-Y),"fro")
AutovaloresRespuesta = eig(Y)

printf("========================================================\n")