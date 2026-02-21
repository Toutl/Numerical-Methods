%% Bisection method
% Ubaldo Neri
% https://github.com/Toutl

clc; clear; close all;
format long;

% Problem definition
f = @dT;
a = 0.008;
b = 0.009;

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
finalTable = array2table(results, "VariableNames", ...
    ["n", "a_n", "b_n", "c_n", "f(c_n)", "Error bound", "Relative % error"]);

disp(finalTable);
fprintf("    Bisection convergence, x = %.5f\n\n", results(end, 4));
