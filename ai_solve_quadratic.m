function [root1, root2] = ai_solve_quadratic(a, b, c)
% Scaled quadratic solver to avoid precision issues.
%
% INPUTS:
% a, b, c = coefficients of quadratic polynomial, ax^2 + bx + c
%
% OUTPUTS:
% root1, root2 = two roots of quadratic polynomial
%
% Coded in FORTRAN by DART, Moved to Matlab by Zofia Stanley
% https://github.com/NCAR/DART/blob/main/assimilation_code/modules/assimilation/adaptive_inflate_mod.f90

% Scale the coefficients to get better round-off tolerance
scaling = max([abs(a), abs(b), abs(c)]) ;
as = a / scaling ;
bs = b / scaling ;
cs = c / scaling ;

% Get discriminant of scaled equation
disc = sqrt(bs^2 - 4 * as * cs) ;

if(bs > 0)
   root1 = (-bs - disc) / (2 * as) ;
else
   root1 = (-bs + disc) / (2 * as) ;
end

% Compute the second root given the larger one
root2 = (cs / as) / root1 ;

end 