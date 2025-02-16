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

% Compute the controllability matrix
BA = A * B;
BA2 = A^2 * B;
BA3 = A^3 * B;

% Compute stability of matrix
eigenvalues = eig(A);
Mc = [B, BA, BA2, BA3]; 

% Compute the rank of the controllability matrix
rank_Mc = rank(Mc);

% Display results
disp('Matrix B:');
disp(B);
disp('Matrix AB:');
disp(BA);
disp('Matrix A^2B:');
disp(BA2);
disp('Matrix A^3B:');
disp(BA3);
disp('Controllability Matrix M_c:');
disp(Mc);
disp(['Rank of Controllability Matrix: ', num2str(rank_Mc)]);
disp(['Eigenvalues are:']);
disp(eigenvalues)   

% Check if the system is fully controllable
if rank_Mc < size(A,1)
    disp('System is not fully controllable.');
else
    disp('System is fully controllable.');
end
% Check if the system is fully stable

if all(real(eigenvalues) < 0)
    disp('The system is stable (all eigenvalues have negative real parts).');
else
    disp('The system is NOT stable .');
end
