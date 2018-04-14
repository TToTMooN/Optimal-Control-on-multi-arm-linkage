function lambdafun = lambdafunction(x, x_plus, lambda, lambda_plus, u, u_plus, h, Q, x_desired)
    f_x = dfdx(x,u);
    f_x_plus = dfdx(x_plus, u_plus);
    lambdafun = 0.5*h*(Q*(x-x_desired)+Q*(x_plus-x_desired)-f_x'*lambda-f_x_plus'*lambda_plus)+(lambda-lambda_plus);
end