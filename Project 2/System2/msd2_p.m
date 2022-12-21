function dx = msd2_p(t,x,g1,g2,a,b,u,n)
dx(1) = -a*x(1)+b*u(t);
dx(2) = -x(3)*x(2)+x(4)*u(t);
dx(3) = -g1*(x(1)+n(t)-x(2))*x(2);
dx(4) = g2*(x(1)+n(t)-x(2))*u(t);
dx=dx';
end