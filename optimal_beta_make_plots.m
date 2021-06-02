%% Load output produced from script optimal_beta_save_output
load('optimal_beta.mat') 

%% 1. Plot All Y, No X
rYY = 15;
rXX = 45;

% Beta max for each function
bmax_gc_YnoX = gaspari_cohn_beta_max(struct('rYY', rYY, 'rXX', rXX));
b_gc_YnoX = [0.1:0.1:bmax_gc_YnoX, bmax_gc_YnoX];
bmax_bw_YnoX = bolin_wallin_beta_max(struct('rYY', rYY, 'rXX', rXX));
b_bw_YnoX = [0.1:0.1:bmax_bw_YnoX, bmax_bw_YnoX];

% plot 
figure
subplot(2,1,1)
plot( b_gc_YnoX, RMSE_X_YnoX_MVGC, '-o', b_bw_YnoX, RMSE_X_YnoX_MVBW, '-o', 'LineWidth', 3)
ylabel('RMSE X')
xlabel('cross-localization weight factor')
title('Observe Y: Optimal cross-localization weight factor ')
legend('Gaspari-Cohn', 'Bolin-Wallin')
set(gca, 'FontSize', 18)

subplot(2,1,2)
plot( b_gc_YnoX, RMSE_Y_YnoX_MVGC, '-o', b_bw_YnoX, RMSE_Y_YnoX_MVBW, '-o', 'LineWidth', 3)
ylabel('RMSE Y')
xlabel('cross-localization weight factor')
legend('Gaspari-Cohn', 'Bolin-Wallin')
set(gca, 'FontSize', 18)
set(gcf, 'Position',  [100, 100, 800, 800])

saveas(gcf, 'Plots/optimal_beta_YnoX.png')

%% 2. Plot X no Y
rYY = 20;
rXX = 40;

% Beta max for each function
bmax_gc_XnoY = gaspari_cohn_beta_max(struct('rYY', rYY, 'rXX', rXX));
b_gc_XnoY = [0.1:0.1:bmax_gc_XnoY, bmax_gc_XnoY];
bmax_bw_XnoY = bolin_wallin_beta_max(struct('rYY', rYY, 'rXX', rXX));
b_bw_XnoY = [0.1:0.1:bmax_bw_XnoY, bmax_bw_XnoY];

% plot 
figure
subplot(2,1,1)
plot( b_gc_XnoY, RMSE_X_XnoY_MVGC, '-o', b_bw_XnoY, RMSE_X_XnoY_MVBW, '-o', 'LineWidth', 3)
ylabel('RMSE X')
xlabel('cross-localization weight factor')
title('Observe X: Optimal cross-localization weight factor')
legend('Gaspari-Cohn', 'Bolin-Wallin', 'location', 'southeast')
set(gca, 'FontSize', 18)

subplot(2,1,2)
plot( b_gc_XnoY, RMSE_Y_XnoY_MVGC, '-o', b_bw_XnoY, RMSE_Y_XnoY_MVBW, '-o', 'LineWidth', 3)
ylabel('RMSE Y')
xlabel('cross-localization weight factor')
legend('Gaspari-Cohn', 'Bolin-Wallin', 'location', 'southeast')
set(gca, 'FontSize', 18)
set(gcf, 'Position',  [100, 100, 800, 800])

