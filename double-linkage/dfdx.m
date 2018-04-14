function f_x = dfdx(x, u)
    global A
    f_x = double(A(x(1),x(2),x(3),x(4),u(1),u(2)));
end