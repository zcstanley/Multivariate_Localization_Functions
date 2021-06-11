function loc = gaspari_cohn_cross(dist, cY, cX)
% Calculates the Gaspari-Cohn cross-localization weights from 
% Eqs. (A1) and (A2) in Stanley, Grooms, Kleiber, Multivar. Loc. Fun. (2021) 
%
% INPUTS:
% dist = distance (matrix)
% cY = kernel radius = localization radius for process Y / 2 (scalar)
% cX = kernel radius = localization radius for process X / 2 (scalar)
%
% OUTPUT:
% loc = localization matrix
%
% Author: Zofia Stanley

% Order kernel radii
cmin = min(cY, cX);
cmax = max(cY, cX);
kappa = sqrt(cmax/cmin);

% Rescale distance
x = abs(dist)./(kappa*cmin);

% Intialize localization weights
loc = zeros(size(x));

% Two cases: kappa >= sqrt(2) and kappa < sqrt(2)
% Case 1: kappa >= sqrt(2)
if kappa >= sqrt(2)  
    % Regions
    leq1 = (x <= 1/kappa) ;
    leq2 = (1/kappa < x & x <= (kappa^2-1)/kappa);
    leq3 = ((kappa^2-1)/kappa < x & x <= kappa );
    leq4 = (kappa < x & x < (kappa^2+1)/kappa );
    % Evaluation of fifth order piecewise rational function
    loc(leq1) = -(1/6).*x(leq1).^5 + (1/2).*(1/kappa).*x(leq1).^4 -(5/3).*(1/kappa^3).*x(leq1).^2 + (5/2)*(1/kappa^3) - (3/2)*(1/kappa^5);
    loc(leq2) = -(5/2).*(1/kappa^4).*x(leq2) - ((1/3).*(1/kappa^6))./x(leq2) + (5/2)*(1/kappa^3);
    loc(leq3) = -(1/12).*x(leq3).^5 + (1/4).*(kappa-1/kappa).*x(leq3).^4 + (5/8).*x(leq3).^3 - (5/6).*(kappa^3-1/kappa^3).*x(leq3).^2 ...
                    +(5/4).*(kappa^4-kappa^2-1/kappa^2-1/kappa^4).*x(leq3) + (5/12)./x(leq3) - (3/8).*(kappa^4+1/kappa^4)./x(leq3) ... 
                    +(1/6).*(kappa^6-1/kappa^6)./x(leq3) + (5/4)*(kappa^3+1/kappa^3) - (3/4)*(kappa^5-1/kappa^5);
    loc(leq4) = (1/12).*x(leq4).^5 - (1/4).*(kappa+1/kappa).*x(leq4).^4 + (5/8).*x(leq4).^3 + (5/6).*(kappa^3+1/kappa^3).*x(leq4).^2 ...
                    -(5/4).*(kappa^4+kappa^2+1/kappa^2+1/kappa^4).*x(leq4) + (5/12)./x(leq4) - (3/8).*(kappa^4+1/kappa^4)./x(leq4) ... 
                    -(1/6).*(kappa^6+1/kappa^6)./x(leq4) + (5/4)*(kappa^3+1/kappa^3) + (3/4)*(kappa^5+1/kappa^5);
% Case 2: kappa < sqrt(2)
else
    % Regions
    leq1 = (x <= (kappa^2-1)/kappa) ;
    leq2 = ((kappa^2-1)/kappa < x & x <= 1/kappa);
    leq3 = (1/kappa < x & x <= kappa );
    leq4 = (kappa < x & x < (kappa^2+1)/kappa );
    % Evaluation of fifth order piecewise rational function
    loc(leq1) = -(1/6).*x(leq1).^5 + (1/2).*(1/kappa).*x(leq1).^4 -(5/3).*(1/kappa^3).*x(leq1).^2 + (5/2)*(1/kappa^3) - (3/2)*(1/kappa^5);
    loc(leq2) = -(1/4).*x(leq2).^5 + (1/4).*(kappa+1/kappa).*x(leq2).^4 + (5/8).*x(leq2).^3 - (5/6).*(kappa^3+1/kappa^3).*x(leq2).^2 ...
                    +(5/4).*(kappa^4-kappa^2-1/kappa^2+1/kappa^4).*x(leq2) + (1/6).*(kappa^6+1/kappa^6)./x(leq2) - (3/8).*(kappa^4+1/kappa^4)./x(leq2) ...
                    +(5/12)./x(leq2) - (3/4)*(kappa^5+1/kappa^5) + (5/4)*(kappa^3+1/kappa^3);
    loc(leq3) = -(1/12).*x(leq3).^5 + (1/4).*(kappa-1/kappa).*x(leq3).^4 + (5/8).*x(leq3).^3 - (5/6).*(kappa^3-1/kappa^3).*x(leq3).^2 ...
                    +(5/4).*(kappa^4-kappa^2-1/kappa^2-1/kappa^4).*x(leq3) + (5/12)./x(leq3) - (3/8).*(kappa^4+1/kappa^4)./x(leq3) ... 
                    +(1/6).*(kappa^6-1/kappa^6)./x(leq3) + (5/4)*(kappa^3+1/kappa^3) - (3/4)*(kappa^5-1/kappa^5);
    loc(leq4) = (1/12).*x(leq4).^5 - (1/4).*(kappa+1/kappa).*x(leq4).^4 + (5/8).*x(leq4).^3 + (5/6).*(kappa^3+1/kappa^3).*x(leq4).^2 ...
                    -(5/4).*(kappa^4+kappa^2+1/kappa^2+1/kappa^4).*x(leq4) + (5/12)./x(leq4) - (3/8).*(kappa^4+1/kappa^4)./x(leq4) ... 
                    -(1/6).*(kappa^6+1/kappa^6)./x(leq4) + (5/4)*(kappa^3+1/kappa^3) + (3/4)*(kappa^5+1/kappa^5);
end
end


