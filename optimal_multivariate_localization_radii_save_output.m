%% Saves output from EnKF with different multivariate localization radii
%
% Author: Zofia Stanley

%% Set fixed parameters
params = struct('K',36,'J',10,'F',10,'a',10,'b',10,'h',2);  %L96 params
Nt = 3000;              % Number of assimilation cycles
sigma2Y = 0.005;        % Y obs error variance
sigma2X = 0.28;         % X obs error variance
Ne = 20;                % Ensemble size
x_position = 'middle';  % Where is X_k located? (middle or first)
rInf = sqrt(1.21);      % Inflation factor 
Adapt_Inf = true;       % Use adaptive inflation or constant inflation?
True_Fcast_Err = false; % Save true forecast error correlations?
Ntrial = 3;             % Number of trials
loc_rad = [30, 40, 45, 50, 60, 75]; % localization radii
start = 1001;           % first assimilation cycle considered in RMSE computations

%% Run Experiments


% 1. All Y, No X
fprintf('All Y, No X.\n')
dtObs = 0.005;         % Time between assimilation cycles
Frac_Obs_Y = 1;        % Fraction of Y variables that are observed
Frac_Obs_X = 0;        % Fraction of X variables that are observed
rYY = 15;

% Initialize arrays
RMSE_Y_YnoX_MVGC = zeros(1, length(loc_rad));
RMSE_X_YnoX_MVGC = zeros(1, length(loc_rad));
RMSE_Y_YnoX_MVBW = zeros(1, length(loc_rad));
RMSE_X_YnoX_MVBW = zeros(1, length(loc_rad));
RMSE_Y_YnoX_MVA = zeros(1, length(loc_rad));
RMSE_X_YnoX_MVA = zeros(1, length(loc_rad));
RMSE_Y_YnoX_MVW = zeros(1, length(loc_rad));
RMSE_X_YnoX_MVW = zeros(1, length(loc_rad));

% 1A. Gaspari-Cohn
fprintf('\nGaspari-Cohn\n')
loc_fun_name = 'gaspari_cohn' ; % localization function name
loc_params = struct('rYY', rYY); % localization parameters
for ii = 1:length(loc_rad)
    rXX = loc_rad(ii);
    loc_params.rXX = rXX;
    loc_params.beta = gaspari_cohn_beta_max(loc_params);
    [RMSE_Y, RMSE_X] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
    RMSE_Y_YnoX_MVGC(ii) = mean(reshape(RMSE_Y(:, start:end), 1, []));
    RMSE_X_YnoX_MVGC(ii) = mean(reshape(RMSE_X(:, start:end), 1, []));
end
save('optimal_multivariate_localization_radii.mat', 'loc_rad', 'RMSE_Y_YnoX_MVGC', 'RMSE_X_YnoX_MVGC')


% 1B. Bolin-Wallin
fprintf('\nBolin-Wallin\n')
loc_fun_name = 'bolin_wallin' ;
loc_params = struct('rYY', rYY); % localization parameters
for ii = 1:length(loc_rad)
    rXX = loc_rad(ii);
    loc_params.rXX = rXX;
    loc_params.beta = bolin_wallin_beta_max(loc_params);
    [RMSE_Y, RMSE_X] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
    RMSE_Y_YnoX_MVBW(ii) = mean(reshape(RMSE_Y(:, start:end), 1, []));
    RMSE_X_YnoX_MVBW(ii) = mean(reshape(RMSE_X(:, start:end), 1, []));
end
save('optimal_multivariate_localization_radii.mat', 'RMSE_Y_YnoX_MVBW', 'RMSE_X_YnoX_MVBW', '-append')

% 1C. Askey
fprintf('\nAskey\n')
loc_fun_name = 'askey' ; 
loc_params = struct('rYY', rYY, 'nu', 1, 'gammaYY', 0, 'gammaXX', 0, 'gammaXY', 0); 
for ii = 1:length(loc_rad)
    rXX = loc_rad(ii);
    rXY = min(rYY, rXX);
    loc_params.rXX = rXX;
    loc_params.rXY = rXY; 
    loc_params.beta = askey_beta_max(loc_params);
    [RMSE_Y, RMSE_X] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
    RMSE_Y_YnoX_MVA(ii) = mean(reshape(RMSE_Y(:, start:end), 1, []));
    RMSE_X_YnoX_MVA(ii) = mean(reshape(RMSE_X(:, start:end), 1, []));
end
save('optimal_multivariate_localization_radii.mat', 'RMSE_Y_YnoX_MVA', 'RMSE_X_YnoX_MVA', '-append')

