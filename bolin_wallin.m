function loc = bolin_wallin(dis, params)
% This function calculates the Bolin & Wallin localization function, 
% which is equal to the normalized volume of intersection of two spheres with
% centers d units apart, where one sphere has radius cmax and the other has
% radius cmin. The normalization is chosen so that the normalized volume of 
% two colocated spheres (d=0) with the same radius (cmax=cmin) is 1. 
% This localization function is defined in Bolin and Wallin (2016), Section 2.1
% Note that there is a typo in Bolin and Wallin, which is corrected here.
% B & W write pi * r^3/2 when they mean pi * r^3.
%
% INPUTS:
% dis = distance
% params is a struct which holds scalar localization parameters:
%   rXX is the localization radius for process X 
%   rYY is the localization radius for process Y 
%   Ny is the number of state variables in process Y 
%   Nx is the number of state variables in process X 
%   beta is the cross-localization weight factor
%
% OUTPUT:
% loc = localization matrix

% Load parameters
rXX = params.rXX;
rYY = params.rYY;
Ny = params.Ny;
Nx = params.Nx;
b = params.beta;

% Divide loc. rad. by to 2 to get kernel rad.
cX = rXX / 2;
cY = rYY / 2;

% Rescale beta 
betamax = bolin_wallin_beta_max(params);
beta_rescaled = b / betamax ;
assert(b<=betamax, sprintf('beta (%0.2g) must be less than beta max (%0.2g).', b, betamax))

% We assume a symmetric distance matrix
dYY = dis(1:Ny, 1:Ny);
dXX = dis(Ny+1:end, Ny+1:end);
dXY = dis(Ny+1:end, 1:Ny);

% within_component localization
locYY = bolin_wallin_univariate(dYY, cY);
locXX = bolin_wallin_univariate(dXX, cX);

% Cross-localization
if cX == cY
    locXY = bolin_wallin_univariate(dXY, cY);
else
    locXY = bolin_wallin_cross(dXY, cY, cX);
end
    
% Put submatrices back together
loc = zeros(Ny+Nx);
loc(1:Ny, 1:Ny) = locYY;
loc(Ny+1:end, Ny+1:end) = locXX;
loc(Ny+1:end, 1:Ny) = beta_rescaled .* locXY;
loc(1:Ny, Ny+1:end) = beta_rescaled .* locXY';


end