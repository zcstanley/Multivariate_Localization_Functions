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
Ntrial = 50;             % Number of trials
start = 1001;           % first assimilation cycle considered in RMSE computations
dtObs = 0.05;           % Time between assimilation cycles
Frac_Obs_Y = 0;         % Fraction of Y variables that are observed
Frac_Obs_X = 1;         % Fraction of X variables that are observed
rYY = 20;               % within-component localization radius for Y
rXX = 40;               % within-component localization radius for X
rXY = min(rYY, rXX);    % cross-localization radius for Askey and Wendland
savefile = 'observe_x_Ne50.mat';

%% Univariate functions

% 1A. Gaspari-Cohn
fprintf('\nGaspari-Cohn\n')
loc_fun_name = 'gaspari_cohn' ; % localization function name
loc_params = struct('rYY', rYY, 'rXX', rYY, 'beta', 1); % localization parameters
[RMSE_Y_XnoY_UVGC, RMSE_X_XnoY_UVGC] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);

save(savefile,  'RMSE_Y_XnoY_UVGC', 'RMSE_X_XnoY_UVGC')

%{
% 1B. Bolin-Wallin
fprintf('\nBolin-Wallin\n')
loc_fun_name = 'bolin_wallin' ;
loc_params = struct('rYY', rYY, 'rXX', rYY, 'beta', 1); 
[RMSE_Y_XnoY_UVBW, RMSE_X_XnoY_UVBW] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
save(savefile, 'RMSE_Y_XnoY_UVBW', 'RMSE_X_XnoY_UVBW', '-append')

% 1C. Askey
fprintf('\nAskey\n')
loc_fun_name = 'askey' ; 
loc_params = struct('rYY', rYY, 'rXX', rYY, 'rXY', rYY, 'nu', 1,... 
                    'gammaYY', 0, 'gammaXX', 0, 'gammaXY', 0,'beta', 1); 
[RMSE_Y_XnoY_UVA, RMSE_X_XnoY_UVA] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
save(savefile, 'RMSE_Y_XnoY_UVA', 'RMSE_X_XnoY_UVA', '-append')

% 1D. Wendland
fprintf('\nWendland\n')
loc_fun_name = 'wendland' ; 
loc_params = struct('rYY', rYY, 'rXX', rYY, 'rXY', rYY, 'nu', 2,... 
                    'gammaYY', 0, 'gammaXX', 0, 'gammaXY', 0, 'k', 1, 'beta', 1); 
[RMSE_Y_XnoY_UVW, RMSE_X_XnoY_UVW] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);

save(savefile, 'RMSE_Y_XnoY_UVW', 'RMSE_X_XnoY_UVW', '-append')
%}

%% Multivariate functions

% 2A. Gaspari-Cohn
fprintf('\nGaspari-Cohn\n')
loc_fun_name = 'gaspari_cohn' ; % localization function name
loc_params = struct('rYY', rYY, 'rXX', rXX); % localization parameters
loc_params.beta = gaspari_cohn_beta_max(loc_params);
[RMSE_Y_XnoY_MVGC, RMSE_X_XnoY_MVGC] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);

save(savefile,  'RMSE_Y_XnoY_MVGC', 'RMSE_X_XnoY_MVGC', '-append')

%{
% 2B. Bolin-Wallin
fprintf('\nBolin-Wallin\n')
loc_fun_name = 'bolin_wallin' ;
loc_params = struct('rYY', rYY, 'rXX', rXX); 
loc_params.beta = bolin_wallin_beta_max(loc_params);
[RMSE_Y_XnoY_MVBW, RMSE_X_XnoY_MVBW] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
save(savefile, 'RMSE_Y_XnoY_MVBW', 'RMSE_X_XnoY_MVBW', '-append')

% 2C. Askey
fprintf('\nAskey\n')
loc_fun_name = 'askey' ;
loc_params = struct('rYY', rYY, 'rXX', rXX, 'rXY', rXY, 'nu', 1,... 
                    'gammaYY', 2, 'gammaXX', 0, 'gammaXY', 1); 
loc_params.beta = askey_beta_max(loc_params);
[RMSE_Y_XnoY_MVA, RMSE_X_XnoY_MVA] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
save(savefile, 'RMSE_Y_XnoY_MVA', 'RMSE_X_XnoY_MVA', '-append')

% 2D. Wendland
fprintf('\nWendland\n')
loc_fun_name = 'wendland' ;
loc_params = struct('rYY', rYY, 'rXX', rXX, 'rXY', rXY, 'nu', 2,... 
                    'gammaYY', 2, 'gammaXX', 0, 'gammaXY', 1, 'k', 1);
loc_params.beta = wendland_beta_max(loc_params);
[RMSE_Y_XnoY_MVW, RMSE_X_XnoY_MVW] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
save(savefile, 'RMSE_Y_XnoY_MVW', 'RMSE_X_XnoY_MVW', '-append')
%}

%% Weakly coupled

% 3A. Gaspari-Cohn
fprintf('\nGaspari-Cohn\n')
loc_fun_name = 'gaspari_cohn' ; % localization function name
loc_params = struct('rYY', rYY, 'rXX', rXX, 'beta', 0); % localization parameters
[RMSE_Y_XnoY_WCGC, RMSE_X_XnoY_WCGC] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);

save(savefile,  'RMSE_Y_XnoY_WCGC', 'RMSE_X_XnoY_WCGC', '-append')

%{
% 3B. Bolin-Wallin
fprintf('\nBolin-Wallin\n')
loc_fun_name = 'bolin_wallin' ;
loc_params = struct('rYY', rYY, 'rXX', rXX, 'beta', 0); 
[RMSE_Y_XnoY_WCBW, RMSE_X_XnoY_WCBW] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
save(savefile, 'RMSE_Y_XnoY_WCBW', 'RMSE_X_XnoY_WCBW', '-append')

% 3C. Askey
fprintf('\nAskey\n')
loc_fun_name = 'askey' ;
loc_params = struct('rYY', rYY, 'rXX', rXX, 'rXY', rXY, 'nu', 1,... 
                    'gammaYY', 2, 'gammaXX', 0, 'gammaXY', 1, 'beta', 0); 
[RMSE_Y_XnoY_WCA, RMSE_X_XnoY_WCA] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
save(savefile, 'RMSE_Y_XnoY_WCA', 'RMSE_X_XnoY_WCA', '-append')

% 3D. Wendland
fprintf('\nWendland\n')
loc_fun_name = 'wendland' ;
loc_params = struct('rYY', rYY, 'rXX', rXX, 'rXY', rXY, 'nu', 2,... 
                    'gammaYY', 2, 'gammaXX', 0, 'gammaXY', 1, 'k', 1, 'beta', 0);
[RMSE_Y_XnoY_WCW, RMSE_X_XnoY_WCW] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
save(savefile, 'RMSE_Y_XnoY_WCW', 'RMSE_X_XnoY_WCW', '-append')

%}