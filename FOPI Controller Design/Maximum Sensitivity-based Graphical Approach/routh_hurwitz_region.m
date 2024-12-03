clc; clear; close all;

% Step 1: Define the transfer function P(s) as P_num(s)/P_den(s)
P_num = [1.194*10^7 4.775*10^4];
P_den = [1 1.111*10^4 7.048*10^5 4170];

%P_num = [-0.125 603];
%P_den = [2.75e-4 5e-3 22.445];

% P_num = [1];
% P_den = [1 1];

% Step 2: Define the transfer function C(s) = kp + ki/s
syms kp ki s;
C = kp + ki/s;

% Step 3: Compute the open-loop transfer function G(s)
G = (poly2sym(P_num, s) / poly2sym(P_den, s)) * C;

% Step 4: Obtain the characteristic equation (denominator of the closed-loop system)
Characteristic_eqn = 1 + G;
Characteristic_eqn = simplify(Characteristic_eqn);

% Step 4.1: Multiply by the denominator of G(s) to clear fractions
[numerator_G, ~] = numden(Characteristic_eqn); % Get numerator
Characteristic_eqn = simplify(numerator_G); % Use the numerator as the polynomial

% Display the polynomial form of the characteristic equation
disp('Polynomial Characteristic Equation:');
disp(Characteristic_eqn);

% Step 5: Find the coefficients of the characteristic equation
coeffs_ce = fliplr(coeffs(Characteristic_eqn, s));

% Step 6: Construct the Routh array manually
n = length(coeffs_ce); % Degree of the polynomial
routh_array = sym(zeros(n, ceil(n/2)));

% Fill the first row of the Routh array
routh_array(1, :) = coeffs_ce(1:2:end);

% Fill the second row of the Routh array
if length(coeffs_ce) > 1
    routh_array(2, 1:length(coeffs_ce(2:2:end))) = coeffs_ce(2:2:end);
end

% Fill the remaining rows of the Routh array
for i = 3:n
    for j = 1:(n-i+1)
        if (j+1) <= size(routh_array, 2)
            routh_array(i,j) = simplify((routh_array(i-1,1)*routh_array(i-2,j+1) - routh_array(i-2,1)*routh_array(i-1,j+1)) / routh_array(i-1,1));
        else
            routh_array(i,j) = 0; % Set to 0 if out of bounds
        end
    end
    
    if all(routh_array(i,:) == 0)
        syms eps;
        routh_array(i,:) = eps * [routh_array(i-2,1:end-1), 0];
    end
end

% Display the Routh array
disp('Routh Array:');
disp(routh_array);

% Define the range for Kp and Ki
kp_vals = linspace(-500, 500, 1000); % Kp values
ki_vals = linspace(-500, 500, 1000); % Ki values

[Ki, Kp] = meshgrid(ki_vals, kp_vals); % Create a grid of Ki and Kp values

% Initialize the feasible region
feasibleRegion = true(size(Kp));

% Loop through each Routh array row and check the inequalities
for i = 1:size(routh_array, 1)
    routh_coeff = matlabFunction(routh_array(i,1), 'Vars', [kp, ki]);
    feasibleRegion = feasibleRegion & (routh_coeff(Kp, Ki) > 0);
end

% Loop through all coefficients of the characteristic equation and check the inequalities
for i = 1:length(coeffs_ce)
    coeff = matlabFunction(coeffs_ce(i), 'Vars', [kp, ki]);
    feasibleRegion = feasibleRegion & (coeff(Kp, Ki) > 0);
end

% Plot the feasible region
figure;
hold on;

% Plot the feasible region
contourf(Kp, Ki, feasibleRegion, [1 1], 'k'); % Only plot where the region is feasible

xlabel('K_i');
ylabel('K_p');
title('Feasible Region for K_p and K_i by R-H criteria');
grid on;

hold off;
