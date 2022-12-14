close all;
clear;
function dx = msd1(t, x, m, b, k, u)

    dx(1)  = x(2);
    dx(2) = (1 / m) * (- k * x(1) -b * x(2) + u(t));
    
    dx = dx';

end
function theta = mean_sq_err(state, z, dim)
  


    sum1 = 0;
    sum2 = 0;

    N = length(state);

    for i = 1:N
        sum1 = sum1 + z(:, i) * z(:, i)';
        sum2 = sum2 + z(:, i) * state(i, dim);
    end

    sum1 = sum1 / N;
    sum2 = sum2 / N;
    
    theta = sum1 \ sum2;
    
end


function e = sim1(p1, p2)  


    format longG;
    close all;

    
    m = 10;
    k = 1.5;
    b = 0.3;
    u = @(t) ...
           10 * sin(3 * t) + 15;

    
    x0(1) = 0;
    x0(2) = 0;
    tspan = [0: 0.1: 10];

    
    [t, state] = ode45(@(t, state) msd1(t, state, m, b, k, u), tspan, x0);

    
    in = u(t(:));

   

   
    p = [p1, p2];

    
    syms b_;
    syms m_;
    syms k_;

    
    theta_ = [  b_ / m_ - (p(1) + p(2)); ...
                        k_ / m_ - (p(1) * p(2)); ... 
                        1 / m_  ];

   
    z1 = lsim(   tf([-1, 0], [1, p(1) + p(2), p(1) * p(2)]), ... 
                        state(:, 1), ... 
                        t   );

    z2 = lsim(   tf([-1], [1, p(1) + p(2), p(1) * p(2)]), ... 
                        state(:, 1), ...
                        t   );

    z3 = lsim(   tf([1], [1, p(1) + p(2), p(1) * p(2)]), ... 
                        in, ...
                        t   );

    z = [z1, z2, z3]';

    
    eq = theta_ == mean_sq_err(state, z, 1);
    sol = solve(eq, [m_, b_, k_]);
    m__ = double(sol.m_)
    b__ = double(sol.b_)
    k__ = double(sol.k_)

    res = [m__, b__, k__];
    
    e = abs((m - m__) / m) + abs((b - b__) / b) + abs((k - k__) / k);


    [t__, state__] = ode45(@(t__, state__) msd1(t__, state__, m__, b__, k__, u), tspan, x0);
    
    err = zeros(length(state), 1);    
    for i = 1:length(state)
       err(i) = abs((state(i, 1) - state__(i, 1)) / state(i, 1));
    end

   
    figure(1);
    plot(t, err, 'Linewidth', 1);
    ylabel('$\big| \frac{y(t) - \hat{y}(t)}{y(t)} \big|$', 'interpreter', 'latex', 'FontWeight', 'bold');
    xlabel('$t(s)$', 'interpreter', 'latex', 'FontWeight', 'bold');
    title('system 1 output error \% for selected $p_1, \; p_2$', 'interpreter', 'latex', 'FontWeight', 'bold');
    
    figure(2);
    plot(t, state(:, 1), 'Linewidth', 1);
    ylabel('system response $y(t)$', 'interpreter', 'latex', 'FontWeight', 'bold');
    xlabel('$t(s)$', 'interpreter', 'latex', 'FontWeight', 'bold');
    title('system 1 response', 'interpreter', 'latex', 'FontWeight', 'bold');
    
    
   
    
end

data = [];
for p1 = 0.1: 0.2: 1
    for p2 = p1: 0.2: 1
        data = [data; p1, p2, sim1(p1, p2)];
    end
end

[min, index] = min(data(:, 3));
p1 = data(index, 1)
p2 = data(index, 2)
sim1(p1, p2)



