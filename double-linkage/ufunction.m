function ufun = ufunction(x, lambda, u, R)
    f_u = dfdu(x,u);
    ufun = u + R^(-1)*f_u'*lambda;
end