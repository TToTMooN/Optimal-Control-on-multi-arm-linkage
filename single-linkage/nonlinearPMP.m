clear all;
close all;
clc;

singlePendulum_init;
%% nonlinear iteration solve
tf = 1;
lambda_f = [0;0];

N = 100;
h = tf / (N-1);

x = zeros(4*N,1);

J = zeros(4*N, 4*N);
F = zeros(4*N, 1);

for itr = 1:40
    for ii = 1:(N-1)
        % N-1_theta = x(4*ii-3) N-1_thetaDot = x(4*ii-2) 
        % N-1_lambda1 = x(4*ii-1) N-1_lambda2 = x(4*ii)
        % N_theta = x(4*ii+1) N_thetaDot = x(4*ii+2) 
        % N_lambda1 = x(4*ii+3) N_lambda2 = x(4*ii+4)
        % F update  
        F(4*ii-3) = x(4*ii+1) - x(4*ii-3) - h * 0.5 * ( x(4*ii-2) + x(4*ii+2) ); %0.5h*(N_thetaDot+N-1_thetaDot)
        F(4*ii-2) = x(4*ii+2) - x(4*ii-2) + h * 3*g/(8*l) * ( cos(x(4*ii-3)) + cos(x(4*ii+1)) ) + 0.5 * h * 3 / (4*r*m*l^2) * (x(4*ii) + x(4*ii+4)) ; 
        F(4*ii-1) = x(4*ii+3) - x(4*ii-1) + h * 3*g/(8*l) * ( x(4*ii) * sin(x(4*ii-3)) + x(4*ii+4) * sin(x(4*ii+1))) + 0.5 * h * q1 * ( x(4*ii-3) + x(4*ii+1) - 2 * theta_target ) ;
        F(4*ii)   = x(4*ii+4) - x(4*ii)   + h * 0.5 * ( x(4*ii-1) + x(4*ii+3) ) + 0.5 * h * q2 * ( x(4*ii-2) + x(4*ii+2) - 2 * thetaDot_target ); 
        %J
        J(4*ii-3:4*ii, 4*ii-3:4*ii+4) = ...
        [-1                                         -0.5*h          0             0                          1                                           -0.5*h        0          0;
         -3*h*g/8/l*sin(x(4*ii-3))                  -1              0             0.5*h/r*3/(4*m*l^2)       -3*h*g/8/l*sin(x(4*ii+1))                     1            0          0.5*h/r*3/(4*m*l^2);
         3*h*g/8/l*x(4*ii)*cos(x(4*ii-3))+0.5*h*q1   0             -1             3*h*g/8/l*sin(x(4*ii-3))   3*h*g/8/l*x(4*ii+4)*cos(x(4*ii+1))+0.5*h*q1  0            1          3*h*g/8/l*sin(x(4*ii+1));
         0                                           0.5*q2*h       0.5*h         -1                         0                                            0.5*q2*h     0.5*h      1                      ];
    end
    F(4*N-3:4*N,1) = [x(1,1) - theta_init;
                      x(2,1) - thetaDot_init;
                      x(4*N-1) - s1 * (x(4*N-3) - theta_target);
                      x(4*N)   - s2 * (x(4*N-2) - thetaDot_target)];
                  
    J(4*N-3, 1) = 1;
    J(4*N-2, 2) = 1;
    J(4*N-1, 4*N-1) = 1;
    J(4*N-1, 4*N-3) = -s1;
    J(4*N,   4*N) = 1;
    J(4*N, 4*N-2) = -s2;
    
    x = x - J^(-1) * F;
end

theta = x(1:4:4*N-3);
thetaDot = x(2:4:4*N-2);
lambda1 = x(3:4:4*N-1);
lambda2 = x(4:4:4*N);
u = lambda2*(-3/(4*m*l^2*r));
t = 0:h:tf;
figure(1);
plot(t, theta, t, thetaDot);

%animation
frame_rate = N/tf;
isSaveAnimation = true;
singlePendulum_draw_save_animation(theta, t, isSaveAnimation, frame_rate);