clear all; close all; clc;
twolinkarm_init;

%% initialize
q_desired = [0;0;0;0]; %desired end state
q_init = [-pi/2;0;0;0]; %initial simulation state

%choose a shorter path for angles
for ii=1:2
    if abs(q_init(ii)-q_desired(ii)) > abs(2*pi-(q_init(ii)-q_desired(ii)))
        q_desired(ii)  = q_desired(ii) + 2*pi;
    end
end

x_size = 4;
u_size = 2;

S = diag([0 0 0 0 ]);
Q = diag([100 0 100 0 ]);
R = diag([3 3]);

tf = 5;
tstep = 0.01;
T = 0:tstep:tf;
size = tf/tstep + 1;
x = zeros(4,size);
u = zeros(2,size);
x(1:4,1) = q_init;
global A B;
for t=1:size-1
    A_corr = double(A(x(1,t),x(2,t),x(3,t),x(4,t),u(1,t),u(2,t)));
    B_corr = double(B(x(1,t),x(2,t),x(3,t),x(4,t),u(1,t),u(2,t)));
    f_corr = double(f(x(1,t),x(2,t),x(3,t),x(4,t),u(1,t),u(2,t)));
    C_corr = f_corr - A_corr*x(1:4,t) - B_corr*u(:,t);
    %A_corr = [A_lin C_corr;
    %          zeros(1,x_size+1)];
    %B_corr = [B_lin;
    %          zeros(1,u_size)];
    [K,~,~] = lqr(A_corr, B_corr, Q, R);
    %K = R^(-1)*B_corr'*S_corr;
    u(:,t+1) = -K*x(:,t);
    x(:,t+1) = expm((A_corr-B_corr*K)*tstep)*x(:,t);
end
q_data = x(1:4,:);
twolinkarm_draw_save_animation(q_data', T', true);