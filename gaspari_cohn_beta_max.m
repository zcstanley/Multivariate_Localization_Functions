function beta_max = gaspari_cohn_beta_max(params)
% This function calculates maximum cross-localization weight factor
% for Gaspari-Cohn with given localization parameters
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
beta_max = (5/2).*kappa.^(-3) - (3/2).*kappa.^(-5);

end