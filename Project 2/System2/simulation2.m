function [y_real,y_hat]=simulation2(g1,g2,u,n)
x0(1:4)=0;
a=1.5;
b=2;
tspan =[0: 0.01: 20];
N = length(tspan);

%x0 = [y0,y_hat, theta1_hat0, theta2_hat0]

[t,real] = ode45(@(t,real) msd2_p(t,real,g1,g2,a,b,u,n),tspan,x0);
y_real = real(:,1);
y_hat = real(:,2);

figure(1)
hold on;
title('Real Output vs Id Output', 'interpreter', 'latex', 'FontWeight', 'bold');
plot(t,y_real)
plot(t,y_hat)
hold off;
a_hat = real(:,3);
b_hat = real(:,4);

figure(2)
hold on;
title('estimated parameters', 'interpreter', 'latex', 'FontWeight', 'bold');
%legend('$\hat{a}$', '$\hat{b}$', 'interpreter', 'latex', 'FontWeight', 'bold');
plot(t,a_hat);
plot(t,b_hat);
hold off;

error_sqrd=(y_real-y_hat).^2;
figure(3);
title('Squared Error', 'interpreter', 'latex', 'FontWeight', 'bold');
plot(t,error_sqrd);

V = 0.5*(y_real-y_hat).^2 + 0.5/g1*((a_hat-a).^2)+0.5/g2*((b_hat-b).^2);
figure(4);
title('Lyapunov Function', 'interpreter', 'latex', 'FontWeight', 'bold');
plot(t,V);


end