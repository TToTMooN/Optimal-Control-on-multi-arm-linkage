%% define system parameters
g = 9.81; %m/s^2
l = 1; %m
m = 0.1; % kg
%% parameters for optimal control
x_init = [0;0];
theta_init = x_init(1);
thetaDot_init = x_init(2);

target = [pi/3; 0];
theta_target = target(1);
thetaDot_target = target(2);


q1 = 0; 
q2 = 0; % Q = diag([q1 q2])
s1 = 0;
s2 = 0;
r = 5000; % R = [r]
P = 10;