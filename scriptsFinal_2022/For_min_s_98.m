A6 = A;
A6(:,98)=0;
A6(33,98)=-1;
A6(41,98)=1;
A6(98,:)=0;
A6(98,81)=1;
A6(98,98)=1;



b6 = b;
b6(98)=0;

for r = 1:100
b6(98)=r;
x6=A6\b6;

if rank(A6)==98
  break
endif
endfor
