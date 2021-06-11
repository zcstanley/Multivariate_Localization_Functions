function [rInf, rSig, obs_var, LS] = set_up_adaptive_inflation(rInf, N, NoY, NoX, Nt, sigma2Y, sigma2X)
% This function sets up adaptive inflation for EnKF,
% following El Gharamti, M.: Enhanced Adaptive Inflation Algorithm for Ensemble Filters, MWR
% https://doi.org/10.1175/MWR-D-17-0187.1, 2018
%
% INPUTS:
% rInf = starting inflation value (scalar)
% N = number of state variables
% NoY = number of observations of ``short, fast'' Y process (Bivariate L96)
% NoY = number of observations of ``long, slow'' X process (Bivariate L96)
% Nt = number of analysis cycles
% sigma2Y = observation error variance for Y process
% sigma2X = observation error variance for X process
%
% OUTPUTS:
% rInf = vector of starting inflation values
% rSig = vector of starting inflation variance values
% obs_var = vector of observation error variances
% LS = initialized matrix to store inflation values
%
% Author: Zofia Stanley


% Hard-coded starting value for variance
sigmaL = 0.3; 

% initialize arrays
rInf = rInf.*ones(N, 1);
rSig = sigmaL.*ones(N, 1);

% array storing observation error variances
obs_var = zeros(NoY+NoX, 1);
obs_var(1:NoY) = sigma2Y;
obs_var(NoY+1:NoY+NoX) = sigma2X;

% Store inflations
LS = zeros(N, Nt);

end