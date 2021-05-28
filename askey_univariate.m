function loc = askey_univariate(dist, R, nu)
% This function calculates Askey localization;
% Stanley et al. (2021) (9)
%
% INPUTS:
% dist = distance
% R = localization radius
% nu = shape parameter
%
% OUTPUT:
% loc = localization matrix

loc = max( (1 - abs(dist)./R), 0 ) .^ (nu) ;

end