function [t_settling,error_sqrd,y_hat1]=simulation4(g1,g2,u)
x0(1:10)=0;
A=[-0.5 -3;4 -2];
B=[1;1.4];
tspan =[0: 0.01: 150];
N = length(tspan);

%x0 = [y0,y_hat, theta1_hat0, theta2_hat0]

[t,real] = ode45(@(t,real) msd4_p(t,real,g1,g2,A,B,u),tspan,x0);
y_real1 = real(:,1);
y_real2 = real(:,2);
y_hat1 = real(:,9);
y_hat2 = real(:,10);
%x = [y1, y2, a11_hat, a12_hat, a21_hat, a22_hat, b1_hat, b2_hat, y1_hat, y2_hat]
%error=sqrt(abs(((y_real1-y_hat1)./y_real1).^2+((y_real2-y_hat2)./y_real2).^2));
error_sqrd=(y_real1-y_hat1).^2+(y_real2-y_hat2).^2;
t_settling=-1;
for i=1:length(error_sqrd)
    if (t_settling <0 && error_sqrd(i)<0.001)
        t_settling = tspan(i);
    end
    if error_sqrd(i)>0.05
        t_settling = -1;
    end
end
figure(1)
hold on;
plot(t,y_real1,'-r')
plot(t,y_real2,'-r')
plot(t,y_hat1,'-g')
plot(t,y_hat2,'-g')
title('Real Output vs Id Output', 'interpreter', 'latex', 'FontWeight', 'bold');
hold off;
a11_hat = real(:,3);
a12_hat = real(:,4);
a21_hat = real(:,5);
a22_hat = real(:,6);
b1_hat = real(:,7);
b2_hat = real(:,8);
figure(2)
hold on;
plot(a11_hat);
plot(a12_hat);
plot(a21_hat);
plot(a22_hat);
plot(b1_hat);
plot(b2_hat);
title('estimated parameters', 'interpreter', 'latex', 'FontWeight', 'bold');
legend('$\hat{a_{11}}$', '$\hat{a_{12}}$', '$\hat{a_{21}}$', '$\hat{a_{22}}$', '$\hat{b_1}$', '$\hat{b_2}$', 'interpreter', 'latex', 'FontWeight', 'bold');

hold off;


figure(3)
plot(error_sqrd);
title('Squared Error', 'interpreter', 'latex', 'FontWeight', 'bold');
legend('$(y_1-\hat{y_1})^2 + (y_2-\hat{y_2})^2$', 'interpreter', 'latex', 'FontWeight', 'bold');




end