iteracionestotales = 0
iteracionprueba = 0
encontrototal = 0
noencontrototal = 0
tic
do
  valido = 0
  encontro = 0
  noencontro = 0
  Iteraciones = 0 
  epsilon = 10^(-10) %epsilon maquina
  Dx = []
  for ix = 1:10
    Dx(ix) = (rand-(3/7))*100
  endfor
  for i = 1:length(Dx)
    valido = valido + Dx(i)
  endfor
  if valido < 0
    Dx(1) = (valido*-1) + 1 
  endif
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
    encontro = encontro + 1;
  else
    noencontro = noencontro + 1;
  endif
  encontrototal = encontrototal + encontro
  noencontrototal = noencontrototal + noencontro
  iteracionestotales = iteracionestotales + Iteraciones
  iteracionprueba = iteracionprueba + 1
  
until iteracionprueba > 100
toc

printf("========================================================\n")

iteracionestotales
iteracionprueba
encontrototal
noencontrototal

printf("========================================================\n")