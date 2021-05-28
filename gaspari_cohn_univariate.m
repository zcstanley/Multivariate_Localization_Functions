function loc = gaspari_cohn_univariate(dist, c)
% Gaspari-Cohn localization; Roh et al. (16)
%
% INPUTS:
% dist = distance (matrix)
% c = localization radius / 2 = kernel radius (scalar)
% 
% OUTPUT:
% loc = localization matrix

% Rescale distance matrix
x = abs(dist)./c;
loc = zeros(size(x)) ; 

% Two regions
leq1 = x <= 1 ;
leq2 = x>1 & x<=2;

% evaluation of fifth order piecewise rational function
loc(leq1) = -.25 .* x(leq1).^5 + .5 .* x(leq1).^4 + .625 .* x(leq1).^3 - (5/3) .* x(leq1).^2 + 1;
loc(leq2) = (1/12) .* x(leq2).^5 - .5 .* x(leq2).^4 + .625 .* x(leq2).^3 + (5/3) .* x(leq2).^2 - 5 .* x(leq2) + 4 - 2./(3.*x(leq2));

end