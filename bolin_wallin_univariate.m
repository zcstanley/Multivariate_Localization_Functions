function loc = bolin_wallin_univariate(dis, c)
% Bolin-Wallin univariate localization
% This is equivalent to the normalized volume of intersection of two
% spheres of radius c separated by distance dist.
% Sometimes also called spherical covariance function.
%
% INPUTS:
% dis = distance (matrix)
% c = localization radius / 2 = kernel radius (scalar)
%
% OUTPUT:
% loc = localization matrix

% Calculate normalized volume of intersection
dis = abs(dis) ; 
loc = zeros(size(dis)) ;
nonzero = dis < (2*c) ;
x = dis(nonzero) ; 
loc(nonzero) = 1/(2*c^3) .* (c - x./2).^2 .* (2*c + x./2) ;

end