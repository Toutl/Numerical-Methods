%% Parabolic interpolation
% Ubaldo Neri
% https://github.com/Toutl

clc; clear; close all;
format long;

% Problem definition
f = @T;
a = 0.001;
b = 0.005;
c = 0.010;

% Initialization
tolerance = 1e-06;
max_iters = 50;
d_prev = b;
A = [a f(a); b f(b); c f(c)];
results = zeros(max_iters, 7);
n_iters = 0;

% Iterative calculation
for i = 1:max_iters
    fa = f(a); fb = f(b); fc = f(c);

    num = (b-a)^2 * (fb-fc) - (b-c)^2 * (fb-fa);
    den = (b-a) * (fb-fc) - (b-c) * (fb-fa);

    if abs(den) < eps, break; end

    d = b - 0.5 * (num / den);
    error = abs((d - d_prev) / d) * 100;

    results(i, :) = [i-1, a, b, c, d, f(d), error];
    n_iters = i;
    
    if error < tolerance, break; end

    B = [A; d f(d)];
    [~, sort_idx] = sort(B(:, 2));
    A = B(sort_idx(1:3), :);

    a = A(1, 1);
    b = A(2, 1);
    c = A(3, 1);

    d_prev = d;
end

% Show results
results = results(1:n_iters, :);
finalTable = array2table(results, "VariableNames", ...
    ["i", "a", "b", "c", "d", "f(d)", "Error"]);

disp(finalTable)
fprintf("    Parabolic interpolation convergence, x = %.5f\n\n", results(end, 5));
