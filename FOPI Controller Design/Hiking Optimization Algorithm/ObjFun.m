% Objective Function
function f = ObjFun(x)
    % Define the controller transfer function for Simulink model
    Kp = x(1);
    Ki = x(2);
    Lambda = x(3);

    % Set the parameters in the MATLAB workspace
    assignin('base', 'Kp', Kp);
    assignin('base', 'Ki', Ki);
    assignin('base', 'Lambda', Lambda);

    % Simulate the Simulink model
    sim('ISE');

    % Extract the last value of y1
    f = y6(end);
end




% Objective Function
% function f = ObjFun(x)
%     % Initialize symbolic variables
%     syms s t real
% 
%     % Define the plant transfer function
%     num_plant = [1.194*10^7, 4.775*10^4];
%     den_plant = [1, 1.111*10^4, 7.048*10^5, 4170];
%     P_s = poly2sym(num_plant, s) / poly2sym(den_plant, s);
% 
%     % Define the controller transfer function
%     K_p = x(1);
%     K_i = x(2);
%     num_controller = [K_p, K_i];
%     den_controller = [1];
%     C_s = poly2sym(num_controller, s) / poly2sym(den_controller, s);
% 
%     % Open-loop transfer function
%     G_s = C_s * P_s;
% 
%     % Reference input R(s), for a unit step input R(s) = 1/s
%     R_s = 1/s;
% 
%     % Error signal E(s)
%     E_s_sym = R_s / (1 + G_s);
% 
%     % Inverse Laplace Transform to get e(t)
%     e_t = ilaplace(E_s_sym, s, t);
% 
%     % Define the absolute error |e(t)|
%     e_t_absolute = abs(e_t);
% 
%     % Integrate |e(t)| from t = 0 to a large number to approximate infinity
%     integral_result = int(e_t_absolute, t, 0, 1);  % Approximating infinity with 1000
% 
%     % Convert the symbolic integral result to a numeric value and scale if needed
%     f = 1e10 * double(integral_result);
% end

% % Objective Function
% function f = ObjFun(x)
%     % Initialize symbolic variables
%     syms s t real
% 
%     % Define the plant transfer function
%     num_plant = [1.194*10^7, 4.775*10^4];
%     den_plant = [1, 1.111*10^4, 7.048*10^5, 4170];
%     P_s = poly2sym(num_plant, s) / poly2sym(den_plant, s);
% 
%     % Define the controller transfer function
%     K_p = x(1);
%     K_i = x(2);
%     num_controller = [K_p, K_i];
%     den_controller = [1,0];
%     C_s = poly2sym(num_controller, s) / poly2sym(den_controller, s);
% 
%     % Open-loop transfer function
%     G_s = C_s * P_s;
% 
%     % Reference input R(s), for a unit step input R(s) = 1/s
%     R_s = 25/s;
% 
%     % Error signal E(s)
%     E_s_sym = R_s / (1 + G_s);
% 
%     % Inverse Laplace Transform to get e(t)
%     e_t = ilaplace(E_s_sym, s, t);
% 
%     % Define the squared error e(t)^2
%     e_t_squared = e_t^2;
% 
%     % Integrate e(t)^2 from t = 0 to a large number to approximate infinity
%     integral_result = int(1e10*e_t_squared, t, 0, 1);  % Approximating infinity with 1000
% 
%     % Convert the symbolic integral result to a numeric value
%     f = double(integral_result);
% end

% Objective Function
% function f = ObjFun(x)
%     % Initialize symbolic variables
%     syms s t real
% 
%     % Define the plant transfer function
%     num_plant = [1.194*10^7, 4.775*10^4];
%     den_plant = [1, 1.111*10^4, 7.048*10^5, 4170];
%     P_s = poly2sym(num_plant, s) / poly2sym(den_plant, s);
% 
%     % Define the controller transfer function
%     K_p = x(1);
%     K_i = x(2);
%     num_controller = [K_p, K_i];
%     den_controller = [1];
%     C_s = poly2sym(num_controller, s) / poly2sym(den_controller, s);
% 
%     % Open-loop transfer function
%     G_s = C_s * P_s;
% 
%     % Reference input R(s), for a unit step input R(s) = 1/s
%     R_s = 1/s;
% 
%     % Error signal E(s)
%     E_s_sym = R_s / (1 + G_s);
% 
%     % Inverse Laplace Transform to get e(t)
%     e_t = ilaplace(E_s_sym, s, t);
% 
%     % Define the absolute error |e(t)|
%     e_t_absolute = abs(e_t);
% 
%     % Integrate |e(t)| from t = 0 to a large number to approximate infinity
%     integral_result = int(e_t_absolute, t, 0, 3);  % Approximating infinity with 1000
% 
%     % Convert the symbolic integral result to a numeric value and scale if needed
%     f = 1e10 * double(integral_result);
% end

% % Objective Function
% function f = ObjFun(x)
%     % Initialize symbolic variables
%     syms s t real
% 
%     % Define the plant transfer function
%     num_plant = [1.194*10^7, 4.775*10^4];
%     den_plant = [1, 1.111*10^4, 7.048*10^5, 4170];
%     P_s = poly2sym(num_plant, s) / poly2sym(den_plant, s);
% 
%     % Define the controller transfer function
%     K_p = x(1);
%     K_i = x(2);
%     num_controller = [K_p, K_i];
%     den_controller = [1];
%     C_s = poly2sym(num_controller, s) / poly2sym(den_controller, s);
% 
%     % Open-loop transfer function
%     G_s = C_s * P_s;
% 
%     % Reference input R(s), for a unit step input R(s) = 1/s
%     R_s = 1/s;
% 
%     % Error signal E(s)
%     E_s_sym = R_s / (1 + G_s);
% 
%     % Inverse Laplace Transform to get e(t)
%     e_t = ilaplace(E_s_sym, s, t);
% 
%     % Define the absolute error |e(t)|
%     e_t_absolute = abs(e_t);
% 
%     % Numerically integrate |e(t)| from t = 0 to t = 1000 using vpaintegral
%     result = vpaintegral(e_t_absolute, t, 0, 3);
% 
%     % Convert the result to a numeric value and scale if needed
%     f = 1e10 * double(result);
% end
