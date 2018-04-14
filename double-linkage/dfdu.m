function f_u = dfdu(x, u)
%% system f
global B
f_u = double(B(x(1),x(2),x(3),x(4),u(1),u(2)));
end