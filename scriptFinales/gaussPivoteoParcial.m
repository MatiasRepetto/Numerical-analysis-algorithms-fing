A = A;#[7 2 1;1 5 2;1 3 8] %estas matrices son de ejemplo
B = b;#[128 69 95]%estas matrices son de ejemplo

Aug = [A B];
N = length(B)
M = N+1

for i=1:N
  t=0;
  for j=i:N
    if abs(Aug(j,i))>t
      t=abs(Aug(j,i));
      p=j;
    endif
  endfor
  w=Aug(i,:);
  Aug(i,:)=Aug(p,:);
  Aug(p,:)=w;
  for k=i+1:N
    pivote=Aug(k,i)/Aug(i,i);
    for j=i:M
      Aug(k,j)=Aug(k,j)-pivote*Aug(i,j);
    endfor
  endfor

  for k=i-1:-1:1
    pivote=Aug(k,i)/Aug(i,i);
    for j=i:M
      Aug(k,j)=Aug(k,j)-pivote*Aug(i,j);
    endfor
  endfor
endfor
if Aug(N,N) == 0
  fprintf('No existe solucion\n')
endif

X_pivP = Aug(:,1:length(B))\Aug(:,length(B)+1);


