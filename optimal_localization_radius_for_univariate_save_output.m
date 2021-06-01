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
loc_rad = [5, 10, 15, 20, 30, 45]; % localization radii

%% Run Experiments

%{
% 1. All Y, No X
fprintf('All Y, No X.\n')
dtObs = 0.005;         % Time between assimilation cycles
Frac_Obs_Y = 1;        % Fraction of Y variables that are observed
Frac_Obs_X = 0;        % Fraction of X variables that are observed

% Initialize arrays
RMSE_Y_YnoX_UVGC = zeros(1, length(loc_rad));
RMSE_X_YnoX_UVGC = zeros(1, length(loc_rad));
RMSE_Y_YnoX_UVBW = zeros(1, length(loc_rad));
RMSE_X_YnoX_UVBW = zeros(1, length(loc_rad));
RMSE_Y_YnoX_UVA = zeros(1, length(loc_rad));
RMSE_X_YnoX_UVA = zeros(1, length(loc_rad));
RMSE_Y_YnoX_UVW = zeros(1, length(loc_rad));
RMSE_X_YnoX_UVW = zeros(1, length(loc_rad));

% 1A. Gaspari-Cohn
fprintf('\nGaspari-Cohn\n')
loc_fun_name = 'gaspari_cohn' ; % localization function name
for ii = 1:length(loc_rad)
    R = loc_rad(ii);
    loc_params = struct('rYY', R, 'rXX', R, 'beta', 1); % localization parameters
    [RMSE_Y, RMSE_X] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
    RMSE_Y_YnoX_UVGC(ii) = mean(reshape(RMSE_Y(:, 1001:end), 1, []));
    RMSE_X_YnoX_UVGC(ii) = mean(reshape(RMSE_X(:, 1001:end), 1, []));
end
save('optimal_univariate_localization_radius.mat', 'loc_rad', 'RMSE_Y_YnoX_UVGC', 'RMSE_X_YnoX_UVGC')


% 1B. Bolin-Wallin
fprintf('\nBolin-Wallin\n')
loc_fun_name = 'bolin_wallin' ;
for ii = 1:length(loc_rad)
    R = loc_rad(ii);
    loc_params = struct('rYY', R, 'rXX', R, 'beta', 1); 
    [RMSE_Y, RMSE_X] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
    RMSE_Y_YnoX_UVBW(ii) = mean(reshape(RMSE_Y(:, 1001:end), 1, []));
    RMSE_X_YnoX_UVBW(ii) = mean(reshape(RMSE_X(:, 1001:end), 1, []));
end
save('optimal_univariate_localization_radius.mat', 'RMSE_Y_YnoX_UVBW', 'RMSE_X_YnoX_UVBW', '-append')

% 1C. Askey
fprintf('\nAskey\n')
loc_fun_name = 'askey' ; 
for ii = 1:length(loc_rad)
    R = loc_rad(ii);
    loc_params = struct('rYY', R, 'rXX', R, 'rXY', R, 'nu', 1, 'gammaYY', 0, 'gammaXX', 0, 'gammaXY', 0,'beta', 1); 
    [RMSE_Y, RMSE_X] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
    RMSE_Y_YnoX_UVA(ii) = mean(reshape(RMSE_Y(:, 1001:end), 1, []));
    RMSE_X_YnoX_UVA(ii) = mean(reshape(RMSE_X(:, 1001:end), 1, []));
end
save('optimal_univariate_localization_radius.mat', 'RMSE_Y_YnoX_UVA', 'RMSE_X_YnoX_UVA', '-append')

% 1D. Wendland
fprintf('\nWendland\n')
loc_fun_name = 'wendland' ; 
for ii = 1:length(loc_rad)
    R = loc_rad(ii);
    loc_params = struct('rYY', R, 'rXX', R, 'rXY', R, 'nu', 2, 'gammaYY', 0, 'gammaXX', 0, 'gammaXY', 0, 'k', 1, 'beta', 1); 
    [RMSE_Y, RMSE_X] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
    RMSE_Y_YnoX_UVW(ii) = mean(reshape(RMSE_Y(:, 1001:end), 1, []));
    RMSE_X_YnoX_UVW(ii) = mean(reshape(RMSE_X(:, 1001:end), 1, []));
end
save('optimal_univariate_localization_radius.mat', 'RMSE_Y_YnoX_UVW', 'RMSE_X_YnoX_UVW', '-append')

% 2. All X, No Y
fprintf('\nAll X, No Y.\n')
dtObs = 0.05;          % Time between assimilation cycles
Frac_Obs_Y = 0;        % Fraction of Y variables that are observed
Frac_Obs_X = 1;        % Fraction of X variables that are observed

% Initialize arrays
RMSE_Y_XnoY_UVGC = zeros(1, length(loc_rad));
RMSE_X_XnoY_UVGC = zeros(1, length(loc_rad));
RMSE_Y_XnoY_UVBW = zeros(1, length(loc_rad));
RMSE_X_XnoY_UVBW = zeros(1, length(loc_rad));
RMSE_Y_XnoY_UVA = zeros(1, length(loc_rad));
RMSE_X_XnoY_UVA = zeros(1, length(loc_rad));
RMSE_Y_XnoY_UVW = zeros(1, length(loc_rad));
RMSE_X_XnoY_UVW = zeros(1, length(loc_rad));

% 2A. Gaspari-Cohn
fprintf('\nGaspari-Cohn\n')
loc_fun_name = 'gaspari_cohn' ; % localization function name
for ii = 1:length(loc_rad)
    R = loc_rad(ii);
    loc_params = struct('rYY', R, 'rXX', R, 'beta', 1); % localization parameters
    [RMSE_Y, RMSE_X] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
    RMSE_Y_XnoY_UVGC(ii) = mean(reshape(RMSE_Y(:, 1001:end), 1, []));
    RMSE_X_XnoY_UVGC(ii) = mean(reshape(RMSE_X(:, 1001:end), 1, []));
end
save('optimal_univariate_localization_radius.mat', 'RMSE_Y_XnoY_UVGC', 'RMSE_X_XnoY_UVGC', '-append')


% 2B. Bolin-Wallin
fprintf('\nBolin-Wallin\n')
loc_fun_name = 'bolin_wallin' ;
for ii = 1:length(loc_rad)
    R = loc_rad(ii);
    loc_params = struct('rYY', R, 'rXX', R, 'beta', 1); 
    [RMSE_Y, RMSE_X] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
    RMSE_Y_XnoY_UVBW(ii) = mean(reshape(RMSE_Y(:, 1001:end), 1, []));
    RMSE_X_XnoY_UVBW(ii) = mean(reshape(RMSE_X(:, 1001:end), 1, []));
end
save('optimal_univariate_localization_radius.mat', 'RMSE_Y_XnoY_UVBW', 'RMSE_X_XnoY_UVBW', '-append')

% 2C. Askey
fprintf('\nAskey\n')
loc_fun_name = 'askey' ; 
for ii = 1:length(loc_rad)
    R = loc_rad(ii);
    loc_params = struct('rYY', R, 'rXX', R, 'rXY', R, 'nu', 1, 'gammaYY', 0, 'gammaXX', 0, 'gammaXY', 0,'beta', 1); 
    [RMSE_Y, RMSE_X] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
    RMSE_Y_XnoY_UVA(ii) = mean(reshape(RMSE_Y(:, 1001:end), 1, []));
    RMSE_X_XnoY_UVA(ii) = mean(reshape(RMSE_X(:, 1001:end), 1, []));
end
save('optimal_univariate_localization_radius.mat', 'RMSE_Y_XnoY_UVA', 'RMSE_X_XnoY_UVA', '-append')

% 2D. Wendland
fprintf('\nWendland\n')
loc_fun_name = 'wendland' ; 
for ii = 1:length(loc_rad)
    R = loc_rad(ii);
    loc_params = struct('rYY', R, 'rXX', R, 'rXY', R, 'nu', 2, 'gammaYY', 0, 'gammaXX', 0, 'gammaXY', 0, 'k', 1, 'beta', 1); 
    [RMSE_Y, RMSE_X] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
    RMSE_Y_XnoY_UVW(ii) = mean(reshape(RMSE_Y(:, 1001:end), 1, []));
    RMSE_X_XnoY_UVW(ii) = mean(reshape(RMSE_X(:, 1001:end), 1, []));
end
save('optimal_univariate_localization_radius.mat', 'RMSE_Y_XnoY_UVW', 'RMSE_X_XnoY_UVW', '-append')
%}

