%% Problem 1,  Ziraddin Gulumjanli 2025
clear; clc; close all;

% Obtain script directory for saving files
full_fun_path = which(mfilename('fullpath'));
path_name = fullfile(fileparts(full_fun_path), filesep);

% Define System Matrices (A, B Matrices per system)
systems = {
    struct('A', [1, -1; -3, 2], 'B', [0; 1]), % System (a)
    struct('A', [-2, -3, 5; 3, 2, -5; 2, 1, -3], 'B', [0; 0; 1]), % System (b)
    struct('A', [-2, -3, 5; 6, 15, -21; 5, 14, -19], 'B', [0; 0; 1]), % System (c)
    struct('A', [-2, -3, 5; 10, 20, -20; 9, 19, -18], 'B', [0; 0; 1])  % System (d)
};

labels = {'(a)', '(b)', '(c)', '(d)'};

% Time Span
TSPAN = [0 20];

% Input function u(t)
u = @(t) exp(-0.3*t) .* sin(t);

% Set Fontsize & Linewidth
fontsize = 18;
linewidth = 1.5;

% Create Figure for All Simulations
hf = figure;
hf.Color = 'w';

% Loop through each system matrix A separately
for i = 1:length(systems)
    sys = systems{i};
    A = sys.A;
    B = sys.B;
    
    % Initial Condition based on A matrix size
    x0 = zeros(size(A,1), 1);

    % State Derivative Function
    dxdt = @(t, x) A*x + B*u(t);

    % Solve using ODE45
    options = odeset('RelTol',1e-8, 'AbsTol',1e-8);
    [T, X] = ode45(dxdt, TSPAN, x0, options);

    % Plot State Evolution
    subplot(2,2,i);
    plot(T, X, 'LineWidth', linewidth);
    xlabel('$t$ (Time) [s]', 'Interpreter', 'latex', 'FontSize', fontsize);
    ylabel('$x(t)$ (States)', 'Interpreter', 'latex', 'FontSize', fontsize);
    title([' ', labels{i}], 'Interpreter', 'latex', 'FontSize', fontsize);
    grid off;

    % Add legend dynamically based on state size
    legend_entries = arrayfun(@(n) sprintf('$x_%d$', n), 1:size(X,2), 'UniformOutput', false);
    legend(legend_entries, 'Interpreter', 'latex', 'FontSize', fontsize-9, 'Location', 'best');

end

% Adjust Figure Appearance
for i = 1:4
    ha = subplot(2,2,i);
    ha.FontSize = fontsize - 4;
    ha.LineWidth = 1;
end

% % Define Save Paths
% savename_pdf = strcat(path_name, 'hw3_p1_gulumjanli.pdf');
% savename_png = strcat(path_name, 'hw3_p1_gulumjanli.png');
% 
% % Export Graphics
% exportgraphics(hf, savename_pdf);
% exportgraphics(hf, savename_png);
