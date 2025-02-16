%% Ziraddin Gulumjanli 2025 

clc; clear; close all;

% Define system matrix A
A = [1, 0, 0, 0; 
     0, -1, 0, 0; 
     0, 0, -2, 0; 
     0, 0, 0, -3];

% Define initial condition x0
x0 = [-2; -1; 1; 2];

% Define time span
TSPAN = [0 3];

% Set visualization parameters
fontsize = 18;
linewidth = 1.5;

% Solve using ODE45 (Numerical Integration)
options = odeset('RelTol',1e-8, 'AbsTol',1e-8);
[t, x] = ode45(@(t, x) A*x, TSPAN, x0, options);

% Create figure for state evolution
hf = figure;
hf.Color = 'w';

% Plot all states 
plot(t, x, 'LineWidth', linewidth);
xlabel('$t$ (Time) [s]', 'Interpreter', 'latex', 'FontSize', fontsize);
ylabel('$x(t)$ (States)', 'Interpreter', 'latex', 'FontSize', fontsize);
title('State Evolution of Unforced System', 'Interpreter', 'latex', 'FontSize', fontsize);
grid off;

% Add legend dynamically based on state size
legend_entries = arrayfun(@(n) sprintf('$x_%d$', n), 1:size(x,2), 'UniformOutput', false);
legend(legend_entries, 'Interpreter', 'latex', 'FontSize', fontsize-3, 'Location', 'best');

% % Save results
% full_fun_path = which(mfilename('fullpath'));
% path_name = fullfile(fileparts(full_fun_path), filesep);
% savename_pdf = strcat(path_name, 'unforced_system_simulation.pdf');
% savename_png = strcat(path_name, 'unforced_system_simulation.png');
% 
% exportgraphics(hf, savename_pdf);
% exportgraphics(hf, savename_png);
