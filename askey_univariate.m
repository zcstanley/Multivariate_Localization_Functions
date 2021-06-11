function loc = askey_univariate(dist, R, nu)
% This function calculates Askey localization weights as in e.g.
% Eq. (9),  Stanley et al. (2021)
%
% INPUTS:
% dist = distance
% R = localization radius
% nu = shape parameter
%
% OUTPUT:
% loc = localization matrix
%
% Author: Zofia Stanley

loc = max( (1 - abs(dist)./R), 0 ) .^ (nu) ;

end