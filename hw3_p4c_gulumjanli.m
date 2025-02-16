%% Problem 4,  Ziraddin Gulumjanli 2025

close all; clear; clc;

% Load impulse response data
load('hw3_p4_data.mat');

% Compute sampling time
ts = t(2) - t(1);

% Identify full-order state-space model using Kung’s SVD algorithm
[sys, ~, ~] = imp2ss(k, ts);

% Compute balanced realization of the system
[sysb, G, T, Ti] = balreal(sys);

% Number of states in the original system
n = length(G);

% Define reduction orders
r1 = 4;   % Reduced model with 4 states
r2 = 20;  % Reduced model with 20 states

% Select states to remove 
elim1 = r1+1:n; % Remove all states beyond the first 4
elim2 = r2+1:n; % Remove all states beyond the first 20

% Construct reduced-order models using modred
sys4 = modred(sysb, elim1, 'truncate'); 
sys20 = modred(sysb, elim2, 'truncate'); 

% Set Visualization Parameters
fontsize = 18;
linewidth = 1.5;

% Bode Plot Comparison
hf_bode = figure;
hf_bode.Color = 'w';
hold on;
bode(sys, 'c', sys4, 'r', sys20, 'b', {1e-3, 1e3});
hold off;
grid off;

xlabel('$\omega$ (Frequency) ', 'Interpreter', 'latex', 'FontSize', fontsize);
ylabel('Magnitude & Phase', 'Interpreter', 'latex', 'FontSize', fontsize);
title('Bode Plot Comparison', 'Interpreter', 'latex', 'FontSize', fontsize);
legend({'Full Model', '4-State Model', '20-State Model'}, ...
       'Interpreter', 'latex', 'FontSize', fontsize-3, 'Location', 'best');

%Impulse Response Comparison
[Ysys, Tsys] = impulse(sys, t(end));
[Ysys4, Tsys4] = impulse(sys4, t(end));
[Ysys20, Tsys20] = impulse(sys20, t(end));

hf_impulse = figure;
hf_impulse.Color = 'w';
hold on;
plot(t, k, '.k', 'MarkerSize', 12);       % Original data
plot(Tsys, Ysys * ts, 'c', 'LineWidth', linewidth);  % Full model
plot(Tsys4, Ysys4 * ts, 'r', 'LineWidth', linewidth); % 4-state model
plot(Tsys20, Ysys20 * ts, 'b', 'LineWidth', linewidth); % 20-state model
hold off;

grid off;
xlabel('$t$ (Time) [s]', 'Interpreter', 'latex', 'FontSize', fontsize);
ylabel('Amplitude', 'Interpreter', 'latex', 'FontSize', fontsize);
title('Impulse Response Comparison', 'Interpreter', 'latex', 'FontSize', fontsize);
legend({'Data', 'Full Model', '4-State Model', '20-State Model'}, ...
       'Interpreter', 'latex', 'FontSize', fontsize-3, 'Location', 'best');

% %Save Results as PDF & PNG
% full_fun_path = which(mfilename('fullpath'));
% path_name = fullfile(fileparts(full_fun_path), filesep);
% 
% savename_bode_pdf = strcat(path_name, 'bode_plot_comparison.pdf');
% savename_bode_png = strcat(path_name, 'bode_plot_comparison.png');
% savename_impulse_pdf = strcat(path_name, 'impulse_response_comparison.pdf');
% savename_impulse_png = strcat(path_name, 'impulse_response_comparison.png');
% 
% exportgraphics(hf_bode, savename_bode_pdf);
% exportgraphics(hf_bode, savename_bode_png);
% exportgraphics(hf_impulse, savename_impulse_pdf);
% exportgraphics(hf_impulse, savename_impulse_png);