% 3. Both X and Y
fprintf('\nBoth X and Y.\n')
dtObs = 0.005;          % Time between assimilation cycles
Frac_Obs_Y = 0.75;      % Fraction of Y variables that are observed
Frac_Obs_X = 0.75;      % Fraction of X variables that are observed
sigma2Y = 0.01;         % Y obs error variance
sigma2X = 0.57;         % X obs error variance

% Initialize arrays
RMSE_Y_BothXY_UVGC = zeros(1, length(loc_rad));
RMSE_X_BothXY_UVGC = zeros(1, length(loc_rad));
RMSE_Y_BothXY_UVBW = zeros(1, length(loc_rad));
RMSE_X_BothXY_UVBW = zeros(1, length(loc_rad));
RMSE_Y_BothXY_UVA = zeros(1, length(loc_rad));
RMSE_X_BothXY_UVA = zeros(1, length(loc_rad));
RMSE_Y_BothXY_UVW = zeros(1, length(loc_rad));
RMSE_X_BothXY_UVW = zeros(1, length(loc_rad));

% 3A. Gaspari-Cohn
fprintf('\nGaspari-Cohn\n')
loc_fun_name = 'gaspari_cohn' ; % localization function name
for ii = 1:length(loc_rad)
    R = loc_rad(ii);
    loc_params = struct('rYY', R, 'rXX', R, 'beta', 1); % localization parameters
    [RMSE_Y, RMSE_X] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
    RMSE_Y_BothXY_UVGC(ii) = mean(reshape(RMSE_Y(:, 1001:end), 1, []));
    RMSE_X_BothXY_UVGC(ii) = mean(reshape(RMSE_X(:, 1001:end), 1, []));
