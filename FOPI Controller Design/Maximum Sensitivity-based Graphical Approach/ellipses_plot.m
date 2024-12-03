% Clear workspace and command window
clear; clc; close all;

% Define symbolic variables
syms s w Kp Ki real;

% Define the transfer function
num = [1.194*10^7 4.775*10^4];
den = [1 1.111*10^4 7.048*10^5 4170];


% Convert transfer function to symbolic form
P_s = poly2sym(num, s) / poly2sym(den, s);
P_jw = subs(P_s, s, 1i*w); % Substitute s with jw

% Parameters
r = 2; % Radius of the ellipse
lambda = 0.8; % Order of the fractional PI controller

% Real and imaginary parts of P(jw)
P_r_jw = real(P_jw); % Real part of P(jw)
P_i_jw = imag(P_jw)/w; % Imaginary part of P(jw) divided by w

% Fractional-Order PI Controller in frequency domain
C = Kp + Ki*(cos(pi*lambda/2) - 1i*sin(pi*lambda/2))/w^lambda;

% Inequality for stability
inequality = (1 + (P_r_jw + 1i*w*P_i_jw) * C);

% Separate real and imaginary parts of the inequality
Re_part = real(inequality);
Im_part = imag(inequality);

% Ellipse Equation
ellipse_equation = Re_part^2 - 1/(r^2) + Im_part^2;

% Define range for w
w_values = linspace(1, 25000, 500); 

% Initialize figure
figure;
hold on;
xlabel('Ki'); 
ylabel('Kp'); 
title('Set of Ellipses for different \omega for \lambda = 0.8')
grid on;

% Loop over w values and plot ellipses
for w_val = w_values
    % Substitute w value into ellipse equation
    ellipse_eq_w = subs(ellipse_equation, w, w_val);
    
    % Convert symbolic to numeric function
    ellipse_fn = matlabFunction(ellipse_eq_w, 'Vars', [Ki, Kp]);
    
    % Plot the contour (ellipse) where ellipse_eq_w = 0
    fimplicit(@(Ki, Kp) ellipse_fn(Ki, Kp), [-1e15, 1e15, -1e15, 1e15],'LineWidth', 1);
end

ylim([-10, 80]);
xlim([-1e5/4.9, 2e5]);
% Adjust axis limits automatically based on the plot

hold off;
