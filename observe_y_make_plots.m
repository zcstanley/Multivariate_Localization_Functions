%% Load output produced from script observe_y_save_output
load('observe_y_20pctvar.mat') 
addpath('violin/')
title_str = 'Observe Y: 20% obs err variance';
savename = 'Plots/obs_y_20pctvar_violins.png';

% 1. RMSE X
RMSE_X_full = [sort(RMSE_X_YnoX_UVGC(:)), sort(RMSE_X_YnoX_MVGC(:)), ...
          sort(RMSE_X_YnoX_UVBW(:)), sort(RMSE_X_YnoX_MVBW(:)), ...
          sort(RMSE_X_YnoX_UVA(:)),  sort(RMSE_X_YnoX_MVA(:)), ...
          sort(RMSE_X_YnoX_UVW(:)),  sort(RMSE_X_YnoX_MVW(:))];
height = size(RMSE_X_full, 1);
RMSE_X = RMSE_X_full(floor(0.01*height):floor(0.99*height), :);
      
xlab = {'UV GC', 'MV GC', 'UV BW', 'MV BW', 'UV A', 'MV A', 'UV W', 'MV W'};

% 2. RMSE Y
RMSE_Y_full = [sort(RMSE_Y_YnoX_UVGC(:)), sort(RMSE_Y_YnoX_MVGC(:)), ...
          sort(RMSE_Y_YnoX_UVBW(:)), sort(RMSE_Y_YnoX_MVBW(:)), ...
          sort(RMSE_Y_YnoX_UVA(:)),  sort(RMSE_Y_YnoX_MVA(:)), ...
          sort(RMSE_Y_YnoX_UVW(:)),  sort(RMSE_Y_YnoX_MVW(:))];
height = size(RMSE_Y_full, 1);
RMSE_Y = RMSE_Y_full(floor(0.01*height):floor(0.99*height), :);

% Make Plots

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

