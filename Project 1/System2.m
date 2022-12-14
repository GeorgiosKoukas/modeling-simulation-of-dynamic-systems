close all;
clear;

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

function dx = msd2(t, x, RC_inv, LC_inv)

    u1 = @(t) ...
                    2 * sin(t);
    u2 = 1;
    du2 = 0;
    
    dx(1)  = x(2);
    dx(2) = -RC_inv * x(2) - LC_inv * x(1) + RC_inv * du2 + LC_inv * u2 + RC_inv * u1(t);
    
    dx = dx';

end

function e = sim2(p1, p2)
    
    format longG;


    u1= @(t) ...
                    3 * sin(2*t);
    du1 = @(t) ...
                    6 * cos(2*t);
    u2 = 2;
    du2 = 0;

    tspan = [0: 1e-6: 5];

    N = length(tspan);
    state = zeros(N, 2);

   
    
    for i = 1:N
        state_ = v(tspan(i));
        state(i, 1) = state_(1);
        state(i, 2) = state_(2);
    end

    Vc = state(:, 1);
    
    % add random error in measurements
%     Vc(2000000) =  Vc(2000000) + 100 *  Vc(2000000);
%     Vc(2700000) =  Vc(2700000) + 250 *  Vc(2700000);
%     Vc(4700000) =  Vc(4700000) + 50 *  Vc(4700000);

    in1 = double(u1(tspan))';
    in2 = ones(N, 1);

    
    p = [p1, p2];


    z1 = lsim(   tf([-1, 0], [1, p(1) + p(2), p(1) * p(2)]), ... 
                        Vc, ... 
                        tspan'   );

    z2 = lsim(   tf([-1], [1, p(1) + p(2), p(1) * p(2)]), ... 
                        Vc, ...
                        tspan'   );

    z3 = lsim(   tf([1, 0], [1, p(1) + p(2), p(1) * p(2)]), ... 
                        in2, ...
                        tspan'   );
                    
    z4 = lsim(   tf([1], [1, p(1) + p(2), p(1) * p(2)]), ... 
                        in2, ...
                        tspan'   );

    z5 = lsim(  tf([1, 0], [1, p(1) + p(2), p(1) * p(2)]), ... 
                        in1, ...
                        tspan'   );
                    
    z6 = lsim(   tf([1], [1, p(1) + p(2), p(1) * p(2)]), ... 
                        in1, ...
                        tspan'   );

    z = [z1, z2, z3, z4, z5, z6]';

    
    res = mean_sq_err(state, z, 1) + [p(1) + p(2); p(1) * p(2); 0; 0; 0; 0];
    RC_inv = res(1)
    LC_inv = res(2)
    
    [t_, Vc_] = ode45(@(t_, Vc_) msd2(t_, Vc_, RC_inv, LC_inv), tspan, [0, 0]);
    
    
    
    sum = 0;
    for t = 1: N
        sum = sum + abs((Vc(t) - Vc_(t, 1)));
    end
    e = sum / N;
    

    figure(3);
    plot(tspan, Vc, 'Linewidth', 0.1);
    ylabel('system response $V_C(t)$', 'interpreter', 'latex', 'FontWeight', 'bold');
    xlabel('$t(s)$', 'interpreter', 'latex', 'FontWeight', 'bold');
    title('system 2 response', 'interpreter', 'latex', 'FontWeight', 'bold');

end


data = [];
for p1 = 200: 20: 700
    for p2 = p1: 10: 700
        data = [data; p1, p2, sim2(p1, p2)];
    end
end

[min, index] = min(data(:, 3));
p1 = data(index, 1)
p2 = data(index, 2)

fprintf('\n\nSYSTEM 2 \n\n');
err2 = sim2(p1, p2)