%% Set fixed parameters
params = struct('K',36,'J',10,'F',10,'a',10,'b',10,'h',2);  %L96 params
Nt = 3000;              % Number of assimilation cycles
Ne = 20;                % Ensemble size
x_position = 'middle';  % Where is X_k located? (middle or first)
rInf = 1.1;             % Inflation factor 
Adapt_Inf = true;       % Use adaptive inflation or constant inflation?
True_Fcast_Err = false; % Save true forecast error correlations?
Ntrial = 50;             % Number of trials
start = 1001;           % first assimilation cycle considered in RMSE computations
dtObs = 0.005;          % Time between assimilation cycles
Frac_Obs_Y = 0.75;      % Fraction of Y variables that are observed
Frac_Obs_X = 0.75;      % Fraction of X variables that are observed
sigma2Y = 0.01;         % Y obs error variance
sigma2X = 0.57;         % X obs error variance
rYY = 15;               % Localization radius for process Y
rXX = 40;               % Localization radius for process X
rXY = min(rYY, rXX);    % Cross-localization radius for Askey and Wendland
savefile = 'observe_x_and_y_Ne50.mat';

%% Univariate functions

fprintf('\nUnivariate\n')

% 1A. Gaspari-Cohn
fprintf('\nGaspari-Cohn\n')
loc_fun_name = 'gaspari_cohn' ; % localization function name
loc_params = struct('rYY', rYY, 'rXX', rYY, 'beta', 1); % localization parameters
[RMSE_Y_BothXY_UVGC, RMSE_X_BothXY_UVGC] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);

save(savefile,  'RMSE_Y_BothXY_UVGC', 'RMSE_X_BothXY_UVGC')

%{
% 1B. Bolin-Wallin
fprintf('\nBolin-Wallin\n')
loc_fun_name = 'bolin_wallin' ;
loc_params = struct('rYY', rYY, 'rXX', rYY, 'beta', 1); 
[RMSE_Y_BothXY_UVBW, RMSE_X_BothXY_UVBW] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
save(savefile, 'RMSE_Y_BothXY_UVBW', 'RMSE_X_BothXY_UVBW', '-append')

% 1C. Askey
fprintf('\nAskey\n')
loc_fun_name = 'askey' ; 
loc_params = struct('rYY', rYY, 'rXX', rYY, 'rXY', rYY, 'nu', 1,... 
                    'gammaYY', 0, 'gammaXX', 0, 'gammaXY', 0,'beta', 1); 
[RMSE_Y_BothXY_UVA, RMSE_X_BothXY_UVA] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
save(savefile, 'RMSE_Y_BothXY_UVA', 'RMSE_X_BothXY_UVA', '-append')

% 1D. Wendland
fprintf('\nWendland\n')
loc_fun_name = 'wendland' ; 
loc_params = struct('rYY', rYY, 'rXX', rYY, 'rXY', rYY, 'nu', 2,... 
                    'gammaYY', 0, 'gammaXX', 0, 'gammaXY', 0, 'k', 1, 'beta', 1); 
[RMSE_Y_BothXY_UVW, RMSE_X_BothXY_UVW] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);

save(savefile, 'RMSE_Y_BothXY_UVW', 'RMSE_X_BothXY_UVW', '-append')
%}

%% Multivariate functions
fprintf('\nMultivariate\n')

% 2A. Gaspari-Cohn
fprintf('\nGaspari-Cohn\n')
loc_fun_name = 'gaspari_cohn' ; % localization function name
loc_params = struct('rYY', rYY, 'rXX', rXX, 'beta', 0.3); % localization parameters
[RMSE_Y_BothXY_MVGC, RMSE_X_BothXY_MVGC] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);

save(savefile,  'RMSE_Y_BothXY_MVGC', 'RMSE_X_BothXY_MVGC', '-append')

%{
% 2B. Bolin-Wallin
fprintf('\nBolin-Wallin\n')
loc_fun_name = 'bolin_wallin' ;
loc_params = struct('rYY', rYY, 'rXX', rXX, 'beta', 0.1); 
[RMSE_Y_BothXY_MVBW, RMSE_X_BothXY_MVBW] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
save(savefile, 'RMSE_Y_BothXY_MVBW', 'RMSE_X_BothXY_MVBW', '-append')

% 2C. Askey
fprintf('\nAskey\n')
loc_fun_name = 'askey' ;
loc_params = struct('rYY', rYY, 'rXX', rXX, 'rXY', rXY, 'nu', 1,... 
                    'gammaYY', 2, 'gammaXX', 1, 'gammaXY', 19/16, 'beta', 0.2); 
[RMSE_Y_BothXY_MVA, RMSE_X_BothXY_MVA] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
save(savefile, 'RMSE_Y_BothXY_MVA', 'RMSE_X_BothXY_MVA', '-append')

% 2D. Wendland
fprintf('\nWendland\n')
loc_fun_name = 'wendland' ;
loc_params= struct('rYY', rYY, 'rXX', rXX, 'rXY', rXY, 'nu', 2,... 
                    'gammaYY', 2, 'gammaXX', 0, 'gammaXY', 1, 'k', 1);
loc_params.beta = wendland_beta_max(loc_params);
[RMSE_Y_BothXY_MVW, RMSE_X_BothXY_MVW] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
save(savefile, 'RMSE_Y_BothXY_MVW', 'RMSE_X_BothXY_MVW', '-append')
%}

%% Weakly coupled
fprintf('\nWeakly Coupled\n')

% 3A. Gaspari-Cohn
fprintf('\nGaspari-Cohn\n')
loc_fun_name = 'gaspari_cohn' ; % localization function name
loc_params = struct('rYY', rYY, 'rXX', rXX, 'beta', 0); % localization parameters
[RMSE_Y_BothXY_WCGC, RMSE_X_BothXY_WCGC] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);

save(savefile,  'RMSE_Y_BothXY_WCGC', 'RMSE_X_BothXY_WCGC', '-append')

%{
% 3B. Bolin-Wallin
fprintf('\nBolin-Wallin\n')
loc_fun_name = 'bolin_wallin' ;
loc_params = struct('rYY', rYY, 'rXX', rXX, 'beta', 0); 
[RMSE_Y_BothXY_WCBW, RMSE_X_BothXY_WCBW] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
save(savefile, 'RMSE_Y_BothXY_WCBW', 'RMSE_X_BothXY_WCBW', '-append')

% 3C. Askey
fprintf('\nAskey\n')
loc_fun_name = 'askey' ;
loc_params = struct('rYY', rYY, 'rXX', rXX, 'rXY', rXY, 'nu', 1,... 
                    'gammaYY', 2, 'gammaXX', 1, 'gammaXY', 19/16, 'beta', 0); 
[RMSE_Y_BothXY_WCA, RMSE_X_BothXY_WCA] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
save(savefile, 'RMSE_Y_BothXY_WCA', 'RMSE_X_BothXY_WCA', '-append')

% 3D. Wendland
fprintf('\nWendland\n')
loc_fun_name = 'wendland' ;
loc_params= struct('rYY', rYY, 'rXX', rXX, 'rXY', rXY, 'nu', 2,... 
                    'gammaYY', 2, 'gammaXX', 0, 'gammaXY', 1, 'k', 1, 'beta', 0);
[RMSE_Y_BothXY_WCW, RMSE_X_BothXY_WCW] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
save(savefile, 'RMSE_Y_BothXY_WCW', 'RMSE_X_BothXY_WCW', '-append')
%}