% 1D. Wendland
fprintf('\nWendland\n')
loc_fun_name = 'wendland' ; 
loc_params = struct('rYY', rYY, 'nu', 2, 'gammaYY', 0, 'gammaXX', 0, 'gammaXY', 0, 'k', 1); 
for ii = 1:length(loc_rad)
    rXX = loc_rad(ii);
    rXY = min(rYY, rXX);
    loc_params.rXX = rXX;
    loc_params.rXY = rXY; 
    loc_params.beta = wendland_beta_max(loc_params);
    [RMSE_Y, RMSE_X] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
    RMSE_Y_YnoX_MVW(ii) = mean(reshape(RMSE_Y(:, start:end), 1, []));
    RMSE_X_YnoX_MVW(ii) = mean(reshape(RMSE_X(:, start:end), 1, []));
end
save('optimal_multivariate_localization_radii.mat', 'RMSE_Y_YnoX_MVW', 'RMSE_X_YnoX_MVW', '-append')

% 2. All X, No Y
fprintf('\nAll X, No Y.\n')
dtObs = 0.05;          % Time between assimilation cycles
Frac_Obs_Y = 0;        % Fraction of Y variables that are observed
Frac_Obs_X = 1;        % Fraction of X variables that are observed
rYY = 20;

% Initialize arrays
RMSE_Y_XnoY_MVGC = zeros(1, length(loc_rad));
RMSE_X_XnoY_MVGC = zeros(1, length(loc_rad));
RMSE_Y_XnoY_MVBW = zeros(1, length(loc_rad));
RMSE_X_XnoY_MVBW = zeros(1, length(loc_rad));
RMSE_Y_XnoY_MVA = zeros(1, length(loc_rad));
RMSE_X_XnoY_MVA = zeros(1, length(loc_rad));
RMSE_Y_XnoY_MVW = zeros(1, length(loc_rad));
RMSE_X_XnoY_MVW = zeros(1, length(loc_rad));

% 2A. Gaspari-Cohn
fprintf('\nGaspari-Cohn\n')
loc_fun_name = 'gaspari_cohn' ; % localization function name
loc_params = struct('rYY', rYY); % localization parameters
for ii = 1:length(loc_rad)
    rXX = loc_rad(ii);
    loc_params.rXX = rXX;
    loc_params.beta = gaspari_cohn_beta_max(loc_params);
    [RMSE_Y, RMSE_X] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
    RMSE_Y_XnoY_MVGC(ii) = mean(reshape(RMSE_Y(:, start:end), 1, []));
    RMSE_X_XnoY_MVGC(ii) = mean(reshape(RMSE_X(:, start:end), 1, []));
end
save('optimal_multivariate_localization_radii.mat', 'RMSE_Y_XnoY_MVGC', 'RMSE_X_XnoY_MVGC', '-append')


% 2B. Bolin-Wallin
fprintf('\nBolin-Wallin\n')
loc_fun_name = 'bolin_wallin' ;
loc_params = struct('rYY', rYY); % localization parameters
for ii = 1:length(loc_rad)
    rXX = loc_rad(ii);
    loc_params.rXX = rXX;
    loc_params.beta = bolin_wallin_beta_max(loc_params);
    [RMSE_Y, RMSE_X] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
    RMSE_Y_XnoY_MVBW(ii) = mean(reshape(RMSE_Y(:, start:end), 1, []));
    RMSE_X_XnoY_MVBW(ii) = mean(reshape(RMSE_X(:, start:end), 1, []));
end
save('optimal_multivariate_localization_radii.mat', 'RMSE_Y_XnoY_MVBW', 'RMSE_X_XnoY_MVBW', '-append')

% 2C. Askey
fprintf('\nAskey\n')
loc_fun_name = 'askey' ; 
loc_params = struct('rYY', rYY, 'nu', 1, 'gammaYY', 0, 'gammaXX', 0, 'gammaXY', 0); 
for ii = 1:length(loc_rad)
    rXX = loc_rad(ii);
    rXY = min(rYY, rXX);
    loc_params.rXX = rXX;
    loc_params.rXY = rXY; 
    loc_params.beta = askey_beta_max(loc_params);
    [RMSE_Y, RMSE_X] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
    RMSE_Y_XnoY_MVA(ii) = mean(reshape(RMSE_Y(:, start:end), 1, []));
    RMSE_X_XnoY_MVA(ii) = mean(reshape(RMSE_X(:, start:end), 1, []));
end
save('optimal_multivariate_localization_radii.mat', 'RMSE_Y_XnoY_MVA', 'RMSE_X_XnoY_MVA', '-append')

% 2D. Wendland
fprintf('\nWendland\n')
loc_fun_name = 'wendland' ; 
loc_params = struct('rYY', rYY, 'nu', 2, 'gammaYY', 0, 'gammaXX', 0, 'gammaXY', 0, 'k', 1); 
for ii = 1:length(loc_rad)
    rXX = loc_rad(ii);
    rXY = min(rYY, rXX);
    loc_params.rXX = rXX;
    loc_params.rXY = rXY; 
    loc_params.beta = wendland_beta_max(loc_params);
    [RMSE_Y, RMSE_X] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
    RMSE_Y_XnoY_MVW(ii) = mean(reshape(RMSE_Y(:, start:end), 1, []));
    RMSE_X_XnoY_MVW(ii) = mean(reshape(RMSE_X(:, start:end), 1, []));
