function [H, R, Y, YN] = set_up_observations(Ny, Nx, NoY, NoX, Nt, Ne, sigma2Y, sigma2X, XT)
% This function sets up observations for EnKF
%
% INPUTS:
% Ny is the number of Y state variables
% Nx is the number of X state variables
% Ny is the number of Y observations
% Nx is the number of X observations
% Nt is the number of assimilation cycles
% sigma2Y is Y observation error variance
% sigma2X is X observation error variance
% XT is the true solution, from which obs are generated
%
% OUTPUT:
% H = observation operator
% R = observation error covariance matrix
% Y = observations

% randomly pick observation locations
indY = sort(randsample(1:Ny,NoY,false));    % Indices of Y observations
indX = sort(randsample(Ny+1:Ny+Nx,NoX,false));  % Indices of X observations

% set up obs operator and obs error covariance matrix
I = eye(Ny+Nx);
H = I([indY , indX] , :);                   % observation operator
R = blkdiag(sigma2Y*eye(NoY),sigma2X*eye(NoX)); % iid obs

% Generate observations
Y = zeros(NoY+NoX,Nt);
Y(1:NoY,:) = XT(indY,:) + sqrt(sigma2Y)*randn(NoY,Nt);
Y(NoY+1:NoY+NoX,:) = XT(indX,:) + sqrt(sigma2X)*randn(NoX,Nt);

% Initialize ensemble of observations
YN = zeros(NoY+NoX,Ne);

end