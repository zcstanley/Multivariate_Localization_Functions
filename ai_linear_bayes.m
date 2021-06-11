function new_inflate = ai_linear_bayes(dist_2, prior_var, obs_var, inflate, gamma_corr, Ne, rate)
% Computes the linear approximation to the minima of the 
% likelihood function for adaptive inflation. 
%
% INPUTS: 
% dist_2 = distance ^ 2 between obs and prior mean
% prior_var = prior variance
% obs_var = observation error variance
% inflate = current inflation factor
% gamma_corr = localized prior sample correlation between the observation and state
% Ne = ensemble size
% rate = rate parameter for IG distribution
%
% OUTPUT:
% new_inflate = updated inflation factor
%
% Coded in FORTRAN by DART, Moved to Matlab by Zofia Stanley
% https://github.com/NCAR/DART/blob/main/assimilation_code/modules/assimilation/adaptive_inflate_mod.f90

% Scaling factors
fac1 = (1 + gamma_corr * (sqrt(inflate) - 1))^2 ;
fac2 = -1 / Ne ; 

% Compute value of theta at current lambda_mean
if ( fac1 < abs(fac2) ) 
    fac2 = 0 ;
end
theta_bar_2 = (fac1+fac2) * prior_var + obs_var ;
theta_bar   = sqrt(theta_bar_2) ;

% Compute constant coefficient for likelihood at lambda_bar
like_bar = exp(- 0.5 * dist_2 / theta_bar_2) / (sqrt(2 * pi) * theta_bar) ;

% If like_bar goes to 0, can't do anything, so just keep current values
% Density at current inflation value must be positive
if(like_bar <= 0) 
   new_inflate = inflate ;
   return
end

% Next compute derivative of likelihood at this point
deriv_theta = 0.5 * prior_var * gamma_corr * ( 1 - gamma_corr + gamma_corr * sqrt(inflate) ) /...
                                             ( theta_bar * sqrt(inflate) ) ;
like_prime  = like_bar * deriv_theta * (dist_2 / theta_bar_2 - 1) / theta_bar ;

% If like_prime goes to 0, can't do anything, so just keep current values
% We're dividing by the derivative in the quadratic equation, so this
% term better non-zero!
if( like_prime == 0 || abs(like_bar) <= eps || abs(like_prime) <= eps ) 
   new_inflate = inflate ;
   return
end
like_ratio = like_bar / like_prime ;

a = 1 - inflate / rate ; 
b = like_ratio - 2 * inflate ;
c = inflate^2 - like_ratio * inflate ;

% Use nice scaled quadratic solver to avoid precision issues
[plus_root, minus_root] = ai_solve_quadratic(a, b, c) ;

% Do a check to pick closest root
if(abs(minus_root - inflate) < abs(plus_root - inflate))
   new_inflate = minus_root ;
else
   new_inflate = plus_root ;
end

% Do a final check on the sign of the updated factor
% Sometimes the factor can be very small (almost zero) 
% From the selection process above it can be negative
% if the positive root is far away from it. 
% As such, keep the current factor value
if(new_inflate <= 0 || new_inflate ~= new_inflate) 
   new_inflate = inflate ;
end

end 