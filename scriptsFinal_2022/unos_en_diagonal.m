D = [A b];

for i = 1:56
  hecho = true;
  if D(i,i) == 0
    for j = 1:56
      if hecho && D(j,i) != 0
        D(i,:)=D(i,:)+D(j,:);
        hecho = false;
      endif
    endfor
  endif
endfor
