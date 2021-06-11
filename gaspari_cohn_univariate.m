function loc = gaspari_cohn_univariate(dist, c)
% Calculates the standard Gaspari-Cohn localization weights
% Eq. (4.10) in Gaspari & Cohn, Corr. Fun. in 2 and 3 Dim., (1999)
%
% INPUTS:
% dist = distance (matrix)
% c = localization radius / 2 = kernel radius (scalar)
% 
% OUTPUT:
% loc = localization matrix
%
% Author: Zofia Stanley

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