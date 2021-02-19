function rho = GC(d, params)
% Gaspari-Cohn localization; Roh et al. (16)
% d = distance
% c = localization radius / 2
% B = matrix containing desired cross-covariance shrinkage factors

c = params.c;
B = params.B;

x = abs(d)./c;
rho = zeros(size(x)) ; 

% cases
leq1 = x <= 1 ;
leq2 = x>1 & x<=2;

% evaluation of fifth order piecewise rational function
rho(leq1) = -.25 .* x(leq1).^5 + .5 .* x(leq1).^4 + .625 .* x(leq1).^3 - (5/3) .* x(leq1).^2 + 1;
rho(leq2) = (1/12) .* x(leq2).^5 - .5 .* x(leq2).^4 + .625 .* x(leq2).^3 + (5/3) .* x(leq2).^2 - 5 .* x(leq2) + 4 - 2./(3.*x(leq2));

% shrink cross-covariances
rho = rho .* B ; 

end