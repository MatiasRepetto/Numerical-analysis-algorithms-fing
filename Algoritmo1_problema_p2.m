% Algoritmo 1: Algoritmo para (p2), Grupo L,R,P,R %

clear %limpia posibles variables que usaremos%
cantidadlambda = 3 %Numero de entradas del vector lambda%
epsilon = 10^(-10) %epsilon maquina%
Dx = [3,2,-1]  %Vector lambda%
Y = rand(cantidadlambda) %Matriz Random Y positiva%
Y = Y*Y' %Hace simetrica Y%
do
  
  [autovec,autoval] = eig(Y)
  Dy = autoval
  Vy = orth(autovec) 
  Vyt = Vy'
  Y = Vy*Dy*Vyt
  X = Vy*diag(Dx)*Vyt
  X = ((1/2)*(X + X'))
  Y = X
  Y(Y<0)=0 
  
until norm((X-Y),"fro")<epsilon 