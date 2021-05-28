function beta_max = bolin_wallin_beta_max(params)
% This function calculates maximum cross-localization weight factor
% for Bolin-Wallin with given localization parameters
%
% INPUTS:
% params is a struct which holds scalar localization parameters:
%   rXX is the localization radius for process X 
%   rYY is the localization radius for process Y 
%
% OUTPUT:
% beta_max = maximum cross-localization weight factor


% Load parameters
rXX = params.rXX;
rYY = params.rYY;

% Calculate maximum cross-localization weight factor
rmin = min(rXX, rYY);
rmax = max(rXX, rYY);
kappa = sqrt(rmax./rmin);
beta_max = kappa.^(-3);

end