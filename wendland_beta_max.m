function beta_max = wendland_beta_max(params)
% Calculates maximum cross-localization weight factor
% for Wendland with given localization parameters;
% Eq. (13) in Stanley et al., (2021)
%
% INPUTS:
% params is a struct which holds scalar localization parameters:
%   rXX is the localization radius for process X 
%   rYY is the localization radius for process Y 
%   rXY is the cross-localization radius
%   nu is a global shape parameter
%   k is a smoothness parameter
%   gammaXX is a shape parameter for process X
%   gammaYY is a shape parameter for process Y
%   gammaXY is a shape parameter for cross-localization
%
% OUTPUT:
% beta_max = maximum cross-localization weight factor
%
% Author: Zofia Stanley

% Load parameters
rXX = params.rXX;
rYY = params.rYY;
rXY = params.rXY;
nu = params.nu;
k = params.k;
gammaXX = params.gammaXX;
gammaXY = params.gammaXY;
gammaYY = params.gammaYY;

% Calculate maximum cross-localization weight factor
loc_rad_ratio = ( rXY.^2 ./ (rXX*rYY) ) .^ (nu + 2.*k + 1) ;
beta_fun_ratio = beta(nu + 2.*k + 1, gammaXY + 1).^2 ./ ( beta(nu + 2.*k + 1, gammaXX + 1).*beta(nu + 2.*k + 1, gammaYY + 1) ) ;
beta_max = sqrt( loc_rad_ratio .* beta_fun_ratio );

end