clear all; close all; clc;
twolinkarm_init;

%% initialize
q_desired = [pi/2;2*pi/3;0;0]; %desired end state
q_init = [-pi/4;-pi/4;0;0]; %initial simulation state

%choose a shorter path for angles
for ii=1:2
    if abs(q_init(ii)-q_desired(ii)) > abs(2*pi-(q_init(ii)-q_desired(ii)))
        q_desired(ii)  = q_desired(ii) + 2*pi;
    end
end

tf = 5;
N = 100;
h = tf / (N-1);
Y = zeros(10*N,1);

J = zeros(10*N, 10*N);
F = zeros(10*N, 1);

for itr_time = 1:10
    for n = 1:(N-1)
        %define F
        n_start = 10*(n-1)+1;
        n_end = 10*n;
        n_plus_start = n_start+10;
        n_plus_end = n_end+10;
        Z = Y(n_start:n_end);
        Z_plus = Y(n_plus_start:n_plus_end);
        x = Z(1:4);
        x_plus = Z_plus(1:4);
        lambda = Z(5:8);
        lambda_plus= Z_plus(5:8);
        u = Z(9:10);
        u_plus = Z_plus(9:10);
        F(n_start:n_start+1) = ufunction(x, lambda, u, R); 
        F(n_start+2:n_start+5) = xfunction(x, x_plus, u, u_plus, h);
        F(n_start+6:n_start+9) = lambdafunction(x, x_plus, lambda, lambda_plus, u, u_plus, h, q_desired);
        %define J
        J(n_start:n_start+1,n_start:n_start+3) = dufundx(x, lambda, u, R);
        J(n_start:n_start+1,n_start+4:n_start+7) = dufundlambda(x, lambda, u, R);
        J(n_start:n_start+1,n_start+8:n_start+9) = dufundu(x, lambda, u, R);
        J(n_start+2:n_start+5,n_start:n_start+3) = dxfundx(x, x_plus, u, u_plus, h);
        J(n_start+2:n_start+5,n_start+4:n_start+7) = dxfundlambda(x, x_plus, u, u_plus, h);
        J(n_start+2:n_start+5,n_start+8:n_start+9) = dxfundu(x, x_plus, u, u_plus, h);
        J(n_start+6:n_start+9,n_start:n_start+3) = dlambdafundx(x, x_plus, lambda, lambda_plus, u, u_plus, h, q_desired);
        J(n_start+6:n_start+9,n_start+4:n_start+7) = dlambdafundlambda(x, x_plus, lambda, lambda_plus, u, u_plus, h, q_desired);
        J(n_start+6:n_start+9,n_start+8:n_start+9) = dlambdafundu(x, x_plus, lambda, lambda_plus, u, u_plus, h, q_desired);
    end
    %Last n functions F
    xn = Y(10*N-9:10*N-6);
    lambdan = Y(10*N-5:10*N-2);
    un = Y(10*N-1:10*N);
    F(10*N-9:10*N-8) = ufunction(xn, lambdan, un, R);
    x1 = Y(1:4);
    F(10*N-7:10*N-4) = x1-q_init;
    F(10*N-3:10*N) = S*(xn-q_desired);
    %Last part of J
    
    %iterate
%     X = X - J^(-1)*F;
end
%%