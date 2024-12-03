clear; clc;

% Problem parameters
nVar = 3;  % Number of variables (Kp and Ki)
LB = [0.01, 0.01, 0.01];       % Lower bounds for Kp and Ki
UB = [10000, 10000, 1.2];  % Upper bounds for Kp and Ki

% HOA parameters
nHiker = 100;      % Number of hikers
MaxItr = 150;    % Maximum number of iterations

% Run HOA algorithm to find optimal beta (position) with the lowest fitness
Best = HOA_v2(@ObjFun, LB, UB, nVar, nHiker, MaxItr);

% Display the optimal position (beta) and best objective function value found
fprintf('\nOptimal Position (Beta): \n');
disp(Best.Position);
fprintf('Objective Function Value at Optimal Position: %.4f\n', Best.Hike);
