%% Load output produced from script observe_x_and_y_save_output
load('observe_x_and_y.mat') 
addpath('violin/')
title_str = 'Observe X and Y: Primary';
savename = 'Plots/obs_x_and_y_primary_violins_crop.png';

% 1. RMSE X
RMSE_X_full = [sort(RMSE_X_BothXY_UVGC(:)), sort(RMSE_X_BothXY_WCGC(:)), sort(RMSE_X_BothXY_MVGC(:)),...
          sort(RMSE_X_BothXY_UVBW(:)), sort(RMSE_X_BothXY_WCBW(:)), sort(RMSE_X_BothXY_MVBW(:)) ...
          sort(RMSE_X_BothXY_UVA(:)),  ...
          sort(RMSE_X_BothXY_UVW(:))  ];
height = size(RMSE_X_full, 1);
RMSE_X = RMSE_X_full(floor(0.01*height):floor(0.99*height), :);
      
xlab = {'UV GC', 'WC GC', 'MV GC', 'UV BW', 'WC BW', 'MV BW', 'UV A', 'UV W'};

% 2. RMSE Y
RMSE_Y_full = [sort(RMSE_Y_BothXY_UVGC(:)), sort(RMSE_Y_BothXY_WCGC(:)), sort(RMSE_Y_BothXY_MVGC(:)), ...
               sort(RMSE_Y_BothXY_UVBW(:)), sort(RMSE_Y_BothXY_WCBW(:)), sort(RMSE_Y_BothXY_MVBW(:)), ...
               sort(RMSE_Y_BothXY_UVA(:)),  ...
               sort(RMSE_Y_BothXY_UVW(:))   ];
height = size(RMSE_Y_full, 1);
RMSE_Y = RMSE_Y_full(floor(0.01*height):floor(0.99*height), :);

% Make Plots

figure
subplot(2,1,1)
violin(RMSE_X);
ylabel('RMSE X')
title(title_str)
ylim([0,1.5])
set(gca, 'FontSize', 14, 'XTick', 1:length(xlab), 'XTickLabel', xlab)

subplot(2,1,2)
violin(RMSE_Y);
ylabel('RMSE Y')
ylim([0,0.35])
set(gca, 'FontSize', 14, 'XTick', 1:length(xlab), 'XTickLabel', xlab)
set(gcf, 'Position',  [100, 100, 800, 800])

saveas(gcf, savename)