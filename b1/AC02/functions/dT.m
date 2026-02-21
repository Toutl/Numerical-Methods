function dT = dT(r_a)
% dT  Steady-state temperature of a wire with insulation.
%   T = T(r_a)
%   dT  = dT/dr_a
%   r_a : insulation thickness (m)

arguments
    r_a (1,1) double {mustBeNonnegative}
end

% Physical parameters
q      = 75;      % Heat generation rate
r_w    = 6e-3;    % Wire radius (m)
k      = 0.17;    % Insulation thermal conductivity
h      = 12;      % Convection coefficient
T_air  = 293;     % Ambient temperature (K)

% Radius with insulation
r = r_w + r_a;

% Thermal resistances
R_cond = (1/k) * log(r / r_w);
R_conv = (1/h) * (1 / r);

% First derivative dT/dr_a
dT = (q/(2*pi)) * (1/(k*r) - 1/(h*r^2));
end