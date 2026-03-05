%% EXAM - Secant method
% Ubaldo Neri

clc; clear; close all;
format long;

% Problem definition
R = 3;      % Radius
f = @(h) pi * h^2 * ((3*R - h) / 3) - 30;    % Volume
x_prev = 1;
x_curr = 3;

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


%% OUTPUT
% i       Previous x             x_i               Previous f(x)               f(x_i)                 Next x                Error        
% _    ________________    ________________    _____________________    _____________________    ________________    ____________________

% 0                   1                   3        -21.6224195904272         26.5486677646163    1.89773433724092         58.083243851805
% 1                   3    1.89773433724092         26.5486677646163        -3.21470939398414    2.01678883034685        5.90317098719028
% 2    1.89773433724092    2.01678883034685        -3.21470939398414       -0.255638688921412    2.02707413190309       0.507396419024053
% 3    2.01678883034685    2.02707413190309       -0.255638688921412      0.00426061687311829    2.02690552148983     0.00831861236110397
% 4    2.02707413190309    2.02690552148983      0.00426061687311829    -5.23245137173944e-06    2.02690572830581    1.02035320204676e-05
% 5    2.02690552148983    2.02690572830581    -5.23245137173944e-06    -1.06464170812615e-10    2.02690572831001    2.07616431971303e-10

% Secant convergence, x = 2.02691
