%% Produces violin plots of RMSE from X only experiment
% Load output produced from script observe_x_save_output
%
% Author: Zofia Stanley

%% Load output produced from script observe_x_save_output
load('Data/observe_x.mat') 
addpath('violin/')
title_str = 'Observe X: Primary';
savename = 'Plots/obs_x_primary_violins.png';
start = 1001;

% 1. RMSE X
RMSE_X_XnoY_UVGC = RMSE_X_XnoY_UVGC(:, start:end);
RMSE_X_XnoY_WCGC = RMSE_X_XnoY_WCGC(:, start:end);
RMSE_X_XnoY_MVGC = RMSE_X_XnoY_MVGC(:, start:end);
RMSE_X_XnoY_UVBW = RMSE_X_XnoY_UVBW(:, start:end);
RMSE_X_XnoY_WCBW = RMSE_X_XnoY_WCBW(:, start:end);
RMSE_X_XnoY_MVBW = RMSE_X_XnoY_MVBW(:, start:end);
RMSE_X_XnoY_UVA = RMSE_X_XnoY_UVA(:, start:end);
RMSE_X_XnoY_WCA = RMSE_X_XnoY_WCA(:, start:end);
RMSE_X_XnoY_MVA = RMSE_X_XnoY_MVA(:, start:end);
RMSE_X_XnoY_UVW = RMSE_X_XnoY_UVW(:, start:end);
RMSE_X_XnoY_WCW = RMSE_X_XnoY_WCW(:, start:end);
RMSE_X_XnoY_MVW = RMSE_X_XnoY_MVW(:, start:end);

RMSE_X_full = [sort(RMSE_X_XnoY_UVGC(:)), sort(RMSE_X_XnoY_WCGC(:)), sort(RMSE_X_XnoY_MVGC(:)),...
          sort(RMSE_X_XnoY_UVBW(:)), sort(RMSE_X_XnoY_WCBW(:)), sort(RMSE_X_XnoY_MVBW(:)) ...
          sort(RMSE_X_XnoY_UVA(:)), sort(RMSE_X_XnoY_WCA(:)), sort(RMSE_X_XnoY_MVA(:))  ...
          sort(RMSE_X_XnoY_UVW(:)), sort(RMSE_X_XnoY_WCW(:)), sort(RMSE_X_XnoY_MVW(:))  ];
height = size(RMSE_X_full, 1);
RMSE_X = RMSE_X_full(floor(0.01*height):floor(0.99*height), :);
      
xlab = {'UV GC', 'WC GC', 'MV GC', 'UV BW', 'WC BW', 'MV BW', 'UV A', 'WC A', 'MV A', 'UV W', 'WC W', 'MV W'};

% 2. RMSE Y
RMSE_Y_XnoY_UVGC = RMSE_Y_XnoY_UVGC(:, start:end);
RMSE_Y_XnoY_WCGC = RMSE_Y_XnoY_WCGC(:, start:end);
RMSE_Y_XnoY_MVGC = RMSE_Y_XnoY_MVGC(:, start:end);
RMSE_Y_XnoY_UVBW = RMSE_Y_XnoY_UVBW(:, start:end);
RMSE_Y_XnoY_WCBW = RMSE_Y_XnoY_WCBW(:, start:end);
RMSE_Y_XnoY_MVBW = RMSE_Y_XnoY_MVBW(:, start:end);
RMSE_Y_XnoY_UVA = RMSE_Y_XnoY_UVA(:, start:end);
RMSE_Y_XnoY_WCA = RMSE_Y_XnoY_WCA(:, start:end);
RMSE_Y_XnoY_MVA = RMSE_Y_XnoY_MVA(:, start:end);
RMSE_Y_XnoY_UVW = RMSE_Y_XnoY_UVW(:, start:end);
RMSE_Y_XnoY_WCW = RMSE_Y_XnoY_WCW(:, start:end);
RMSE_Y_XnoY_MVW = RMSE_Y_XnoY_MVW(:, start:end);

RMSE_Y_full = [sort(RMSE_Y_XnoY_UVGC(:)), sort(RMSE_Y_XnoY_WCGC(:)), sort(RMSE_Y_XnoY_MVGC(:)), ...
          sort(RMSE_Y_XnoY_UVBW(:)), sort(RMSE_Y_XnoY_WCBW(:)), sort(RMSE_Y_XnoY_MVBW(:)), ...
          sort(RMSE_Y_XnoY_UVA(:)), sort(RMSE_Y_XnoY_WCA(:)), sort(RMSE_Y_XnoY_MVA(:)) ...
          sort(RMSE_Y_XnoY_UVW(:)), sort(RMSE_Y_XnoY_WCW(:)), sort(RMSE_Y_XnoY_MVW(:))   ];
height = size(RMSE_Y_full, 1);
RMSE_Y = RMSE_Y_full(floor(0.01*height):floor(0.99*height), :);

%% Make Plots

figure
subplot(2,1,1)
violin(RMSE_X);
ylabel('RMSE X')
title(title_str)
set(gca, 'FontSize', 14, 'XTick', 1:length(xlab), 'XTickLabel', xlab)

subplot(2,1,2)
violin(RMSE_Y);
ylabel('RMSE Y')
set(gca, 'FontSize', 14, 'XTick', 1:length(xlab), 'XTickLabel', xlab)
set(gcf, 'Position',  [100, 100, 800, 800])

saveas(gcf, savename)