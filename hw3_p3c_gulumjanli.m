%% Open-Loop Control Simulation using Controllability Theorem 1
%% Ziraddin Gulumjanli 2025 

clc; clear; close all;

% Define system matrices
A = [1, 0, 0, 0; 
     0, -1, 0, 0; 
     0, 0, -2, 0; 
     0, 0, 0, -3];

B = [1, 0; 
    -1, 1; 
     0, -1;
     1, -1];

% Define initial condition
x0 = [-2; -1; 1; 2]; % for problem 3c
% x0 = [1; 1; 1; 1];   % for problem 3d

% Define time span
t0 = 0; tf = 3; % for problem 3c
% t0 = 0; tf = 1;% for problem 3d

TSPAN = [t0 tf];

% Compute the Controllability Gramian via integrla fucntion and Gramian inverse
Wc = integral(@(t) integrand(t, t0, A, B), t0, tf, 'ArrayValued', true);
Wc_inv = inv(Wc);

% Define the control law u(t)
u_func = @(t, x) -B' * expm(A' * (t0 - t)) * Wc_inv * x0;

% Define system dynamics with control input
dxdt = @(t, x) A*x + B * u_func(t, x);

% Solve system using ODE45
options = odeset('RelTol',1e-8, 'AbsTol',1e-8);
[t_controlled, x_controlled] = ode45(dxdt, TSPAN, x0, options);

% Solve the uncontrolled system for comparison
[t_uncontrolled, x_uncontrolled] = ode45(@(t, x) A*x, TSPAN, x0, options);

% Plot both responses
hf = figure;
hf.Color = 'w';

% Plot uncontrolled system
subplot(2,1,1);
plot(t_uncontrolled, x_uncontrolled, 'LineWidth', 1.5);
xlabel('$t$ (Time) [s]', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('$x(t)$ (States)', 'Interpreter', 'latex', 'FontSize', 14);
title('Uncontrolled System Response', 'Interpreter', 'latex', 'FontSize', 14);
legend({'$x_1$', '$x_2$', '$x_3$', '$x_4$'}, 'Interpreter', 'latex', 'FontSize', 12, 'Location', 'best');
grid on;

% Plot controlled system
subplot(2,1,2);
plot(t_controlled, x_controlled, 'LineWidth', 1.5);
xlabel('$t$ (Time) [s]', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('$x(t)$ (States)', 'Interpreter', 'latex', 'FontSize', 14);
title('Controlled System Response with Open-Loop Control', 'Interpreter', 'latex', 'FontSize', 14);
legend({'$x_1$', '$x_2$', '$x_3$', '$x_4$'}, 'Interpreter', 'latex', 'FontSize', 12, 'Location', 'best');
grid on;

% % Save the figures
% full_fun_path = which(mfilename('fullpath'));
% path_name = fullfile(fileparts(full_fun_path), filesep);
% exportgraphics(hf, strcat(path_name, 'controlled_vs_uncontrolled.pdf'));
% exportgraphics(hf, strcat(path_name, 'controlled_vs_uncontrolled.png'));

% Function for computing the Controllability Gramian
function I = integrand(t, t0, A, B)
    phi = expm(A * (t0 - t));
    Q = phi * B;
    I = Q * Q';
end
