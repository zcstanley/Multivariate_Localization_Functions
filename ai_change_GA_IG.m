function beta = ai_change_GA_IG(mode, var)
% Routine to change the Gaussian prior into an inverse gamma (IG).
% The Gaussian prior is represented by a mode (:= mean) and a variance; var
%
% INPUTS:
% mode = mode/mean of Gaussian prior
% var = variance of Gaussian prior
%
% OUTPUT:
% beta = rate parameter for IG distribution
%
% Coded in FORTRAN by DART, Moved to Matlab by Zofia Stanley
% https://github.com/NCAR/DART/blob/main/assimilation_code/modules/assimilation/adaptive_inflate_mod.f90

% Computation savers - powers are computationally expensive
var_p = zeros(3, 1);
var_p(1) = var ;
for i=2:3
   var_p(i) = var_p(i-1)*var ;
end

mode_p = zeros(9,1);
mode_p(1) = mode ;
for i = 2:9
  mode_p(i) = mode_p(i-1)*mode ;
end

% Calculate the rate parameter for IG distribution.
% It's a function of both the prior mean and variance, 
% obtained as a "real" solution to a cubic polynomial.
AA = mode_p(4) * sqrt((var_p(2) + 47*var*mode_p(2) + 3*mode_p(4)) / var_p(3));
BB = 75*var_p(2)*mode_p(5);
CC = 21*var*mode_p(7);
DD = var_p(3)*mode_p(3);
EE = (CC + BB + DD + mode_p(9) + 6*sqrt(3)*AA*var_p(3)) / var_p(3);

beta = (7*var*mode + mode_p(3))/(3*var)+ EE^(1/3)/3 + ... 
        mode_p(2)*(var_p(2) + 14*var*mode_p(2) + mode_p(4)) / (3*var_p(2)*EE^(1/3)) ;

end