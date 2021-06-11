%% Produces violin plots for all 12 localization functions when both X and Y are observed
% Load output produced from script observe_x_and_y_save_output
%
% Author: Zofia Stanley

load('Data/observe_x_and_y.mat') 
title_str = 'Observe X and Y: $\beta=\beta_{\max}$';
savename = 'Plots/obs_x_and_y_primary_violins.png';

% Define things and add paths
addpath('violin/')
start = 1001;
xlab = {'UV GC', 'WC GC', 'MV GC', 'UV BW', 'WC BW', 'MV BW', 'UV A', 'WC A', 'MV A', 'UV W', 'WC W', 'MV W'};

% 1. RMSE X, remove NaNs
[RMSE_X_BothXY_UVGC, len_UVGC] = remove_nan(RMSE_X_BothXY_UVGC, start);
[RMSE_X_BothXY_WCGC, len_WCGC] = remove_nan(RMSE_X_BothXY_WCGC, start);
[RMSE_X_BothXY_MVGC, len_MVGC] = remove_nan(RMSE_X_BothXY_MVGC, start);
[RMSE_X_BothXY_UVBW, len_UVBW] = remove_nan(RMSE_X_BothXY_UVBW, start);
[RMSE_X_BothXY_WCBW, len_WCBW] = remove_nan(RMSE_X_BothXY_WCBW, start);
[RMSE_X_BothXY_MVBW, len_MVBW] = remove_nan(RMSE_X_BothXY_MVBW, start);
[RMSE_X_BothXY_UVA, len_UVA] = remove_nan(RMSE_X_BothXY_UVA, start);
[RMSE_X_BothXY_WCA, len_WCA] = remove_nan(RMSE_X_BothXY_WCA, start);
[RMSE_X_BothXY_MVA, len_MVA] = remove_nan(RMSE_X_BothXY_MVA, start);
[RMSE_X_BothXY_UVW, len_UVW] = remove_nan(RMSE_X_BothXY_UVW, start);
[RMSE_X_BothXY_WCW, len_WCW] = remove_nan(RMSE_X_BothXY_WCW, start);
[RMSE_X_BothXY_MVW, len_MVW] = remove_nan(RMSE_X_BothXY_MVW, start);

% Concatenate
len = max([len_UVGC, len_WCGC, len_MVGC, len_UVBW, len_WCBW, len_MVBW, ...
           len_UVA, len_WCA, len_MVA, len_UVW, len_WCW, len_MVW]);
RMSE_X = NaN(len, 12);
RMSE_X(1:len_UVGC, 1) = RMSE_X_BothXY_UVGC;
RMSE_X(1:len_WCGC, 2) = RMSE_X_BothXY_WCGC;
RMSE_X(1:len_MVGC, 3) = RMSE_X_BothXY_MVGC;
RMSE_X(1:len_UVBW, 4) = RMSE_X_BothXY_UVBW;
RMSE_X(1:len_WCBW, 5) = RMSE_X_BothXY_WCBW;
RMSE_X(1:len_MVBW, 6) = RMSE_X_BothXY_MVBW;
RMSE_X(1:len_UVA,  7) = RMSE_X_BothXY_UVA;
RMSE_X(1:len_WCA,  8) = RMSE_X_BothXY_WCA;
RMSE_X(1:len_MVA,  9) = RMSE_X_BothXY_MVA;
RMSE_X(1:len_UVW, 10) = RMSE_X_BothXY_UVW;
RMSE_X(1:len_WCW, 11) = RMSE_X_BothXY_WCW;
RMSE_X(1:len_MVW, 12) = RMSE_X_BothXY_MVW;

% 2. RMSE Y, remove NaNs
[RMSE_Y_BothXY_UVGC, len_UVGC] = remove_nan(RMSE_Y_BothXY_UVGC, start);
[RMSE_Y_BothXY_WCGC, len_WCGC] = remove_nan(RMSE_Y_BothXY_WCGC, start);
[RMSE_Y_BothXY_MVGC, len_MVGC] = remove_nan(RMSE_Y_BothXY_MVGC, start);
[RMSE_Y_BothXY_UVBW, len_UVBW] = remove_nan(RMSE_Y_BothXY_UVBW, start);
[RMSE_Y_BothXY_WCBW, len_WCBW] = remove_nan(RMSE_Y_BothXY_WCBW, start);
[RMSE_Y_BothXY_MVBW, len_MVBW] = remove_nan(RMSE_Y_BothXY_MVBW, start);
[RMSE_Y_BothXY_UVA, len_UVA] = remove_nan(RMSE_Y_BothXY_UVA, start);
[RMSE_Y_BothXY_WCA, len_WCA] = remove_nan(RMSE_Y_BothXY_WCA, start);
[RMSE_Y_BothXY_MVA, len_MVA] = remove_nan(RMSE_Y_BothXY_MVA, start);
[RMSE_Y_BothXY_UVW, len_UVW] = remove_nan(RMSE_Y_BothXY_UVW, start);
[RMSE_Y_BothXY_WCW, len_WCW] = remove_nan(RMSE_Y_BothXY_WCW, start);
[RMSE_Y_BothXY_MVW, len_MVW] = remove_nan(RMSE_Y_BothXY_MVW, start);

% Concatenate
len = max([len_UVGC, len_WCGC, len_MVGC, len_UVBW, len_WCBW, len_MVBW, ...
           len_UVA, len_WCA, len_MVA, len_UVW, len_WCW, len_MVW]);
RMSE_Y = NaN(len, 12);
RMSE_Y(1:len_UVGC, 1) = RMSE_Y_BothXY_UVGC;
RMSE_Y(1:len_WCGC, 2) = RMSE_Y_BothXY_WCGC;
RMSE_Y(1:len_MVGC, 3) = RMSE_Y_BothXY_MVGC;
RMSE_Y(1:len_UVBW, 4) = RMSE_Y_BothXY_UVBW;
RMSE_Y(1:len_WCBW, 5) = RMSE_Y_BothXY_WCBW;
RMSE_Y(1:len_MVBW, 6) = RMSE_Y_BothXY_MVBW;
RMSE_Y(1:len_UVA,  7) = RMSE_Y_BothXY_UVA;
RMSE_Y(1:len_WCA,  8) = RMSE_Y_BothXY_WCA;
RMSE_Y(1:len_MVA,  9) = RMSE_Y_BothXY_MVA;
RMSE_Y(1:len_UVW, 10) = RMSE_Y_BothXY_UVW;
RMSE_Y(1:len_WCW, 11) = RMSE_Y_BothXY_WCW;
RMSE_Y(1:len_MVW, 12) = RMSE_Y_BothXY_MVW;

%% Make Plots

these = 1:12;
figure
subplot(2,1,1)
violin(RMSE_X(:, these));
ylabel('RMSE X')
title(title_str, 'Interpreter', 'latex')
ylim([0,1.2])
set(gca, 'FontSize', 14, 'XTick', 1:length(xlab(these)), 'XTickLabel', xlab(these))

subplot(2,1,2)
violin(RMSE_Y(:, these));
ylabel('RMSE Y')
%ylim([0,0.35])
set(gca, 'FontSize', 14, 'XTick', 1:length(xlab(these)), 'XTickLabel', xlab(these))
set(gcf, 'Position',  [100, 100, 800, 800])

saveas(gcf, savename)