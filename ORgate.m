% OR gate

% Define Inputs
X = [0 0; 0 1; 1 0; 1 1];

% Define outputs for OR gate
T = [0; 1; 1; 1];

% Add bias to inputs
X = [-ones(4,1) X];

% Initialize weights randomly
W = 2*rand(3, 1) - 1;

% Learning rate
lr = 0.1;

% Training
converged = false;
iteration = 1;

while ~converged
    converged = true;

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
    plot(TestSet(Group0, 2), TestSet(Group0, 3), 'ro', 'MarkerFaceColor', 'r');
    plot(TestSet(Group1, 2), TestSet(Group1, 3), 'go', 'MarkerFaceColor', 'g');

    % Also plot the training inputs
    for i = 1:4
        if T(i) == 0
            plot(X(i,2), X(i,3), 'rx', 'MarkerSize', 10, 'LineWidth', 2);
        else
            plot(X(i,2), X(i,3), 'gx', 'MarkerSize', 10, 'LineWidth', 2);
        end
    end

    title(['Perceptron OR Gate - Iteration ', num2str(iteration)]);
    xlabel('x1');
    ylabel('x2');
    axis([0 1 0 1]);
    legend('Class 0 Region','Class 1 Region','Class 0 Point','Class 1 Point');
    hold off;

    iteration = iteration + 1;
end
