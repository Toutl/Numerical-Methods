%% Approximations of the exponential function by power series
% Ubaldo Neri
% https://github.com/Toutl

% Cleaning the programming environment
clc; clear; close all;

% Initial variables
x = 0.756199;
tolerance = 0.001;
max_iterations = 50;

% Initialization
approximation = 0;
iteration = 0;
error = inf;
results = [];

% Iterative calculation
while error > tolerance && iteration <= max_iterations
    term = x^iteration / factorial(iteration);
    previous_approx = approximation;
    approximation = approximation + term;

    if iteration == 0
        error = NaN;
    else
        error = abs((approximation - previous_approx) / approximation) * 100;
    end

    results = [results; iteration, term, approximation, error];  %#ok<AGROW>
    iteration = iteration + 1;
end

% Show results
header = ["Iteration", "Term", "Approximation", "Relative Error"];
finalTable = array2table(results, VariableNames=header);
disp(finalTable);
