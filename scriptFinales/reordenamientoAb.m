pivote = [ 1,  3,  4,  6,  8,  9, 11, 12, 17, 20, 21, 23, 25, 26, 30, 33, 35,38, 40, 41, 43, 44, 45, 46, 47, 48, 50, 52, 53,  0,  7, 13, 27, 34,14, 28, 42, 49,  2, 15, 22, 29, 36, 16, 37, 51, 10, 24, 31,  5, 18,32, 39, 19, 54];
pivote = pivote + 1;
D = [A b];
auxD = D;

for i = 1:55
  auxD(i,:) = D(pivote(i),:);
endfor

Aug_1 = auxD