end
save('optimal_multivariate_localization_radii.mat', 'RMSE_Y_XnoY_MVW', 'RMSE_X_XnoY_MVW', '-append')



% 3. Both X and Y
fprintf('\nBoth X and Y.\n')
dtObs = 0.005;          % Time between assimilation cycles
Frac_Obs_Y = 0.75;      % Fraction of Y variables that are observed
Frac_Obs_X = 0.75;      % Fraction of X variables that are observed
sigma2Y = 0.01;         % Y obs error variance
sigma2X = 0.57;         % X obs error variance
rYY = 15;               % Localization radius for process Y

% Initialize arrays
RMSE_Y_BothXY_MVGC = zeros(1, length(loc_rad));
RMSE_X_BothXY_MVGC = zeros(1, length(loc_rad));
RMSE_Y_BothXY_MVBW = zeros(1, length(loc_rad));
RMSE_X_BothXY_MVBW = zeros(1, length(loc_rad));
RMSE_Y_BothXY_MVA = zeros(1, length(loc_rad));
RMSE_X_BothXY_MVA = zeros(1, length(loc_rad));
RMSE_Y_BothXY_MVW = zeros(1, length(loc_rad));
RMSE_X_BothXY_MVW = zeros(1, length(loc_rad));

% 3A. Gaspari-Cohn
fprintf('\nGaspari-Cohn\n')
loc_fun_name = 'gaspari_cohn' ; % localization function name
loc_params = struct('rYY', rYY); % localization parameters
for ii = 1:length(loc_rad)
    rXX = loc_rad(ii);
    loc_params.rXX = rXX;
    loc_params.beta = gaspari_cohn_beta_max(loc_params);
    [RMSE_Y, RMSE_X] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
    RMSE_Y_BothXY_MVGC(ii) = mean(reshape(RMSE_Y(:, start:end), 1, []));
    RMSE_X_BothXY_MVGC(ii) = mean(reshape(RMSE_X(:, start:end), 1, []));
end
save('optimal_multivariate_localization_radii.mat', 'RMSE_Y_BothXY_MVGC', 'RMSE_X_BothXY_MVGC', '-append')

% 3B. Bolin-Wallin
fprintf('\nBolin-Wallin\n')
loc_fun_name = 'bolin_wallin' ;
loc_params = struct('rYY', rYY); % localization parameters
for ii = 1:length(loc_rad)
    rXX = loc_rad(ii);
    loc_params.rXX = rXX;
    loc_params.beta = bolin_wallin_beta_max(loc_params);
    [RMSE_Y, RMSE_X] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
    RMSE_Y_BothXY_MVBW(ii) = mean(reshape(RMSE_Y(:, start:end), 1, []));
    RMSE_X_BothXY_MVBW(ii) = mean(reshape(RMSE_X(:, start:end), 1, []));
end
save('optimal_multivariate_localization_radii.mat', 'RMSE_Y_BothXY_MVBW', 'RMSE_X_BothXY_MVBW', '-append')

% 3C. Askey
fprintf('\nAskey\n')
loc_fun_name = 'askey' ; 
loc_params = struct('rYY', rYY, 'nu', 1, 'gammaYY', 0, 'gammaXX', 0, 'gammaXY', 0); 
for ii = 1:length(loc_rad)
    rXX = loc_rad(ii);
    rXY = min(rYY, rXX);
    loc_params.rXX = rXX;
    loc_params.rXY = rXY; 
    loc_params.beta = askey_beta_max(loc_params);
    [RMSE_Y, RMSE_X] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
    RMSE_Y_BothXY_MVA(ii) = mean(reshape(RMSE_Y(:, start:end), 1, []));
    RMSE_X_BothXY_MVA(ii) = mean(reshape(RMSE_X(:, start:end), 1, []));
end
save('optimal_multivariate_localization_radii.mat', 'RMSE_Y_BothXY_MVA', 'RMSE_X_BothXY_MVA', '-append')

% 3D. Wendland
fprintf('\nWendland\n')
loc_fun_name = 'wendland' ; 
loc_params = struct('rYY', rYY, 'nu', 2, 'gammaYY', 0, 'gammaXX', 0, 'gammaXY', 0, 'k', 1); 
for ii = 1:length(loc_rad)
    rXX = loc_rad(ii);
    rXY = min(rYY, rXX);
    loc_params.rXX = rXX;
    loc_params.rXY = rXY; 
    loc_params.beta = wendland_beta_max(loc_params);
    [RMSE_Y, RMSE_X] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
    RMSE_Y_BothXY_MVW(ii) = mean(reshape(RMSE_Y(:, start:end), 1, []));
    RMSE_X_BothXY_MVW(ii) = mean(reshape(RMSE_X(:, start:end), 1, []));
end
save('optimal_multivariate_localization_radii.mat', 'RMSE_Y_BothXY_MVW', 'RMSE_X_BothXY_MVW', '-append')



