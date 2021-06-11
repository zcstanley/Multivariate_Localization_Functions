function gammaXY = askey_wendland_gamma_cross(params)
% Calculates cross-localization gamma for both Askey and Wendland
%
% INPUTS:
% params is a struct which holds scalar localization parameters:
%   rXX is the localization radius for process X 
%   rYY is the localization radius for process Y 
%   rXY is the cross-localization radius
%   gammaXX is a shape parameter for process X
%   gammaYY is a shape parameter for process Y
%   
%
% OUTPUT:
% gammaXY = shape parameter for cross-localization
%
% Author: Zofia Stanley

% Load parameters
rXX = params.rXX;
rYY = params.rYY;
rXY = params.rXY;
gammaXX = params.gammaXX;
gammaYY = params.gammaYY;

% Calculate maximum cross-localization weight factor
gammaXY = (rXY/2) * ((gammaXX/rXX) + (gammaYY/rYY));

end