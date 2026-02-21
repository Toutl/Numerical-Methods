%% Fixed-point method
% Ubaldo Neri
% https://github.com/Toutl

clc; clear; close all;
format long;

% Problem definition
g = @(x) -log(0.1 + exp(-0.5*x)) / 0.19;    % ...
x_prev = 9;

% Initialization
tolerance = 1e-06;
max_iters = 50;
results = zeros(max_iters, 4);

% Iterative calculation
for i = 1:max_iters
    x_new = g(x_prev);
    error = abs(x_new - x_prev);

    results(i, :) = [i, x_prev, x_new, error];

    if error < tolerance, break; end
    x_prev = x_new;
end

% Show results
results = results(1:i, :);
finalTable = array2table(results, "VariableNames", ...
    ["n", "x_current", "x_next", "Error"]);

disp(finalTable);
fprintf("    Fixed-point convergence, x = %.5f\n\n", results(end, 3));
