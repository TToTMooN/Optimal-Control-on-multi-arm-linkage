function xfun = xfunction(x, x_plus, u, u_plus, h)
    xfun = 0.5*h*(f_function(x_plus,u_plus)+f_function(x,u))+(x_plus-x);
end