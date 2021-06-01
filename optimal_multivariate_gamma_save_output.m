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
askey_nu = 1;           % nu for univariate Askey
wendland_nu = 2;        % nu for univariate Wendland
gamma_yy = [0,1,2];     % values of gamma_yy for Askey and Wendland
gamma_xx_a = [0,1,2,3]; % values of gamma_xx for Askey
gamma_xx_w = [0,1,2,3,4,5,6,7,8,9];     % values of gamm_xx for Wendland
start = 1001;           % first assimilation cycle considered in RMSE computations

%% Run Experiments

% 1. All Y, No X
fprintf('All Y, No X.\n')
dtObs = 0.005;         % Time between assimilation cycles
Frac_Obs_Y = 1;        % Fraction of Y variables that are observed
Frac_Obs_X = 0;        % Fraction of X variables that are observed
rYY = 15;
rXX = 45;
rXY = min(rYY, rXX);

% Initialize arrays
RMSE_Y_YnoX_MVA = zeros(length(gamma_yy), length(gamma_xx_a));
RMSE_X_YnoX_MVA = zeros(length(gamma_yy), length(gamma_xx_a));
RMSE_Y_YnoX_MVW = zeros(length(gamma_yy), length(gamma_xx_w));
RMSE_X_YnoX_MVW = zeros(length(gamma_yy), length(gamma_xx_w));

%{
% 1A. Askey
fprintf('\nAskey\n')
loc_fun_name = 'askey' ; 
loc_params = struct('rYY', rYY, 'rXX', rXX, 'rXY', rXY, 'nu', askey_nu); 
for ii = 1:length(gamma_yy)
    for jj = 1:length(gamma_xx_a)
        loc_params.gammaYY = gamma_yy(ii);
        loc_params.gammaXX = gamma_xx_a(jj);
        loc_params.gammaXY = askey_wendland_gamma_cross(loc_params); 
        loc_params.beta = askey_beta_max(loc_params);
        [RMSE_Y, RMSE_X] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
        RMSE_Y_YnoX_MVA(ii, jj) = mean(reshape(RMSE_Y(:, start:end), 1, []));
        RMSE_X_YnoX_MVA(ii, jj) = mean(reshape(RMSE_X(:, start:end), 1, []));
    end
end
save('optimal_multivariate_gamma.mat', 'gamma_yy', 'gamma_xx_a', 'RMSE_Y_YnoX_MVA', 'RMSE_X_YnoX_MVA')
%}

% 1B. Wendland
fprintf('\nWendland\n')
loc_fun_name = 'wendland' ; 
loc_params = struct('rYY', rYY, 'rXX', rXX, 'rXY', rXY, 'nu', wendland_nu, 'k', 1); 
for ii = 1:length(gamma_yy)
    for jj = 1:length(gamma_xx_w)
        loc_params.gammaYY = gamma_yy(ii);
        loc_params.gammaXX = gamma_xx_w(jj);
        loc_params.gammaXY = askey_wendland_gamma_cross(loc_params); 
        loc_params.beta = wendland_beta_max(loc_params);
        [RMSE_Y, RMSE_X] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
        RMSE_Y_YnoX_MVW(ii, jj) = mean(reshape(RMSE_Y(:, start:end), 1, []));
        RMSE_X_YnoX_MVW(ii, jj) = mean(reshape(RMSE_X(:, start:end), 1, []));
    end
end
save('optimal_multivariate_gamma.mat', 'gamma_xx_w', 'RMSE_Y_YnoX_MVW', 'RMSE_X_YnoX_MVW', '-append')


% 2. All X, No Y
fprintf('\nAll X, No Y.\n')
dtObs = 0.05;          % Time between assimilation cycles
Frac_Obs_Y = 0;        % Fraction of Y variables that are observed
Frac_Obs_X = 1;        % Fraction of X variables that are observed
rYY = 20;
rXX = 40;
rXY = min(rYY, rXX);

% Initialize arrays
RMSE_Y_XnoY_MVA = zeros(length(gamma_yy), length(gamma_xx_a));
RMSE_X_XnoY_MVA = zeros(length(gamma_yy), length(gamma_xx_a));
RMSE_Y_XnoY_MVW = zeros(length(gamma_yy), length(gamma_xx_w));
RMSE_X_XnoY_MVW = zeros(length(gamma_yy), length(gamma_xx_w));

% 2A. Askey
fprintf('\nAskey\n')
loc_fun_name = 'askey' ; 
loc_params = struct('rYY', rYY, 'rXX', rXX, 'rXY', rXY, 'nu', askey_nu); 
for ii = 1:length(gamma_yy)
    for jj = 1:length(gamma_xx_a)
        loc_params.gammaYY = gamma_yy(ii);
        loc_params.gammaXX = gamma_xx_a(jj);
        loc_params.gammaXY = askey_wendland_gamma_cross(loc_params); 
        loc_params.beta = askey_beta_max(loc_params);
        [RMSE_Y, RMSE_X] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
        RMSE_Y_XnoY_MVA(ii, jj) = mean(reshape(RMSE_Y(:, start:end), 1, []));
        RMSE_X_XnoY_MVA(ii, jj) = mean(reshape(RMSE_X(:, start:end), 1, []));
    end
end
save('optimal_multivariate_gamma.mat', 'RMSE_Y_XnoY_MVA', 'RMSE_X_XnoY_MVA', '-append')

% 2B. Wendland
fprintf('\nWendland\n')
loc_fun_name = 'wendland' ; 
loc_params = struct('rYY', rYY, 'rXX', rXX, 'rXY', rXY, 'nu', wendland_nu, 'k', 1); 
for ii = 1:length(gamma_yy)
    for jj = 1:length(gamma_xx_w)
        loc_params.gammaYY = gamma_yy(ii);
        loc_params.gammaXX = gamma_xx_w(jj);
        loc_params.gammaXY = askey_wendland_gamma_cross(loc_params); 
        loc_params.beta = wendland_beta_max(loc_params);
        [RMSE_Y, RMSE_X] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
        RMSE_Y_XnoY_MVW(ii, jj) = mean(reshape(RMSE_Y(:, start:end), 1, []));
        RMSE_X_XnoY_MVW(ii, jj) = mean(reshape(RMSE_X(:, start:end), 1, []));
    end
end
save('optimal_multivariate_gamma.mat', 'RMSE_Y_XnoY_MVW', 'RMSE_X_XnoY_MVW', '-append')
