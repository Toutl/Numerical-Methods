%% Secant method
% Ubaldo Neri
% https://github.com/Toutl

clc; clear; close all;
format long;

% Problem definition
f = @dT;
x_prev = 0.008;
x_curr = 0.01;

% Initialization
tolerance = 1e-06;
max_iters = 50;
results = zeros(max_iters, 7);

% Iterative calculation
for i = 1:max_iters
    fx_prev = f(x_prev);
    fx_curr = f(x_curr);

    x_new = x_curr - fx_curr*(x_curr - x_prev)/(fx_curr - fx_prev);

    error = abs((x_new - x_curr) / x_new) * 100;

    results(i, :) = [i-1, x_prev, x_curr, fx_prev, fx_curr, x_new, error];

    if error < tolerance, break; end
    x_prev = x_curr;
    x_curr = x_new;
end

% Show results
results = results(1:i, :);
finalTable = array2table(results, "VariableNames", ...
    ["i", "Previous x", "x_i",  "Previous f(x)", "f(x_i)", "Next x", "Error"]);

disp(finalTable);
fprintf("    Secant convergence, x = %.5f\n\n", results(end, 6));
