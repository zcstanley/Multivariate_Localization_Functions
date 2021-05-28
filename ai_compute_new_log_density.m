function log_density = ai_compute_new_log_density(dist_2, Ne, sigma_p_2, sigma_o_2, alpha1, beta1, gamma_corr, lambda)
% This function computes the log density of inverse gamma for adaptive 
% inflation. Because this is used in comparison only, terms that
% are constant in alpha1 and beta1 are exlcuded.
% Code heavily modeled on DART code, which can be found here:
% https://github.com/NCAR/DART/blob/main/assimilation_code/modules/assimilation/adaptive_inflate_mod.f90

% Compute probability of this lambda being correct (prior)
exp_prior = - beta1 / lambda ;

% Compute probability that observation would have been observed given this
% lambda (likelihood)
fac1 = (1 + gamma_corr * (sqrt(lambda) - 1))^2 ;
fac2 = -1 / Ne ;
if ( fac1 < abs(fac2) ) 
    fac2 = 0 ;
end

theta    = sqrt( (fac1+fac2) * sigma_p_2 + sigma_o_2 ) ;
exp_like = (- 0.5 * dist_2) / (theta^2) ; 

% Compute the updated probability density for lambda
log_density =  (-alpha1-1)*log(lambda) - log(theta) +  exp_like + exp_prior ;

end