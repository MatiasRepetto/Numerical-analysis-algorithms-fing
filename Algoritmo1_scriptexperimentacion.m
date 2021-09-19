iteracionestotales = 0
iteracionprueba = 0
encontrototal = 0
noencontrototal = 0
tic
for iter=1:100
  valido = 0
  encontro = 0
  noencontro = 0
  Iteraciones = 0 
  epsilon = 10^(-10) %epsilon maquina
  Dx = [3-0.9999,1+0.9999,-1,-1,-1,-1]
  %for i=1:35
  %  Dx(i)=((rand-(1/3))*100)
  %endfor
  Dx = sort(Dx,'descend')
  Y = rand(length(Dx)) %Matriz Random Y positiva
  Y = Y+Y' %Hace simetrica Y

  do
  
    Iteraciones = Iteraciones+1;
    [autovec,autoval]=eig(Y)
    [autoval,perm] = sort(diag(autoval),'descend')
    autovec=autovec(:,perm)
    Vy = autovec
    Vyt = transpose(Vy)
    X = Vy*diag(Dx)*Vyt
    X = ((1/2)*(X + transpose(X)))
    Y = X
    Y(Y<0)=0
  
  until (norm((X-Y),"fro")<epsilon) || (Iteraciones > 1000)

  if (Iteraciones <= 1000)
    encontro = encontro + 1;
  else
    noencontro = noencontro + 1;
  endif
  encontrototal = encontrototal + encontro
  noencontrototal = noencontrototal + noencontro
  iteracionestotales = iteracionestotales + Iteraciones
  iteracionprueba = iter
  
endfor
toc

printf("========================================================\n")

iteracionestotales
iteracionprueba
encontrototal
noencontrototal

printf("========================================================\n")