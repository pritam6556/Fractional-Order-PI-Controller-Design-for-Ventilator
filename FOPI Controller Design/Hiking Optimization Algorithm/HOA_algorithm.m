 
% function [Best] = HOA_v2(ObjFun, LB, UB, dim, hiker, MaxIter)
%     %% Problem Parameters
%     prob = ObjFun;                  % Objective function
%     nVar = dim;                     % Dimension of problem
%     lb = LB;                        % Lower bound
%     ub = UB;                        % Upper bound
%     nPop = hiker;                   % No. of hikers
%     MaxIt = MaxIter;                % Max iteration
% 
%     %% Pre-allocate
%     fit = zeros(nPop,1);                    % vectorize variable to store fitness value
%     Best.iteration = zeros(MaxIt+1,1);      % vectorize variable store fitness value per iteration
% 
% 
%     %% Start Tobler Hiking Function Optimizer
%     Pop = repmat(lb, nPop, 1) + repmat((ub - lb), nPop, 1) .* rand(nPop, nVar); % Generate initial position of hiker
% 
%     %% Evaluate fitness
%     for q = 1:nPop
%         fit(q) = prob(Pop(q, :));            % Evaluating initial fitness
%     end
%     Best.iteration(1) = min(fit);           % Stores initial fitness value at 0th iteration
% 
%     %% Main Loop
%     for i = 1:MaxIt
%         [~, ind] = min(fit);             % Obtain initial fitness
%         Xbest = Pop(ind, :);             % Obtain global best position of initial fitness
% 
%         for j = 1:nPop
%             Xini = Pop(j, :);              % Obtain initial position of jth hiker
%             theta = randi([0, 50], 1, 1);      % Randomize elevation angle of hiker
%             s = tan(theta);                 % Compute slope
%             SF = randi([1, 2], 1, 1);          % Sweep factor generate either 1 or 2 randomly
%             Vel = 6 .* exp(-3.5 .* abs(s + 0.05)); % Compute walking velocity based on Tobler's Hiking Function
%             newVel = Vel + rand(1, nVar) .* (Xbest - SF .* Xini); % Determine new position of hiker
% 
%             newPop = Pop(j, :) + newVel;     % Update position of hiker
%             newPop = min(ub, newPop);        % Bound violating to upper bound
%             newPop = max(lb, newPop);        % Bound violating to lower bound
% 
%             fnew = prob(newPop);            % Re-evaluate fitness
%             if (fnew < fit(j))              % Apply greedy selection strategy
%                 Pop(j, :) = newPop;          % Store best position
%                 fit(j) = fnew;              % Store new fitness
%             end
%         end
% 
%         Best.iteration(i + 1) = min(fit); % Store best fitness per iteration
%         disp(['Iteration ' num2str(i + 1) ': Best Cost = ' num2str(Best.iteration(i + 1))]);
%         disp(['Optimal Position (Kp, Ki): ' num2str(Pop(ind, :))]);
%     end
% 
%     % THFO Solution: Store global best fitness and position
%     [Best.Hike, idx] = min(fit);
%     Best.Position = Pop(idx, :);
% 
% end

% function [Best] = HOA_v2(ObjFun, LB, UB, dim, hiker, MaxIter)
%     %% Problem Parameters
%     prob = ObjFun;                  % Objective function
%     nVar = dim;                     % Dimension of problem
%     lb = LB;                        % Lower bound
%     ub = UB;                        % Upper bound
%     nPop = hiker;                   % No. of hikers
%     MaxIt = MaxIter;                % Max iteration
% 
%     %% Pre-allocate
%     fit = zeros(nPop, 1);                    % Vectorize variable to store fitness value
%     Best.iteration = zeros(MaxIt + 1, 1);    % Vectorize variable store fitness value per iteration
%     costHistory = [];                        % Matrix to store [ki, kp, cost] values
% 
%     %% Start Tobler Hiking Function Optimizer
%     Pop = repmat(lb, nPop, 1) + repmat((ub - lb), nPop, 1) .* rand(nPop, nVar); % Generate initial position of hiker
% 
%     %% Evaluate fitness
%     for q = 1:nPop
%         fit(q) = prob(Pop(q, :));            % Evaluating initial fitness
%         costHistory = [costHistory; Pop(q, 2), Pop(q, 1), fit(q)]; % Store initial ki, kp, and cost
%     end
%     Best.iteration(1) = min(fit);            % Stores initial fitness value at 0th iteration
% 
%     %% Main Loop
%     for i = 1:MaxIt
%         [~, ind] = min(fit);                 % Obtain initial fitness
%         Xbest = Pop(ind, :);                 % Obtain global best position of initial fitness
% 
%         for j = 1:nPop
%             Xini = Pop(j, :);                % Obtain initial position of jth hiker
%             theta = randi([0, 50], 1, 1);    % Randomize elevation angle of hiker
%             s = tan(theta);                  % Compute slope
%             SF = randi([1, 2], 1, 1);        % Sweep factor generate either 1 or 2 randomly
%             Vel = 6 .* exp(-3.5 .* abs(s + 0.05)); % Compute walking velocity based on Tobler's Hiking Function
%             newVel = Vel + rand(1, nVar) .* (Xbest - SF .* Xini); % Determine new position of hiker
% 
%             newPop = Pop(j, :) + newVel;     % Update position of hiker
%             newPop = min(ub, newPop);        % Bound violating to upper bound
%             newPop = max(lb, newPop);        % Bound violating to lower bound
% 
%             fnew = prob(newPop);             % Re-evaluate fitness
%             costHistory = [costHistory; newPop(2), newPop(1), fnew]; % Store ki, kp, and cost
% 
%             if (fnew < fit(j))               % Apply greedy selection strategy
%                 Pop(j, :) = newPop;          % Store best position
%                 fit(j) = fnew;               % Store new fitness
%             end
%         end
% 
%         Best.iteration(i + 1) = min(fit);    % Store best fitness per iteration
%         disp(['Iteration ' num2str(i + 1) ': Best Cost = ' num2str(Best.iteration(i + 1))]);
%         disp(['Optimal Position (Kp, Ki, Lambda): ' num2str(Pop(ind, :))]);
%     end
% 
%     % THFO Solution: Store global best fitness and position
%     [Best.Hike, idx] = min(fit);
%     Best.Position = Pop(idx, :);
% 
%     %% Plotting the cost function history
%     % figure;
%     % scatter3(costHistory(:, 2), costHistory(:, 1), costHistory(:, 3), 'filled');
%     % xlabel('Kp');
%     % ylabel('Ki');
%     % zlabel('Cost');
%     % title('Cost Function Evolution');
%     % grid on;
% end

