#Reordenamiento

Aug_r = [A B]
N = length(B)
M = N+1

for i=1:N
  t=0;
  for j=i:N
    if abs(Aug_r(j,i))>t
      t=abs(Aug_r(j,i));
      p=j;
    endif
  endfor
  w=Aug_r(i,:);
  Aug_r(i,:)=Aug_r(p,:);
  Aug_r(p,:)=w;
endfor