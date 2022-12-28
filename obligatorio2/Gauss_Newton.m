clear
load tiempos.mat;
load tiempos2.mat;
xd = tiempos;
xd(152) = -1;
xd(153) = 2;
xd = sort(xd);

val_inic =  [0.9142;0.8655;1.0861;1.0832];

time = linspace(-1,2,1000);


function [temp,yint] = Splines(xd,y,temp)

fprima1 = ((y(1))^2)*(1-3*xd(1))-3*(y(1));
fprima151 = ((y(153))^2)*(1-3*xd(153))-3*(y(153));


n = length(xd);
temp = sort(temp);
hi = xd(2:end)-xd(1:end-1);
Deltai = y(2:end)-y(1:end-1);

d1 = fprima1;
dn = fprima151;

diagp = 4./hi(1:n-2) + 4./hi(2:n-1);
diaginf = 2./hi(2:n-2);
diagsup = 2./hi(2:n-2);

M = zeros(n-2,n-2);
M = diag(diagp,0)+diag(diaginf,-1)+diag(diagsup,+1);

b = 6*Deltai(1:n-2)./(hi(1:n-2).^2) + 6*Deltai(2:n-1)./(hi(2:n-1).^2);
b(1) = b(1) - 2/hi(1)*d1;
b(n-2) = b(n-2) - 2/hi(n-1)*dn;

d = M\b';
d = [d1;d;dn];

N = length(temp);
yint = zeros(1,N);

for j=1:N
    k = max(min([find(temp(j)<xd,1)-1,n-1]),1);
    x = temp(j);
    xk = xd(k);
    yk = y(k);
    dk = d(k);
    dk1 = d(k+1);
    hk = hi(k);
    Deltak = Deltai(k);
    t = (x - xk)/hk;
    yint(j) = yk + t*Deltak + t*(t-1)*(Deltak-hk*dk)+...
              t^2*(t-1)*(hk*(dk+dk1)-2*Deltak);
end

endfunction
  t2 = tiempos2;
  t2(152) = -1;
  t2(153) = 2;
  t2(154) = 0.20;
  t2(155) = 0.30;
  t2(156) = 0.35;
  t2(157) = 0.75;
  t2 = sort(t2);

  y0 = val_inic(1);
  metodoHeunLsode
  [x,g1] = Splines(xd,y,t2);

  y0 = val_inic(2);
  metodoHeunLsode
  [x,g2] = Splines(xd,y,t2);



  y0 = 0.9526;
  function ydot = faux (y,t)
    ydot = (y.^(2))*(1-3*t)-3*y;
  endfunction
  y(1) = y0; % setea valores iniciales
  y = lsode("faux",y0,(t=t2));

  g1 = transpose(g1);
  g2 = transpose(g2);

  F = @(alfa,beta,gama) alfa*g1.^beta + g2.^gama;

  %Res = @(alfa,beta,gama) alfa*g1.^beta + g2.^gama - y;

  JF = @(alfa,beta,gama) [g1.^beta , alfa*log(g1).*(g1.^beta), log(g2).*(g2.^gama)];

  X = [5;5;5];
  ak = 1/10;
  i = 0;
  lim = 200;
  error = zeros(lim,1);
  while i<lim
    Ak = JF(X(1),X(2),X(3));
    Yk = y-F(X(1),X(2),X(3));

    [Q,R] = qr(Ak);
    Pk = linsolve(R, transpose(Q)*Yk);

    X = X + ak*Pk;

    i = i + 1;
    error(i) = norm(Yk);

  endwhile

  it = linspace(1,lim,lim);
  figure
  plot(error);

  figure
  plot(t2,F(X(1),X(2),X(3)),'.r', 'markersize',10);
  hold on
  plot(t2,y, '.g', 'markersize',10);

  A = [transpose(t2),F(X(1),X(2),X(3))];



