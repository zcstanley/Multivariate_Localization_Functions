function [XT, T, X, XM] = compute_true_solution(params, N, Ne, Nt, dtObs)
% This function computes the true solution from bivariate Lorenz 96
% for use in data assimilation scheme
%
% INPUTS:
% params is a struct containing parameters for the bivariate Lorenz 96 model
% N is the total number of state variables
% Ne is the ensemble size
% Nt is the nubmer of assimilation cycles
% dtObs is the time between assimilation cycles
%
% OUTPUTS:
% XT is the true solution
% T is the time
% X is an intialized ensemble
% XM is initialized to store ensemble mean

% Compute true solution
[T,XT] = ode45(@(t,y) RHS_L96(t,y,params),[0 linspace(10,10+Nt*dtObs,Nt)],randn(N,1));
XT = XT(2:end,:)'; T = T(2:end);
% Initialize ensemble
X = XT(:,1) + randn(N,Ne); 
% Store ensemble mean 
XM = zeros(size(XT));

end
