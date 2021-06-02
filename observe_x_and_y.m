%% Set fixed parameters
params = struct('K',36,'J',10,'F',10,'a',10,'b',10,'h',2);  %L96 params
Nt = 3000;              % Number of assimilation cycles
sigma2Y = 0.005;        % Y obs error variance
sigma2X = 0.28;         % X obs error variance
Ne = 20;                % Ensemble size
x_position = 'middle';  % Where is X_k located? (middle or first)
rInf = 1.1;             % Inflation factor 
Adapt_Inf = true;       % Use adaptive inflation or constant inflation?
True_Fcast_Err = false; % Save true forecast error correlations?
Ntrial = 3;             % Number of trials
start = 1001;           % first assimilation cycle considered in RMSE computations
dtObs = 0.005;          % Time between assimilation cycles
Frac_Obs_Y = 0.75;      % Fraction of Y variables that are observed
Frac_Obs_X = 0.75;      % Fraction of X variables that are observed
sigma2Y = 0.01;         % Y obs error variance
sigma2X = 0.57;         % X obs error variance
rYY = 15;               % Localization radius for process Y

%% Univariate functions

% 1A. Gaspari-Cohn
fprintf('\nGaspari-Cohn\n')
loc_fun_name = 'gaspari_cohn' ; % localization function name
loc_params = struct('rYY', rYY, 'rXX', rYY, 'beta', 1); % localization parameters
[RMSE_Y_BothXY_UVGC, RMSE_X_BothXY_UVGC] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);

save('observe_x_and_y.mat',  'RMSE_Y_BothXY_UVGC', 'RMSE_X_BothXY_UVGC')


% 1B. Bolin-Wallin
fprintf('\nBolin-Wallin\n')
loc_fun_name = 'bolin_wallin' ;
loc_params = struct('rYY', rYY, 'rXX', rYY, 'beta', 1); 
[RMSE_Y_BothXY_UVBW, RMSE_X_BothXY_UVBW] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
save('observe_x_and_y.mat', 'RMSE_Y_BothXY_UVBW', 'RMSE_X_BothXY_UVBW', '-append')

% 1C. Askey
fprintf('\nAskey\n')
loc_fun_name = 'askey' ; 
loc_params = struct('rYY', rYY, 'rXX', rYY, 'rXY', rYY, 'nu', 1,... 
                    'gammaYY', 0, 'gammaXX', 0, 'gammaXY', 0,'beta', 1); 
[RMSE_Y_BothXY_UVA, RMSE_X_BothXY_UVA] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
save('observe_x_and_y.mat', 'RMSE_Y_BothXY_UVA', 'RMSE_X_BothXY_UVA', '-append')

% 1D. Wendland
fprintf('\nWendland\n')
loc_fun_name = 'wendland' ; 
loc_params = struct('rYY', rYY, 'rXX', rYY, 'rXY', rYY, 'nu', 2,... 
                    'gammaYY', 0, 'gammaXX', 0, 'gammaXY', 0, 'k', 1, 'beta', 1); 
[RMSE_Y_BothXY_UVW, RMSE_X_BothXY_UVW] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);

save('observe_x_and_y.mat', 'RMSE_Y_BothXY_UVW', 'RMSE_X_BothXY_UVW', '-append')
