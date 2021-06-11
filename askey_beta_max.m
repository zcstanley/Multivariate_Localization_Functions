function beta_max = askey_beta_max(params)
% This function calculates maximum cross-localization weight factor
% for Askey with given localization parameters
% Eq. (13) with k=0 in Stanley et al., (2021) 
%
% INPUTS:
% params is a struct which holds scalar localization parameters:
%   rXX is the localization radius for process X 
%   rYY is the localization radius for process Y 
%   rXY is the cross-localization radius
%   nu is a global shape parameter
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
gammaXX = params.gammaXX;
gammaXY = params.gammaXY;
gammaYY = params.gammaYY;

% Calculate maximum cross-localization weight factor
loc_rad_ratio = ( rXY.^2 ./ (rXX.*rYY) ) .^ (nu + 1) ;
beta_fun_ratio = beta(nu+1, gammaXY+1).^2 ./ ( beta(nu+1, gammaXX+1).*beta(nu+1, gammaYY+1) ) ;
beta_max = sqrt( loc_rad_ratio .* beta_fun_ratio );

end