A6 = A;
N = length(b)+1
A6(:,N)=0;
A6(32-15,N)=-1;
A6(40-17,N)=1;
A6(N,:)=0;
A6(N,N)=1;



b6 = b;
b6(N)=0;

for r = 1:10000
b6(N)=r;
x6=A6\b6;

if rank(A6)==rank([A6 b6])#min(x6)<0

  break
endif
endfor
