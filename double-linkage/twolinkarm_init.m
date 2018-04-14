%% system constants
m1 = 1;
m2 = 1;
l1 = 1;
l2 = 0.8;
% the length is 2l1 and 2l2
J1 = m1*l1^2/3;
J2 = m2*l2^2/3;
g = 9.81;
%g = 0;
%% PD controller constants
Kp1 = 100;
Kp2 = 100;
Kd1 = 50;
Kd2 = 50;
delayTime1 = 0;
delayTime2 = 0;
%% Cost function constants
S = diag([0 0 0 0]);
Q = diag([5 1 5 1]);
R = diag([3 3]);
syms theta1 theta2 theta1dot theta2dot tau1 tau2;
global f A B
H11 = m1*l1^2+J1+m2*(4*l1^2+l2^2+4*l1*l2*cos(theta2))+J2;
H12 = m2*(l2^2+2*l1*l2*cos(theta2))+J2;
H22 = m2*l2^2+J2;
c = -2*m2*l1*l2*sin(theta2);
G1 = m1*g*l1*cos(theta1)+m2*g*(2*l1*cos(theta1)+l2*cos(theta1+theta2));
G2 = m2*g*l2*cos(theta1+theta2);
H = [H11 H12;
    H12 H22];
C = [c*theta2dot^2+2*c*theta1dot*theta2dot;
    c*theta1dot*theta2dot];
G = [G1;
    G2];
U = [tau1;tau2];
qddot = H^(-1)*(U-C-G);
f = symfun([theta1dot; qddot(1); theta2dot; qddot(2)], [theta1 theta1dot theta2 theta2dot tau1 tau2]);
X = [theta1; theta1dot; theta2; theta2dot];
A = symfun(jacobian(f, X),[theta1 theta1dot theta2 theta2dot tau1 tau2]);
B = symfun(jacobian(f, U),[theta1 theta1dot theta2 theta2dot tau1 tau2]);