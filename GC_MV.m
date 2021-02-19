function rho = GC_MV(d, params)
% Gaspari-Cohn localization; 
% d = distance (matrix)
% cX = localization radius for process x / 2 (Note variables are ordered so that Y comes before X)
% cY = localization radius for process x / 2 
% Nx = number of X variables
% Ny = number of Y variables
% B = matrix containing desired cross-covariance shrinkage factors

cX = params.cX;
cY = params.cY;
Ny = params.Ny;
Nx = params.Nx;
B = params.B;
dY = d(1:Ny, 1:Ny);
pY = struct('c', cY, 'B', B(1:Ny, 1:Ny));
dX = d(Ny+1:end, Ny+1:end);
pX = struct('c', cX, 'B', B(Ny+1:end, Ny+1:end));

% univariate localization
rho = zeros(Ny+Nx);
rho(1:Ny, 1:Ny) = GC(dY, pY);
rho(Ny+1:end, Ny+1:end) = GC(dX, pX);

% cross-covariance
% we assume a symmetric distance matrix

c1 = min(cY, cX);
c2 = max(cY, cX);
N = sqrt(c2/c1);
dXY = d(Ny+1:end, 1:Ny);
BXY = B(Ny+1:end, 1:Ny);
rhoXY = zeros(size(dXY));

x = abs(dXY)./(N*c1);

% two cases: N >= sqrt(2) and N < sqrt(2)

% case 1: N >= sqrt(2)
if N >= sqrt(2)  
    % cases
    leq1 = (x <= 1/N) ;
    leq2 = (1/N < x & x <= (N^2-1)/N);
    leq3 = ((N^2-1)/N < x & x <= N );
    leq4 = (N < x & x < (N^2+1)/N );

    % evaluation of fifth order piecewise rational function
    rhoXY(leq1) = -(1/6).*x(leq1).^5 + (1/2).*(1/N).*x(leq1).^4 -(5/3).*(1/N^3).*x(leq1).^2 + (5/2)*(1/N^3) - (3/2)*(1/N^5);
    rhoXY(leq2) = -(5/2).*(1/N^4).*x(leq2) - ((1/3).*(1/N^6))./x(leq2) + (5/2)*(1/N^3);
    rhoXY(leq3) = -(1/12).*x(leq3).^5 + (1/4).*(N-1/N).*x(leq3).^4 + (5/8).*x(leq3).^3 - (5/6).*(N^3-1/N^3).*x(leq3).^2 ...
                    +(5/4).*(N^4-N^2-1/N^2-1/N^4).*x(leq3) + (5/12)./x(leq3) - (3/8).*(N^4+1/N^4)./x(leq3) ... 
                    +(1/6).*(N^6-1/N^6)./x(leq3) + (5/4)*(N^3+1/N^3) - (3/4)*(N^5-1/N^5);
    rhoXY(leq4) = (1/12).*x(leq4).^5 - (1/4).*(N+1/N).*x(leq4).^4 + (5/8).*x(leq4).^3 + (5/6).*(N^3+1/N^3).*x(leq4).^2 ...
                    -(5/4).*(N^4+N^2+1/N^2+1/N^4).*x(leq4) + (5/12)./x(leq4) - (3/8).*(N^4+1/N^4)./x(leq4) ... 
                    -(1/6).*(N^6+1/N^6)./x(leq4) + (5/4)*(N^3+1/N^3) + (3/4)*(N^5+1/N^5);
                
    % shrink cross-covariances
    rhoXY = rhoXY .* BXY ; 
end

% case 1: N < sqrt(2)
if N < sqrt(2)
    % cases
    leq1 = (x <= (N^2-1)/N) ;
    leq2 = ((N^2-1)/N < x & x <= 1/N);
    leq3 = (1/N < x & x <= N );
    leq4 = (N < x & x < (N^2+1)/N );

    % evaluation of fifth order piecewise rational function
    rhoXY(leq1) = -(1/6).*x(leq1).^5 + (1/2).*(1/N).*x(leq1).^4 -(5/3).*(1/N^3).*x(leq1).^2 + (5/2)*(1/N^3) - (3/2)*(1/N^5);
    rhoXY(leq2) = -(1/4).*x(leq2).^5 + (1/4).*(N+1/N).*x(leq2).^4 + (5/8).*x(leq2).^3 - (5/6).*(N^3+1/N^3).*x(leq2).^2 ...
                    +(5/4).*(N^4-N^2-1/N^2+1/N^4).*x(leq2) + (1/6).*(N^6+1/N^6)./x(leq2) - (3/8).*(N^4+1/N^4)./x(leq2) ...
                    +(5/12)./x(leq2) - (3/4)*(N^5+1/N^5) + (5/4)*(N^3+1/N^3);
    rhoXY(leq3) = -(1/12).*x(leq3).^5 + (1/4).*(N-1/N).*x(leq3).^4 + (5/8).*x(leq3).^3 - (5/6).*(N^3-1/N^3).*x(leq3).^2 ...
                    +(5/4).*(N^4-N^2-1/N^2-1/N^4).*x(leq3) + (5/12)./x(leq3) - (3/8).*(N^4+1/N^4)./x(leq3) ... 
                    +(1/6).*(N^6-1/N^6)./x(leq3) + (5/4)*(N^3+1/N^3) - (3/4)*(N^5-1/N^5);
    rhoXY(leq4) = (1/12).*x(leq4).^5 - (1/4).*(N+1/N).*x(leq4).^4 + (5/8).*x(leq4).^3 + (5/6).*(N^3+1/N^3).*x(leq4).^2 ...
                    -(5/4).*(N^4+N^2+1/N^2+1/N^4).*x(leq4) + (5/12)./x(leq4) - (3/8).*(N^4+1/N^4)./x(leq4) ... 
                    -(1/6).*(N^6+1/N^6)./x(leq4) + (5/4)*(N^3+1/N^3) + (3/4)*(N^5+1/N^5);
                
    % shrink cross-covariances
    rhoXY = rhoXY .* BXY ; 
end

rho(Ny+1:end, 1:Ny) = rhoXY;
rho(1:Ny, Ny+1:end) = rhoXY';

end