function [Best] = HOA_v2(ObjFun, LB, UB, dim, hiker, MaxIter)
    %% Problem Parameters
    prob = ObjFun;                  % Objective function
    nVar = dim;                     % Dimension of problem
    lb = LB;                        % Lower bound
    ub = UB;                        % Upper bound
    nPop = hiker;                   % No. of hikers
    MaxIt = MaxIter;                % Max iteration

    %% Pre-allocate
    fit = zeros(nPop, 1);                    % Vectorize variable to store fitness value
    Best.iteration = zeros(MaxIt + 1, 1);    % Vectorize variable to store fitness value per iteration
    costHistory = [];                        % Matrix to store [ki, kp, lambda, cost] values

    %% Start Tobler Hiking Function Optimizer
    Pop = repmat(lb, nPop, 1) + repmat((ub - lb), nPop, 1) .* rand(nPop, nVar); % Generate initial position of hikers

    %% Evaluate initial fitness
    for q = 1:nPop
        fit(q) = prob(Pop(q, :));            % Evaluating initial fitness
        costHistory = [costHistory; Pop(q, 2), Pop(q, 1), Pop(q, 3), fit(q)]; % Store initial ki, kp, lambda, and cost
    end
    Best.iteration(1) = min(fit);            % Store initial fitness value at 0th iteration

   %% Main Loop
    for i = 1:MaxIt
        [Best.iteration(i + 1), ind] = min(fit); % Find the minimum fitness after updating all hikers
        Xbest = Pop(ind, :);                    % Update the global best position
    
        % Display the best cost and position at each iteration with higher precision
        disp(['Iteration ' num2str(i + 1) ': Best Cost = ' sprintf('%.10f', Best.iteration(i + 1))]);
        disp(['Optimal Position (Kp, Ki, Lambda): ' sprintf('%.10f ', Xbest)]);
        
        for j = 1:nPop
            Xini = Pop(j, :);                   % Obtain initial position of jth hiker
            theta = randi([0, 50], 1, 1);       % Randomize elevation angle of hiker
            s = tan(theta);                     % Compute slope
            SF = randi([1, 2], 1, 1);           % Sweep factor generate either 1 or 2 randomly
            Vel = 6 .* exp(-3.5 .* abs(s + 0.05)); % Compute walking velocity based on Tobler's Hiking Function
            newVel = Vel + rand(1, nVar) .* (Xbest - SF .* Xini); % Determine new position of hiker
    
            newPop = Pop(j, :) + newVel;        % Update position of hiker
            newPop = min(ub, newPop);           % Bound violating to upper bound
            newPop = max(lb, newPop);           % Bound violating to lower bound
    
            fnew = prob(newPop);                % Re-evaluate fitness
            costHistory = [costHistory; newPop(2), newPop(1), newPop(3), fnew]; % Store ki, kp, lambda, and cost
    
            if (fnew < fit(j))                  % Apply greedy selection strategy
                Pop(j, :) = newPop;             % Store best position
                fit(j) = fnew;                  % Store new fitness
            end
        end
    end


    % THFO Solution: Store global best fitness and position
    [Best.Hike, idx] = min(fit);
    Best.Position = Pop(idx, :);

    %% Plotting all Kp, Ki, and Lambda values with cost as color
    figure;
    scatter3(costHistory(:, 2), costHistory(:, 1), costHistory(:, 3), 50, costHistory(:, 4), 'filled'); 
    xlabel('Kp');
    ylabel('Ki');
    zlabel('Lambda');
    title('Explored Points with Cost Function Values');
    colorbar; % Adds a color scale to show the range of cost values
    
    % Reverse the colormap to make lower costs appear darker
    colormap(flipud(jet)); % Flip the 'jet' colormap to make darker colors represent lower cost values
    caxis([min(costHistory(:, 4)), max(costHistory(:, 4))]); % Set the color axis range to cost range

    grid on;
end
