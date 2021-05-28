function loc = wendland_univariate(dist, R, nu, gamma, k)
% This function calculates Wendland localization;
% Stanley et al. (2021) (11 & 12)
%
% INPUTS:
% dist = distance
% R = localization radius
% nu = shape parameter
% gamma = shape parameter
% k = smoothness parameter
%
% OUTPUT:
% loc = localization matrix

% Use symbolic integration to find univariate Wendland function
syms u w
wend(w) = int( (u^2 - w^2)^k * (1 - u)^(nu+gamma), u, w, 1 ) / beta(2*k + 1, nu+gamma+1);
    
% rescale with localization radius
x = abs(dist)./R ;
near = x <=1 ;
loc = zeros(size(x)) ;
loc(near) = wend(x(near)) ;

end