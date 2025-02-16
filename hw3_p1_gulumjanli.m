%% Problem 1,  Ziraddin Gulumjanli 2025

% Define system matrices
clc, clear, close;
A1 = [1, -1; -3, 2];
A2 = [-2, -3, 5; 3, 2, -5; 2, 1, -3];
A3 = [-2, -3, 5; 6, 15, -21; 5, 14, -19];
A4 = [-2, -3, 5; 10, 20, -20; 9, 19, -18];

% Store matrices in a cell array for iteration
A_matrices = {A1, A2, A3, A4};
labels = {'(a)', '(b)', '(c)', '(d)'};

% Determine eigenvalues for stability
for i = 1:length(A_matrices)
    A = A_matrices{i};
    eigenvalues = eig(A);
    fprintf('System %s:\n', labels{i});
    disp('Eigenvalues:');
    disp(eigenvalues);   
end


