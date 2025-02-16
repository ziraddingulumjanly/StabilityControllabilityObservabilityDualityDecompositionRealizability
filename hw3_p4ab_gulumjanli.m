%% Problem 4,  Ziraddin Gulumjanli 2025

close all; clear; clc

% Load data 
load('hw3_p4_data.mat')

% Compute the sampling time
ts = t(2) - t(1);

% Identify the state-space model using Kung’s SVD algorithm
[sys, ~, ~] = imp2ss(k, ts);

% Determine the number of states in the identified model
num_states = order(sys);

% Display the result
disp(['Number of states in the identified model: ', num2str(num_states)]);

% Compute balanced realization
[sysb, G, ~, ~] = balreal(sys);

% Set visualization parameters
fontsize = 18;
linewidth = 1.5;

% ----------------------------------------------------
% Plot Hankel singular values from Balanced Realization
hf_hankel1 = figure;
hf_hankel1.Color = 'w';

bar(G, 'FaceColor', [0.2, 0.6, 0.8]); % Custom blue color
xlabel('State Index', 'Interpreter', 'latex', 'FontSize', fontsize);
ylabel('Hankel Singular Value', 'Interpreter', 'latex', 'FontSize', fontsize);
title('Hankel Singular Values of the System', 'Interpreter', 'latex', 'FontSize', fontsize);
grid off;
set(gca, 'LineWidth', 1, 'XColor', 'k', 'YColor', 'k', 'FontSize', fontsize);

% ----------------------------------------------------
% Compute the controllability and observability Gramians
Wc = gram(sys, 'c');  
Wo = gram(sys, 'o');

% Compute Hankel Singular Values (HSV)
HSV = sqrt(eig(Wc * Wo));

% Sort the singular values in descending order
HSV = sort(HSV, 'descend');

% Display the singular values
%disp(HSV);
fprintf('%.16f\n', HSV);

% ----------------------------------------------------
% Plot Hankel singular values from Gramians
hf_hankel2 = figure;
hf_hankel2.Color = 'w';
bar(HSV, 'FaceColor', [225, 86, 86] / 255); % Custom red color
xlabel('State Index', 'Interpreter', 'latex', 'FontSize', fontsize);
ylabel('Hankel Singular Value', 'Interpreter', 'latex', 'FontSize', fontsize);
title('Hankel Singular Values (Computed from Gramians)', 'Interpreter', 'latex', 'FontSize', fontsize);
grid off;
set(gca, 'LineWidth', 1, 'XColor', 'k', 'YColor', 'k', 'FontSize', fontsize);

% ----------------------------------------------------
% Plot the first 30 Hankel singular values for better visualization
hf_hankel_subset = figure;
hf_hankel_subset.Color = 'w';
bar(HSV(1:min(30, length(HSV))), 'FaceColor', [86, 156, 225] / 255); % Custom blue color
xlabel('State Index (First 30)', 'Interpreter', 'latex', 'FontSize', fontsize);
ylabel('Hankel Singular Value', 'Interpreter', 'latex', 'FontSize', fontsize);
title('Hankel Singular Values (Top 30)', 'Interpreter', 'latex', 'FontSize', fontsize);
grid off;
set(gca, 'LineWidth', 1, 'XColor', 'k', 'YColor', 'k', 'FontSize', fontsize);

% %% **Save Figures as PDF & PNG**
% savepath = pwd; % Set save directory to current folder
% 
% % Hankel Singular Values from Balanced Realization
% savename_hankel1_pdf = fullfile(savepath, 'hankel_singular_values_balanced.pdf');
% savename_hankel1_png = fullfile(savepath, 'hankel_singular_values_balanced.png');
% exportgraphics(hf_hankel1, savename_hankel1_pdf);
% exportgraphics(hf_hankel1, savename_hankel1_png);
% 
% % Hankel Singular Values from Gramians
% savename_hankel2_pdf = fullfile(savepath, 'hankel_singular_values_gramians.pdf');
% savename_hankel2_png = fullfile(savepath, 'hankel_singular_values_gramians.png');
% exportgraphics(hf_hankel2, savename_hankel2_pdf);
% exportgraphics(hf_hankel2, savename_hankel2_png);
% 
% % Hankel Singular Values (First 30)
% savename_hankel_subset_pdf = fullfile(savepath, 'hankel_singular_values_top30.pdf');
% savename_hankel_subset_png = fullfile(savepath, 'hankel_singular_values_top30.png');
% exportgraphics(hf_hankel_subset, savename_hankel_subset_pdf);
% exportgraphics(hf_hankel_subset, savename_hankel_subset_png);
