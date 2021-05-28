function [rInf, rSig] = adaptive_inflation(H, X, Y, N, No, Ne, obs_var_vec, loc, rInf, rSig)
% This function implements adaptive inflation for EnKF,
% following El Gharamti, M.: Enhanced Adaptive Inflation Algorithm for Ensemble Filters, MWR
% https://doi.org/10.1175/MWR-D-17-0187.1, 2018
%
% INPUTS:
%
% OUTPUTS:
%

% Hard-coded constraints, could easily pass these as parameters and allow
% for more flexibility, but hard-coded is fine for this example.
inf_lower_bound = 0.8 ; 
inf_upper_bound = 1.5 ;
sd_lower_bound = 0.1;
sd_max_change = 10;

% Calculate prior sample correlations between observation and state
yp = H*X; % prior obs
corr_obs_state = corr(yp', X');

for kk=1:No % loop over observations
    obs = Y(kk); % kk-th obs at this time, y_o
    obs_var = obs_var_vec(kk);
    prior_mean = mean(yp(kk, :)) ; %x_p
    prior_var  = sum( (yp(kk, :) - mean(yp(kk,:))).^2 ) / (Ne - 1); %sigma_p_2
    for jj=1:N % loop over states
        % localized prior sample correlation between the observation and state
        gamma_corr = corr_obs_state(kk, jj)*loc(kk, jj); 
        inflate = rInf(jj); % inflation value at state 
        inflate_sd = rSig(jj);
        [new_inflate, new_inflate_sd] = ai_bayes_cov_inflate(Ne, prior_mean, prior_var, obs, obs_var, inflate,...
                                         inflate_sd, gamma_corr, sd_lower_bound, sd_max_change);
                                     
        % Make sure inflate satisfies constraints
        inflate = new_inflate ;
        if(inflate < inf_lower_bound) 
            inflate = inf_lower_bound ;
        elseif(inflate > inf_upper_bound) 
            inflate = inf_upper_bound ;
        end
        
        %Make sure sd satisfies constraints
        inflate_sd = new_inflate_sd ;
        if(inflate_sd < sd_lower_bound) 
            inflate_sd = sd_lower_bound;
        end
        
        % Store updated inflation and sd values
        rInf(jj) = inflate ; % inflation value at state 
        rSig(jj) = inflate_sd ;
                        
    end % end states loop(jj)
end % end obs loop (kk)

end