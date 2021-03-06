% Computes and saves true forecast error correlations in EnKF for
% Bivariate Lorenz 96
%
% Author: Zofia Stanley

%% Set fixed parameters
params = struct('K',36,'J',10,'F',10,'a',10,'b',10,'h',2);  %L96 params
Nt = 3000;                      % Number of assimilation cycles
sigma2Y = 0.005;                % Y obs error variance
sigma2X = 0.28;                 % X obs error variance
x_position = 'middle';          % Where is X_k located? (middle or first)
rInf = 1.1;                     % Inflation factor 
Adapt_Inf = true;               % Use adaptive inflation or constant inflation?
Ne = 500;                       % Ensemble size
True_Fcast_Err = true;          % Save true forecast error correlations?
loc_fun_name = 'no_loc';        % localization function name
loc_params = struct('hack',1);  % localization parameters
Ntrial = 10;                    % Number of trials

%% Run Experiments

% 1. All Y, No X
fprintf('All Y, No X.\n')
dtObs = 0.005;         % Time between assimilation cycles
Frac_Obs_Y = 1;        % Fraction of Y variables that are observed
Frac_Obs_X = 0;        % Fraction of X variables that are observed
[~, ~, FCAST_ERR_YnoX] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                            Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                            loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
FCAST_ERR_YnoX = mean(FCAST_ERR_YnoX(:, :, 1001:end), 3);
save('Data/true_forecast_error.mat', 'FCAST_ERR_YnoX')


% 2. All X, No Y
fprintf('\nAll X, No Y.\n')
dtObs = 0.05;          % Time between assimilation cycles
Frac_Obs_Y = 0;        % Fraction of Y variables that are observed
Frac_Obs_X = 1;        % Fraction of X variables that are observed
[~, ~, FCAST_ERR_XnoY] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                            Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                            loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
FCAST_ERR_XnoY = mean(FCAST_ERR_XnoY(:, :, 1001:end), 3);
save('Data/true_forecast_error.mat', 'FCAST_ERR_XnoY', '-append')


% 3. Both X and Y
fprintf('\nBoth X and Y.\n')
dtObs = 0.005;          % Time between assimilation cycles
Frac_Obs_Y = 0.75;      % Fraction of Y variables that are observed
Frac_Obs_X = 0.75;      % Fraction of X variables that are observed
sigma2Y = 0.01;         % Y obs error variance
sigma2X = 0.57;         % X obs error variance
[~, ~, FCAST_ERR_BothXY] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                            Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                            loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
FCAST_ERR_BothXY = mean(FCAST_ERR_BothXY(:, :, 1001:end), 3);
save('Data/true_forecast_error.mat', 'FCAST_ERR_BothXY', '-append')

