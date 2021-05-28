function loc = wendland(dist, params)
% This function forms a localization matrix using
% Wendland localization; Roh et al. (9)
%
% INPUTS:
% dist = distance
% params is a struct which holds scalar localization parameters:
%   rXX is the localization radius for process X 
%   rYY is the localization radius for process Y 
%   rXY is the cross-localization radius
%   nu is a global shape parameter
%   k is a smoothness parameter
%   gammaXX is a shape parameter for process X
%   gammaYY is a shape parameter for process Y
%   gammaXY is a shape parameter for cross-localization
%   Ny is the number of state variables in process Y 
%   Nx is the number of state variables in process X 
%   b is the cross-localization weight factor
%
% OUTPUT:
% loc = localization matrix

% Load parameters
rXX = params.rXX;
rYY = params.rYY;
rXY = params.rXY;
nu = params.nu;
k = params.k;
gammaXX = params.gammaXX;
gammaXY = params.gammaXY;
gammaYY = params.gammaYY;
Ny = params.Ny;
Nx = params.Nx;
b = params.beta ;
betamax = wendland_beta_max(params) ; 
assert(b<=betamax, sprintf('beta (%0.2g) must be less than beta max (%0.2g).', b, betamax))

% We assume a symmetric distance matrix
dYY = dist(1:Ny, 1:Ny);
dXX = dist(Ny+1:end, Ny+1:end);
dXY = dist(Ny+1:end, 1:Ny);

% Form submatrices
locYY = wendland_univariate(dYY, rYY, nu, gammaYY, k);
locXX = wendland_univariate(dXX, rXX, nu, gammaXX, k);
locXY = wendland_univariate(dXY, rXY, nu, gammaXY, k);

% Put submatrices back together
loc = zeros(Ny+Nx);
loc(1:Ny, 1:Ny) = locYY;
loc(Ny+1:end, Ny+1:end) = locXX;
loc(Ny+1:end, 1:Ny) = b .* locXY;
loc(1:Ny, Ny+1:end) = b .* locXY';

end