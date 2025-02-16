%% Problem 2,  Ziraddin Gulumjanli 2025

close all; clear; clc;

% Define system matrices
A = [2 0 -3; 0 1 0; 3/2 0 5/2];
B = [-1; 0; 2];  
C = [1 0 0];
D = 0;

%% Part a
% Compute CA and CA^2
CA = C * A;
CA2 = C * (A^2);

% Compute the observability matrix
Mo = [C; CA; CA2];

% Compute the rank of the observability matrix
rank_Mo = rank(Mo);

% Display results
disp('Matrix C:');
disp(C);
disp('Matrix CA:');
disp(CA);
disp('Matrix CA^2:');
disp(CA2);
disp('Observability Matrix M_o:');
disp(Mo);
disp(['Rank of Observability Matrix: ', num2str(rank_Mo)]);

% Check if the system is fully observable
if rank_Mo < size(A,1)
    disp('System is not fully observable.');
else
    disp('System is fully observable.');
end

% ------------------------------------------------------
%% Part b
% create state-space model
sys = ss(A,B,C,D)

% observable subspace decomposition
[ABAR,BBAR,CBAR,T,K] = obsvf(sys.A,sys.B,sys.C)
A_observable = ABAR(2:3, 2:3);
C_observable = CBAR(:, 2:end);
A_observable
C_observable

% Compute observability matrix for the observable subsystem
O_observable = [C_observable; C_observable * A_observable];

% Compute the rank
rank_O_observable = rank(O_observable);

% Display results
disp('Observability Matrix for Observable Subspace:');
disp(O_observable);
disp(['Rank of Observability Matrix for Observable Subspace: ', num2str(rank_O_observable)]);

% Check if the observable subsystem is fully observable
if rank_O_observable == size(A_observable,1)
    disp('The observable subspace is indeed observable.');
else
    disp('The observable subspace is NOT fully observable.');
end
