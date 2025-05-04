% XOR gate

% Define Inputs
X = [0 0; 0 1; 1 0; 1 1];

% Define outputs for XOR gate
T = [0; 1; 1; 0];

% Add bias to inputs
X = [-ones(4,1) X];

% Initialize weights randomly
W = 2*rand(3, 1) - 1;

% Learning rate
lr = 0.1;

% Limit iterations (XOR won't converge with a single-layer perceptron)
maxIterations = 20;
iteration = 1;

while iteration <= maxIterations
    converged = true;

    % Training loop
    for inputNo = 1:4
        Y = (X(inputNo, :) * W > 0);
        errorValue = T(inputNo) - Y;

        if errorValue ~= 0
            converged = false;
            deltaW = errorValue * X(inputNo, :)';
            W = W + lr * deltaW;
        end
    end

    % Create test set for visualization
    TestSet = zeros(121, 3);
    index = 1;
    for i = 0:0.1:1
        for j = 0:0.1:1
            TestSet(index, :) = [-1, j, i]; % Bias = -1
            index = index + 1;
        end
    end

    TestResult = (TestSet * W) > 0;
    Group0 = find(TestResult == 0);
    Group1 = find(TestResult == 1);

    % Plot in new figure for every iteration
    figure(iteration);
    hold on;
    grid on;

    % Plot regions and store handles
    h0 = plot(TestSet(Group0, 2), TestSet(Group0, 3), 'ro', 'MarkerFaceColor', 'r');
    h1 = plot(TestSet(Group1, 2), TestSet(Group1, 3), 'go', 'MarkerFaceColor', 'g');

    % Initialize plot handles for training points
    h2 = []; h3 = [];

    for i = 1:4
        if T(i) == 0
            h2 = plot(X(i,2), X(i,3), 'rx', 'MarkerSize', 10, 'LineWidth', 2);
        else
            h3 = plot(X(i,2), X(i,3), 'gx', 'MarkerSize', 10, 'LineWidth', 2);
        end
    end

    % Title and axis labels
    title(['Perceptron XOR Gate - Iteration ', num2str(iteration)]);
    xlabel('x1');
    ylabel('x2');
    axis([0 1 0 1]);

    % Use plot handles in the legend
    legend([h0, h1, h2, h3], ...
           {'Class 0 Region', 'Class 1 Region', 'Class 0 Point', 'Class 1 Point'}, ...
           'Location', 'northeastoutside');

    hold off;
    iteration = iteration + 1;
end
