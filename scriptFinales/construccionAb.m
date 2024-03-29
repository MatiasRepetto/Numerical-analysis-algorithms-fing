n=8
m=7
numero_incognitas = n*(m-1)+(n-1)*m
numero_ecuaciones = n*m
A = zeros([56,97]);
b = zeros([56,1]);

# Recorro las primeras 56 ecuaciones = nodos del mapeo de flujos
for i = 1:numero_ecuaciones
  # Esquina sup izq
  if i==1
    # n*(m-1) = número de incognitas horizontales
    sv_inf = n*(m-1)+1;
    A(i,1) = -1;
    A(i,sv_inf) = 1;
    b(i) = flujosv(1,1)-flujosh(1,1); #b_1,1 = -(h_1,1 - v_1,1) ==> negativo por el despeje
  endif
  # Frontera sup
  if (i>1) && (i<m)
    sv_inf = n*(m-1)+(n-1)*(i-1)+1;
    A(i,i-1) = 1;
    A(i,i) = -1;
    A(i,sv_inf) = (-1)^(i+1);
    b(i) = flujosv(1,i)*(-1)^(i+1);
  endif
  # Esquina sup der
  if i==m
    sv_inf = n*(m-1)+(n-1)*(m-1)+1;
    A(i,i-1) = 1;
    A(i,sv_inf) = (-1)^(m+1);
    b(i) = flujosh(1,2)+flujosv(1,m)*(-1)^(m+1);
  endif
  # Frontera der
  if ((i>m) && (mod(i,m)==0)) && (i<=(n-1)*m)
    sv_sup = n*(m-1)+(n-1)*(m-1)+(i/m)-1;
    sv_inf = n*(m-1)+(n-1)*(m-1)+i/m;
    A(i,sv_inf) = (-1)^(m+1);
    A(i,sv_sup) = (-1)^m;
    A(i,(i/m)*(m-1)) = (-1)^(i/m+1);
    b(i) = flujosh(i/m,2)*(-1)^(i/m+1);
  endif
  # Esquina inf der
  if i==n*m
    sv_sup = n*(m-1)+(n-1)*m;
    A(i,n*(m-1)) = (-1)^(n+1);
    A(i,sv_sup) = (-1)^(m);
    b(i) = flujosv(2,m)*(-1)^m+flujosh(n,2)*(-1)^(n+1);
  endif
  # Frontera inf
  if (i>(n-1)*m+1) && (i<n*m)
    sv_sup = n*(m-1)+ mod(i,m)*(n-1);
    A(i,sv_sup) = (-1)^mod(i,m);
    A(i,(n-1)*(m-1)+mod(i,m)) = (-1)^n;
    A(i,(n-1)*(m-1)+mod(i,m)-1) = (-1)^(n+1);
    b(i) = flujosv(2,mod(i,m))*(-1)^mod(i,m);
  endif
  # Esquina inf izq
  if i==(n-1)*m+1
    sv_sup = n*(m-1)+n-1;
    A(i,sv_sup) = -1;
    A(i,(n-1)*(m-1)+1) = (-1)^n;
    b(i) = flujosh(n,1)-flujosv(2,1);
  endif
  # Frontera izq sin puntas
  if ((i>1) && (mod(i-1,m)==0)) && (i<(n-1)*m)
    sv_sup = n*(m-1)+(i-1)/m;
    sv_inf = n*(m-1)+(i-1)/m+1;
    sh_der = (m-1)*(i-1)/m+1;
    A(i,sv_inf) = 1;
    A(i,sv_sup) = -1;
    A(i,sh_der) = (-1)^((i-1)/m-1);
    b(i) = flujosh((i-1)/m+1,1)*(-1)^((i-1)/m+1);
  endif
  # Centro / sin fronteras
  if (i>m) && (i<(n-1)*m) && (mod(i,m)!=0) && (mod(i-1,m)!=0)
    # n*(m-1) = n° total de s_hor
    # mod(i,m)-1 = n° de col_mapeo ant a act
    # n-1 = n° de s_ver por col_mapeo
    # (i-mod(i,m))/m = n° de fila_mapeo ant a act

    # por ejemplo: en anexo, nodo_2,2
    # sv_inf = 4*(4-1)+(4-1)*(mod(6,4)-1)+(6-mod(6,4))/4+1
    # sv_inf = 12 + 3 + 2 = 17 (pos_inc) ==> s_17
    # A(6,17) = (-1)^(mod(6,4)+1)
    # A(6,17) = (-1)^3 = -1

    sv_inf = n*(m-1)+(n-1)*(mod(i,m)-1)+(i-mod(i,m))/m+1;
    sv_sup = n*(m-1)+(n-1)*(mod(i,m)-1)+(i-mod(i,m))/m;
    sh_der = (m-1)*(i-mod(i,m))/m+mod(i,m);
    sh_izq = (m-1)*(i-mod(i,m))/m+mod(i,m)-1;
    A(i,sv_inf) = (-1)^(mod(i,m)+1);
    A(i,sv_sup) = (-1)^(mod(i,m));
    A(i,sh_der) = (-1)^((i-mod(i,m))/m+1);
    A(i,sh_izq) = (-1)^((i-mod(i,m))/m);

  endif
endfor

# Agrego datos flujos.mat

%b = [b;flujos(:,2)];



  for j = 1:41 % Recorro el archivo flujos.mat
    for k = 1:56 % Recorro las filas
      if A(k,flujos(j,1)) != 0
        b(k)=b(k)-flujos(j,2)*A(k,flujos(j,1));
        A(k,flujos(j,1)) = 0;
      endif
    endfor
  endfor

  for j = 0:40
    A(:,flujos(41-j,1))=[];
  endfor



A(10,:)=[];
b(10)=[];
A(:,50)=[];
x=A\b;
round(x)
size(x)

%save('A.mat', 'A', '-v7') #save('pqfile.txt','p','q','-ascii')
%save('b.mat', 'b', '-v7')



