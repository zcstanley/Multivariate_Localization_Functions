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

%% Run Experiments

% 1. All Y, No X
fprintf('All Y, No X.\n')
dtObs = 0.005;         % Time between assimilation cycles
Frac_Obs_Y = 1;        % Fraction of Y variables that are observed
Frac_Obs_X = 0;        % Fraction of X variables that are observed
rYY = 15;
rXX = 45;

% Beta max for each function
bmax_gc = gaspari_cohn_beta_max(struct('rYY', rYY, 'rXX', rXX));
b_gc = [0.1:0.1:bmax_gc, bmax_gc];
bmax_bw = bolin_wallin_beta_max(struct('rYY', rYY, 'rXX', rXX));
b_bw = [0.1:0.1:bmax_bw, bmax_bw];

% Initialize arrays
RMSE_Y_YnoX_MVGC = zeros(1, length(b_gc));
RMSE_X_YnoX_MVGC = zeros(1, length(b_gc));
RMSE_Y_YnoX_MVBW = zeros(1, length(b_bw));
RMSE_X_YnoX_MVBW = zeros(1, length(b_bw));

% 1A. Gaspari-Cohn
fprintf('\nGaspari-Cohn\n')
loc_fun_name = 'gaspari_cohn' ; % localization function name
loc_params = struct('rYY', rYY, 'rXX', rXX); % localization parameters
for ii = 1:length(b_gc)
    loc_params.beta = b_gc(ii);
    [RMSE_Y, RMSE_X] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
    RMSE_Y_YnoX_MVGC(ii) = mean(reshape(RMSE_Y(:, start:end), 1, []));
    RMSE_X_YnoX_MVGC(ii) = mean(reshape(RMSE_X(:, start:end), 1, []));
end
save('optimal_beta.mat', 'b_gc', 'RMSE_Y_YnoX_MVGC', 'RMSE_X_YnoX_MVGC')


% 1B. Bolin-Wallin
fprintf('\nBolin-Wallin\n')
loc_fun_name = 'bolin_wallin' ;
loc_params = struct('rYY', rYY, 'rXX', rXX); % localization parameters
for ii = 1:length(b_bw)
    loc_params.beta = b_bw(ii);
    [RMSE_Y, RMSE_X] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
    RMSE_Y_YnoX_MVBW(ii) = mean(reshape(RMSE_Y(:, start:end), 1, []));
    RMSE_X_YnoX_MVBW(ii) = mean(reshape(RMSE_X(:, start:end), 1, []));
end
save('optimal_beta.mat', 'b_bw', 'RMSE_Y_YnoX_MVBW', 'RMSE_X_YnoX_MVBW', '-append')


% 2. All X, No Y
fprintf('\nAll X, No Y.\n')
dtObs = 0.05;          % Time between assimilation cycles
Frac_Obs_Y = 0;        % Fraction of Y variables that are observed
Frac_Obs_X = 1;        % Fraction of X variables that are observed
rYY = 20;
rXX = 40;

% Beta max for each function
bmax_gc = gaspari_cohn_beta_max(struct('rYY', rYY, 'rXX', rXX));
b_gc = [0.1:0.1:bmax_gc, bmax_gc];
bmax_bw = bolin_wallin_beta_max(struct('rYY', rYY, 'rXX', rXX));
b_bw = [0.1:0.1:bmax_bw, bmax_bw];

% Initialize arrays
RMSE_Y_XnoY_MVGC = zeros(1, length(b_gc));
RMSE_X_XnoY_MVGC = zeros(1, length(b_gc));
RMSE_Y_XnoY_MVBW = zeros(1, length(b_bw));
RMSE_X_XnoY_MVBW = zeros(1, length(b_bw));

% 2A. Gaspari-Cohn
fprintf('\nGaspari-Cohn\n')
loc_fun_name = 'gaspari_cohn' ; % localization function name
loc_params = struct('rYY', rYY, 'rXX', rXX); % localization parameters
for ii = 1:length(b_gc)
    loc_params.beta = b_gc(ii);
    [RMSE_Y, RMSE_X] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
    RMSE_Y_XnoY_MVGC(ii) = mean(reshape(RMSE_Y(:, start:end), 1, []));
    RMSE_X_XnoY_MVGC(ii) = mean(reshape(RMSE_X(:, start:end), 1, []));
end
save('optimal_beta.mat', 'RMSE_Y_XnoY_MVGC', 'RMSE_X_XnoY_MVGC', '-append')


% 2B. Bolin-Wallin
fprintf('\nBolin-Wallin\n')
loc_fun_name = 'bolin_wallin' ;
loc_params = struct('rYY', rYY, 'rXX', rXX); % localization parameters
for ii = 1:length(b_bw)
    loc_params.beta = b_bw(ii);
    [RMSE_Y, RMSE_X] = L96_EnKF_Multitrial(params, Nt, dtObs, sigma2Y, sigma2X,... 
                                Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, ...
                                loc_fun_name, loc_params, True_Fcast_Err, Ntrial);
    RMSE_Y_XnoY_MVBW(ii) = mean(reshape(RMSE_Y(:, start:end), 1, []));
    RMSE_X_XnoY_MVBW(ii) = mean(reshape(RMSE_X(:, start:end), 1, []));
end
save('optimal_beta.mat', 'RMSE_Y_XnoY_MVBW', 'RMSE_X_XnoY_MVBW', '-append')
