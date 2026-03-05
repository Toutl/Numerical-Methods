%% Review
% Ubaldo Neri
% https://github.com/Toutl

clc; clear; close all;
format long;

% Output definition
showConvergeceTables = true;

% Problem definition
f0 = @(x) 10 - 20 * (exp(-0.19*x) - exp(-0.5*x));
f = @(x) 2 - 20 * (exp(-0.19*x) - exp(-0.5*x));
df = @(x) -20 * (-0.19*exp(-0.19*x) + 0.5*exp(-0.5*x));
% g = @(x) -log(0.1 + exp(-0.50*x)) / 0.19;
g = @(x) -log(exp(-0.19*x) - 0.1) / 0.5;
x0 = 0;
x1 = 3;
xs = [0, 3, 6];

% Methods
fprintf("\n   RESULTS:\n\n");
bisection(f, x0, x1, showConvergeceTables);
newton_raphson(f, df, x0, showConvergeceTables);
secant(f, x0, x1, showConvergeceTables);
fixed_point(g, x0, showConvergeceTables);
parabolic_interpolation(f0, xs, showConvergeceTables);


function bisection(f, a, b, showTable)
arguments
    f function_handle
    a (1,1) double
    b (1,1) double
    showTable (1,1) logical
end

% Check interval validity
if f(a)*f(b) > 0
    error("The interval does not contain a root.");
end

% Initialization
tolerance = 1e-06;
n = fix((log(b-a) - log(tolerance)) / log(2)) + 1;
results = zeros(n+1, 7);

% Iterative calculation
for k = 0:n
    c = a + 0.5*(b - a);

    f_c = f(c);
    error_bound = b - a;
    error_rel_per = 100;
    if k > 0
        error_rel_per = abs((c -results(k,4)) / c)*100;
    end

    results(k+1, :) = [k, a, b, c, f_c, error_bound, error_rel_per];

    if abs(f_c) < eps
        break;
    elseif f(a)*f_c < 0
        b = c;
    else
        a = c;
    end
end

% Show results
results = results(1:k+1, :);

if showTable
    finalTable = array2table(results, "VariableNames", ...
        ["n", "a_n", "b_n", "c_n", "f(c_n)", "Error bound", "Relative % error"]);
    disp(finalTable);
end

fprintf("    Bisection convergence, x = %.5f\n\n", results(end, 4));
end


function newton_raphson(f, df, x_prev, showTable)
arguments
    f function_handle
    df function_handle
    x_prev (1,1) double
    showTable (1,1) logical
end

% Initialization
tolerance = 1e-06;
max_iters = 50;
results = zeros(max_iters, 6);

% Iterative calculation
for i = 1:max_iters
    f_x = f(x_prev);
    df_x = df(x_prev);

    if abs(df_x) < eps, break; end

    x_new = x_prev - f_x / df_x;
    error = abs((x_new - x_prev) / x_new) * 100;

    results(i, :) = [i-1, x_prev, f_x, df_x, x_new, error];

    if error < tolerance, break; end
    x_prev = x_new;
end

% Show results
results = results(1:i, :);

if showTable
    finalTable = array2table(results, "VariableNames", ...
        ["i", "Current x", "f(x)", "f'(x)", "Next x", "Error"]);
    disp(finalTable);
end

fprintf("    Newton-Raphson convergence, x = %.5f\n\n", results(end, 5));
end

function secant(f, x_prev, x_curr, showTable)
arguments
    f function_handle
    x_prev (1,1) double
    x_curr (1,1) double
    showTable (1,1) logical
end

% Initialization
tolerance = 1e-06;
max_iters = 50;
results = zeros(max_iters, 7);

% Iterative calculation
for i = 1:max_iters
    fx_prev = f(x_prev);
    fx_curr = f(x_curr);

    if abs(fx_curr - fx_prev) < eps, break; end

    x_new = x_curr - fx_curr*(x_curr - x_prev)/(fx_curr - fx_prev);
    error = abs((x_new - x_curr) / x_new) * 100;

    results(i, :) = [i-1, x_prev, x_curr, fx_prev, fx_curr, x_new, error];

    if error < tolerance, break; end
    x_prev = x_curr;
    x_curr = x_new;
end

% Show results
results = results(1:i, :);

if showTable
    finalTable = array2table(results, "VariableNames", ...
        ["i", "Previous x", "x_i",  "Previous f(x)", "f(x_i)", "Next x", "Error"]);
    disp(finalTable);
end

fprintf("    Secant convergence, x = %.5f\n\n", results(end, 6));
end

function fixed_point(g, x_prev, showTable)
arguments
    g function_handle
    x_prev (1,1) double
    showTable (1,1) logical
end

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

if showTable
    finalTable = array2table(results, "VariableNames", ...
        ["n", "x_current", "x_next", "Error"]);
    disp(finalTable);
end

fprintf("    Fixed-point convergence, x = %.5f\n\n", results(end, 3));
end

function parabolic_interpolation(f, xs, showTable)
arguments
    f function_handle
    xs (1,3) double
    showTable (1,1) logical
end

% Initialization
a = xs(1); b = xs(2); c = xs(3);
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
    [~, sort_idx] = sort(abs(B(:, 2)));
    A = B(sort_idx(1:3), :);

    a = A(1, 1);
    b = A(2, 1);
    c = A(3, 1);

    d_prev = d;
end

% Show results
results = results(1:n_iters, :);

if showTable
    finalTable = array2table(results, "VariableNames", ...
        ["i", "a", "b", "c", "d", "f(d)", "Error"]);
    disp(finalTable)
end

fprintf("    Parabolic interpolation convergence, x = %.5f\n\n", results(end, 5));
end
