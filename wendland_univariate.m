function loc = wendland_univariate(dist, R, nu, gamma, k)
% Calculates Wendland localization weights as in, e.g.
% Eqs. (11 & 12), Stanley et al. (2021) 
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
%
% Author: Zofia Stanley

% Use symbolic integration to find univariate Wendland function
% Note this may be costly if called often.
syms u w
wend(w) = int( (u^2 - w^2)^k * (1 - u)^(nu+gamma), u, w, 1 ) / beta(2*k + 1, nu+gamma+1);
    
% Rescale with localization radius
x = abs(dist)./R ;
near = x <=1 ;
loc = zeros(size(x)) ;
loc(near) = wend(x(near)) ;

end