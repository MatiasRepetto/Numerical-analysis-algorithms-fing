%clear all
%clearvars

%A = [7 2 1;1 5 2;1 3 8] %estas matrices son de ejemplo
%B = [128 69 95]%estas matrices son de ejemplo
%B = B'
Aug = [A B];
N = length(B);

for j = 1:N-1
  [M, P] = max(abs(Aug(j:N,j)));
  C = Aug(j,:);
  Aug(j,:) = Aug(P+j-1,:);
  Aug(P+j-1,:) = C;
  for i = j+1:N
    m = Aug(i,j)*Aug(j,j);
    Aug(i,:) = Aug(i,:) - m*Aug(j,:);
  endfor
end