function  [t_settling,max_e,mse]= simulation1(gamma,am,u)
%Simulating The Real Output
x0(1:6)=0;
a=1.5;
b=2;

tspan =[0: 0.01: 50];
N = length(tspan);
%Initializing Arrays of estimated parameters:
a_hat = zeros(N,1);
b_hat = zeros(N,1);

%x0 = [y0, theta1_hat0, theta2_hat0, phi1_0, phi2_0, y_hat0]

[t,real] = ode45(@(t,real) md1(t,real,am,gamma,a,b,u),tspan,x0);
y_real = real(:,1);
y_hat = real(:,6);


error=abs((real(:,1)-real(:,6))./real(:,1));

a_hat = am - real(:,2);
b_hat = real(:,3);


max_e = 0;
for i = 1: length(y_real)
    e_ = (y_real(i)-y_hat(i))^2;
    if e_ > max_e
        max_e = e_;
    end
end
t_settling = -1;
for i=1:length(error)
    if (t_settling <0 && error(i)<0.05)
        t_settling = tspan(i);
    end
    if error(i)>0.05
        t_settling = -1;
    end
end
%Mean Squared Error
sum=0;
for g=1:length(y_real)
    sum = sum + (y_real(g)-y_hat(g))^2;
end
mse = sum/length(y_real);
%Plots
figure(1);  
plot(t,real(:,1),t,real(:,6));
title('Real Output vs Id Output', 'interpreter', 'latex', 'FontWeight', 'bold');
figure(2);
hold on;
plot(a_hat);
plot(b_hat);
title('estimated parameters', 'interpreter', 'latex', 'FontWeight', 'bold');
legend('$\hat{a}$', '$\hat{b}$', 'interpreter', 'latex', 'FontWeight', 'bold');
hold off;
figure(3);
plot(t,error);
title('Error (%)', 'interpreter', 'latex', 'FontWeight', 'bold');
figure(4);
plot(t,(y_real-y_hat).^2)
title('Squared Error', 'interpreter', 'latex', 'FontWeight', 'bold');

end










