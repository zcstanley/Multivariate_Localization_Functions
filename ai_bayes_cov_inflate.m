function [new_inflate, new_inflate_sd] = ai_bayes_cov_inflate(Ne, prior_mean, prior_var, obs, obs_var,...
                inflate, inflate_sd, gamma_corr, sd_lower_bound, sd_max_change)
% Uses Gharamti 2017 algorithm in references on DART web site to update the 
% distribution of inflation.
%
% INPUTS:
% Ne = ensemble size
% prior_mean = mean of prior
% prior_var = variance of prior
% obs = observation
% obs_var = observation error variance
% inflate = current inflation factor
% inflate_sd = current inflation standard deviation
% gamma_corr = localized prior sample correlation between the observation and state
% sd_lower_bound = lower bound for updated inflation standard deviation
% sd_max_change = % by which inflation s.d. can grow each time without
%                   truncation
%
% OUTPUTS:
% new_inflate = updated inflation factor
% new_inflate_sd = updated inflation standard deviation
%
% Coded in FORTRAN by DART, Moved to Matlab by Zofia Stanley
% https://github.com/NCAR/DART/blob/main/assimilation_code/modules/assimilation/adaptive_inflate_mod.f90


% If gamma is 0, nothing changes
if(gamma_corr <= 0) 
   new_inflate = inflate ;
   new_inflate_sd = inflate_sd ;
   return
end

% Inflation variance
lambda_sd_2 = inflate_sd^2 ;

% Squared Innovation
dist_2 = (obs - prior_mean)^2 ;

% Transform Gaussian prior to Inverse Gamma
rate = ai_change_GA_IG(inflate, lambda_sd_2) ;

% Approximate with Taylor series for likelihood term
new_inflate = ai_linear_bayes(dist_2, prior_var, obs_var,inflate, gamma_corr, Ne, rate) ;

% Bail out to save cost when lower bound is reached on lambda standard deviation
if(abs(inflate_sd - sd_lower_bound) <= eps)
    new_inflate_sd = inflate_sd ;
    return 
else
    % Compute the shape parameter of the prior IG
    % This comes from the assumption that the mode of the IG is the mean/mode 
    % of the input Gaussian
    shape_old = rate / inflate - 1 ;
    if (shape_old <= 2)
        new_inflate_sd = inflate_sd ;
        return
    end
   
    % Evaluate exact IG posterior at p1: \lambda_u+\sigma_{\lambda_b} & p2: \lambda_u
    log_density_1 = ai_compute_new_log_density(dist_2, Ne, prior_var, obs_var, ...
                         shape_old, rate, gamma_corr, new_inflate+inflate_sd) ;
    log_density_2 = ai_compute_new_log_density(dist_2, Ne, prior_var, obs_var, ...
                         shape_old, rate, gamma_corr, new_inflate);
   
    % Computational errors check (small numbers + NaNs)
    if (abs(log_density_1) <= log(eps) || abs(log_density_2) <= log(eps) || log_density_1 ~= log_density_1 || log_density_2 ~= log_density_2)
         new_inflate_sd = inflate_sd ;
         return
    end
   
    % Now, compute omega and the new distribution parameters
    log_ratio = log_density_1 - log_density_2 ;
    omega = log(new_inflate)/new_inflate + 1/new_inflate - log(new_inflate+inflate_sd)/new_inflate - 1/(new_inflate+inflate_sd) ;
    rate_new  = log_ratio / omega ;
    shape_new = rate_new / new_inflate - 1 ;
   
    % Finally, get the sd of the IG posterior
    if (shape_new <= 2)
        new_inflate_sd = inflate_sd ;
        return
    end
    new_inflate_sd = sqrt(rate_new^2 / ( (shape_new-1)^2 * (shape_new-2) )) ;
   
    % If the updated variance is more than xx% the prior variance, keep the prior unchanged 
    % for stability reasons. Also, if the updated variance is NaN, keep the prior variance unchanged. 
    if ( new_inflate_sd > sd_max_change*inflate_sd || new_inflate_sd ~= new_inflate_sd) 
        new_inflate_sd = inflate_sd;
        return
    end

end 