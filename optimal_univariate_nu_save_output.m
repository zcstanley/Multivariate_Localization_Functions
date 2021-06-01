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
askey_nu = [1, 1.5, 2, 2.5];    % nu for univariate Askey
wendland_nu = askey_nu+1;       % nu for univariate Wendland
start = 1001;           % first assimilation cycle considered in RMSE computations

%% Run Experiments

% 1. All Y, No X
fprintf('All Y, No X.\n')
dtObs = 0.005;         % Time between assimilation cycles
Frac_Obs_Y = 1;        % Fraction of Y variables that are observed
Frac_Obs_X = 0;        % Fraction of X variables that are observed
R = 15;                % Univariate localization radius

% Initialize arrays
RMSE_Y_YnoX_UVA = zeros(1, length(askey_nu));
RMSE_X_YnoX_UVA = zeros(1, length(askey_nu));
RMSE_Y_YnoX_UVW = zeros(1, length(wendland_nu));
RMSE_X_YnoX_UVW = zeros(1, length(wendland_nu));

% 1A. Askey
fprintf('\nAskey\n')
loc_fun_name = 'askey' ; 
loc_params = struct('rYY', R, 'rXX', R, 'rXY', R, 'gammaYY', 0, 'gammaXX', 0, 'gammaXY', 0, 'beta', 1); 
for ii = 1:length(askey_nu)
    nu = askey_nu(ii);
    loc_params.nu = nu;
    [RMSE_Y, RMSE_X] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
    RMSE_Y_YnoX_UVA(ii) = mean(reshape(RMSE_Y(:, start:end), 1, []));
    RMSE_X_YnoX_UVA(ii) = mean(reshape(RMSE_X(:, start:end), 1, []));
end
save('optimal_univariate_nu.mat', 'RMSE_Y_YnoX_UVA', 'RMSE_X_YnoX_UVA')

% 1B. Wendland
fprintf('\nWendland\n')
loc_fun_name = 'wendland' ; 
loc_params = struct('rYY', R, 'rXX', R, 'rXY', R, 'gammaYY', 0, 'gammaXX', 0, 'gammaXY', 0, 'k', 1, 'beta', 1); 
for ii = 1:length(wendland_nu)
    nu = wendland_nu(ii);
    loc_params.nu = nu;
    [RMSE_Y, RMSE_X] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
    RMSE_Y_YnoX_UVW(ii) = mean(reshape(RMSE_Y(:, start:end), 1, []));
    RMSE_X_YnoX_UVW(ii) = mean(reshape(RMSE_X(:, start:end), 1, []));
end
save('optimal_univariate_nu.mat', 'RMSE_Y_YnoX_UVW', 'RMSE_X_YnoX_UVW', '-append')

% 2. All X, No Y
fprintf('\nAll X, No Y.\n')
dtObs = 0.05;          % Time between assimilation cycles
Frac_Obs_Y = 0;        % Fraction of Y variables that are observed
Frac_Obs_X = 1;        % Fraction of X variables that are observed
R = 20;                % Univariate localization radius

% Initialize arrays
RMSE_Y_XnoY_UVA = zeros(1, length(askey_nu));
RMSE_X_XnoY_UVA = zeros(1, length(askey_nu));
RMSE_Y_XnoY_UVW = zeros(1, length(wendland_nu));
RMSE_X_XnoY_UVW = zeros(1, length(wendland_nu));


% 2A. Askey
fprintf('\nAskey\n')
loc_fun_name = 'askey' ; 
loc_params = struct('rYY', R, 'rXX', R, 'rXY', R, 'gammaYY', 0, 'gammaXX', 0, 'gammaXY', 0, 'beta', 1); 
for ii = 1:length(askey_nu)
    nu = askey_nu(ii);
    loc_params.nu = nu;
    [RMSE_Y, RMSE_X] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
    RMSE_Y_XnoY_UVA(ii) = mean(reshape(RMSE_Y(:, start:end), 1, []));
    RMSE_X_XnoY_UVA(ii) = mean(reshape(RMSE_X(:, start:end), 1, []));
end
save('optimal_univariate_nu.mat', 'RMSE_Y_XnoY_UVA', 'RMSE_X_XnoY_UVA', '-append')

% 2B. Wendland
fprintf('\nWendland\n')
loc_fun_name = 'wendland' ; 
loc_params = struct('rYY', R, 'rXX', R, 'rXY', R, 'gammaYY', 0, 'gammaXX', 0, 'gammaXY', 0, 'k', 1, 'beta', 1); 
for ii = 1:length(wendland_nu)
    nu = wendland_nu(ii);
    loc_params.nu = nu;
    [RMSE_Y, RMSE_X] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
    RMSE_Y_XnoY_UVW(ii) = mean(reshape(RMSE_Y(:, start:end), 1, []));
    RMSE_X_XnoY_UVW(ii) = mean(reshape(RMSE_X(:, start:end), 1, []));
end
save('optimal_univariate_nu.mat', 'RMSE_Y_XnoY_UVW', 'RMSE_X_XnoY_UVW', '-append')


% 3. Both X and Y
fprintf('\nBoth X and Y.\n')
dtObs = 0.005;          % Time between assimilation cycles
Frac_Obs_Y = 0.75;      % Fraction of Y variables that are observed
Frac_Obs_X = 0.75;      % Fraction of X variables that are observed
sigma2Y = 0.01;         % Y obs error variance
sigma2X = 0.57;         % X obs error variance
R = 15;                 % Univariate localization radius

% Initialize arrays
RMSE_Y_BothXY_UVA = zeros(1, length(askey_nu));
RMSE_X_BothXY_UVA = zeros(1, length(askey_nu));
RMSE_Y_BothXY_UVW = zeros(1, length(wendland_nu));
RMSE_X_BothXY_UVW = zeros(1, length(wendland_nu));

% 3A. Askey
fprintf('\nAskey\n')
loc_fun_name = 'askey' ; 
loc_params = struct('rYY', R, 'rXX', R, 'rXY', R, 'gammaYY', 0, 'gammaXX', 0, 'gammaXY', 0, 'beta', 1); 
for ii = 1:length(askey_nu)
    nu = askey_nu(ii);
    loc_params.nu = nu;
    [RMSE_Y, RMSE_X] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
    RMSE_Y_BothXY_UVA(ii) = mean(reshape(RMSE_Y(:, start:end), 1, []));
    RMSE_X_BothXY_UVA(ii) = mean(reshape(RMSE_X(:, start:end), 1, []));
end
save('optimal_univariate_nu.mat', 'RMSE_Y_BothXY_UVA', 'RMSE_X_BothXY_UVA', '-append')

% 3B. Wendland
fprintf('\nWendland\n')
loc_fun_name = 'wendland' ; 
loc_params = struct('rYY', R, 'rXX', R, 'rXY', R, 'gammaYY', 0, 'gammaXX', 0, 'gammaXY', 0, 'k', 1, 'beta', 1); 
for ii = 1:length(wendland_nu)
    nu = wendland_nu(ii);
    loc_params.nu = nu;
    [RMSE_Y, RMSE_X] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
    RMSE_Y_BothXY_UVW(ii) = mean(reshape(RMSE_Y(:, start:end), 1, []));
    RMSE_X_BothXY_UVW(ii) = mean(reshape(RMSE_X(:, start:end), 1, []));
end
save('optimal_univariate_nu.mat', 'RMSE_Y_BothXY_UVW', 'RMSE_X_BothXY_UVW', '-append')


