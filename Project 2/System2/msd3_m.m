function dx = msd3_m(t,x,g1,g2,a,b,u,n,theta_m)
dx(1) = -a*x(1)+b*u(t);
dx(2) = -x(3)*x(1)+x(4)*u(t)+theta_m*(x(1)+n(t)-x(2));
dx(3) = -g1*(x(1)+n(t)-x(2))*x(2);
dx(4) = g2*(x(1)+n(t)-x(2))*u(t);
dx=dx';
end