clear;
close all;
addpath("System1");
addpath("System2");
addpath("System3");
%Exercise 1
%u = @(t) 3*cos(2*t);
% gammaspan=(1:10);
% amspan=(1:10);
%u = @(t) 3;
% [tset,e_max]=simulation1(10,6,u);
% tset_all=zeros(10,10);
% e_max_all=zeros(10,10);
% mse_all=zeros(10,10);
% i--gamma, y--am
%  for l = gammaspan
%      for m = amspan
% [tset_all(l,m),max_error_all(l,m),mse_all(l,m)]=simulation1(l,m,u);
%      end
%  end
%  
%  plot3(gammaspan,amspan,mse_all);
% 
%[tset_1,max_error_1,mse_1] = simulation1(10,10,u);



%Exercise 2 - Parallel Structure
%  h0=0.25;
%  f=100;
%  n = @(t) h0*sin(2*pi*f*t);
 %n = @(t) 0;
 %[y_1,y_hatt_1]=simulation2(10,10,u,n);

%Exercise 3 = Mixed Structure
% h0=0.25;
% f=30;
% n = @(t) h0*sin(2*pi*f*t);
% % n = @(t) 0;
%  theta_m=10;
%  [y_2,y_hatt_2]=simulation3(10,10,u,n,theta_m);

%Exercise 4 
 u = @(t) 7.5*cos(3*t)+10*cos(2*t);
% t_set_all=zeros(40,40);
% for p=1:5:40
%     for o=1:40
%     [t_set_all(p,o),error_all,y_hatt_1]=simulation4(p,o,u);
%     end
% end
[t_set,error_all,y_hatt_1]=simulation4(4,11,u);



    
    


        