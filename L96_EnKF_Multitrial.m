function [RMSE_Y, RMSE_X, FCAST_ERR] = L96_EnKF_Multitrial(params, Nt, dtObs, ...
                                        sigma2Y, sigma2X, Frac_Obs_Y, Frac_Obs_X,... 
                                        Ne, x_position, rInf, Adapt_Inf,... 
                                        loc_fun_name, loc_params, True_Fcast_Err, Ntrial)
% Calculates RMSE for multiple trials of EnKF
% 
% INPUTS:
% params = L96 params
% Nt = Number of assimilation cycles
% dtObs = Time between assimilation cycles
% sigma2Y = Y obs error variance
% sigma2X = X obs error variance
% Frac_Obs_Y = fraction of Y process that is observed
% Frac_Obs_X = fraction of X process that is observed
% Ne = Ensemble size
% x_position =  Where is X_k located? (middle or first)
% rInf = Inflation factor 
% Adapt_Inf = Use adaptive inflation or constant inflation? (boolean)
% loc_fun_name = Localization function name
% loc_params = Localization parameters
% True_Fcast_Err = save true forecast error correlations? (boolean)
% Ntrial = number of trials
%
% OUTPUTS:
% RMSE_Y = root mean square error for process Y
% RMSE_X = root mean square error for process X
% FCAST_ERR = true forecast error correlations
%
% Author: Zofia Stanley

% Intialize arrays
RMSE_Y = zeros(Ntrial, Nt);
RMSE_X = zeros(Ntrial, Nt);
if True_Fcast_Err
    [~, ~, N] = derived_parameters(params, Frac_Obs_Y, Frac_Obs_X);
    FCAST_ERR = zeros(N, N, Nt);
end


% Run trials
for trial = 1:Ntrial
    % Print status
    fprintf('Iteration %g out of %g.\n', trial, Ntrial)
    
    % Run EnKF
    if ~True_Fcast_Err
        [rmsY, rmsX] = L96_EnKF(params, Nt, dtObs, sigma2Y, sigma2X, ...
                        Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, ...
                        Adapt_Inf, loc_fun_name, loc_params, True_Fcast_Err);
    else
        [rmsY, rmsX, fcast_err] = L96_EnKF(params, Nt, dtObs, sigma2Y, sigma2X, ...
                        Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, ...
                        Adapt_Inf, loc_fun_name, loc_params, True_Fcast_Err);
        FCAST_ERR(:, :, :) = FCAST_ERR + fcast_err./Ntrial;
    end
    
    % Save RMSE
    RMSE_Y(trial, :) = rmsY;
    RMSE_X(trial, :) = rmsX;
end