end
save('optimal_univariate_localization_radius.mat', 'RMSE_Y_BothXY_UVGC', 'RMSE_X_BothXY_UVGC', '-append')

% 3B. Bolin-Wallin
fprintf('\nBolin-Wallin\n')
loc_fun_name = 'bolin_wallin' ;
for ii = 1:length(loc_rad)
    R = loc_rad(ii);
    loc_params = struct('rYY', R, 'rXX', R, 'beta', 1); 
    [RMSE_Y, RMSE_X] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
    RMSE_Y_BothXY_UVBW(ii) = mean(reshape(RMSE_Y(:, 1001:end), 1, []));
    RMSE_X_BothXY_UVBW(ii) = mean(reshape(RMSE_X(:, 1001:end), 1, []));
end
save('optimal_univariate_localization_radius.mat', 'RMSE_Y_BothXY_UVBW', 'RMSE_X_BothXY_UVBW', '-append')

% 3C. Askey
fprintf('\nAskey\n')
loc_fun_name = 'askey' ; 
for ii = 1:length(loc_rad)
    R = loc_rad(ii);
    loc_params = struct('rYY', R, 'rXX', R, 'rXY', R, 'nu', 1, 'gammaYY', 0, 'gammaXX', 0, 'gammaXY', 0,'beta', 1); 
    [RMSE_Y, RMSE_X] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
    RMSE_Y_BothXY_UVA(ii) = mean(reshape(RMSE_Y(:, 1001:end), 1, []));
    RMSE_X_BothXY_UVA(ii) = mean(reshape(RMSE_X(:, 1001:end), 1, []));
end
save('optimal_univariate_localization_radius.mat', 'RMSE_Y_BothXY_UVA', 'RMSE_X_BothXY_UVA', '-append')

% 3D. Wendland
fprintf('\nWendland\n')
loc_fun_name = 'wendland' ; 
for ii = 1:length(loc_rad)
    R = loc_rad(ii);
    loc_params = struct('rYY', R, 'rXX', R, 'rXY', R, 'nu', 2, 'gammaYY', 0, 'gammaXX', 0, 'gammaXY', 0, 'k', 1, 'beta', 1); 
    [RMSE_Y, RMSE_X] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
    RMSE_Y_BothXY_UVW(ii) = mean(reshape(RMSE_Y(:, 1001:end), 1, []));
    RMSE_X_BothXY_UVW(ii) = mean(reshape(RMSE_X(:, 1001:end), 1, []));
end
save('optimal_univariate_localization_radius.mat', 'RMSE_Y_BothXY_UVW', 'RMSE_X_BothXY_UVW', '-append')
