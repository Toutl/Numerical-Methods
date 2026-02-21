%% Newton-Raphson method
% Ubaldo Neri
% https://github.com/Toutl

clc; clear; close all;
format long;

% Problem definition
f = @dT;
df = @d2T;
x_prev = 0.008;

% Initialization
tolerance = 1e-06;
max_iters = 50;
results = zeros(max_iters, 6);

% Iterative calculation
for i = 1:max_iters
    f_x = f(x_prev);
    df_x = df(x_prev);
    x_new = x_prev - f_x / df_x;

    error = abs((x_new - x_prev) / x_new) * 100;

    results(i, :) = [i-1, x_prev, f_x, df_x, x_new, error];
    
    if error < tolerance, break; end
    x_prev = x_new;
end

% Show results
results = results(1:i, :);
finalTable = array2table(results, "VariableNames", ...
    ["i", "Current x", "f(x)", "f'(x)", "Next x", "Error"]);

disp(finalTable);
fprintf("    Newton-Raphson convergence, x = %.5f\n\n", results(end, 5));
