%% Makes plots of RMSE vs. different multivariate localization radii
% Load output produced from script optimal_multivariate_localization_radii_save_output
%
% Author: Zofia Stanley

%% Load output produced from script optimal_multivariate_localization_radii_save_output
load('Data/optimal_multivariate_localization_radii.mat')

%% 1. Plot All Y, No X

RMSE_X_YnoX_MVMedian = median([RMSE_X_YnoX_MVGC; RMSE_X_YnoX_MVBW; RMSE_X_YnoX_MVA; RMSE_X_YnoX_MVW]); 
RMSE_Y_YnoX_MVMedian = median([RMSE_Y_YnoX_MVGC; RMSE_Y_YnoX_MVBW; RMSE_Y_YnoX_MVA; RMSE_Y_YnoX_MVW]); 

figure
subplot(2,1,1)
plot( loc_rad, RMSE_X_YnoX_MVGC, '-o', loc_rad, RMSE_X_YnoX_MVBW, '-o', ...
      loc_rad, RMSE_X_YnoX_MVA, '-o', loc_rad, RMSE_X_YnoX_MVW, '-o', 'LineWidth', 3)
hold on
plot(loc_rad, RMSE_X_YnoX_MVMedian, 'k--', 'LineWidth', 3)
hold off
ylabel('RMSE X')
xlabel('Localization radius')
title('Observe Y: Optimal multivariate localization radius for X')
legend('Gaspari-Cohn', 'Bolin-Wallin', 'Askey', 'Wendland', 'Median')
set(gca, 'FontSize', 18)

subplot(2,1,2)
plot( loc_rad, RMSE_Y_YnoX_MVGC, '-o', loc_rad, RMSE_Y_YnoX_MVBW, '-o', ...
      loc_rad, RMSE_Y_YnoX_MVA,'-o', loc_rad, RMSE_Y_YnoX_MVW, '-o', 'LineWidth', 3)
hold on
plot(loc_rad, RMSE_Y_YnoX_MVMedian, 'k--', 'LineWidth', 3)
hold off
ylabel('RMSE Y')
xlabel('Localization radius')
legend('Gaspari-Cohn', 'Bolin-Wallin', 'Askey', 'Wendland', 'Median')
set(gca, 'FontSize', 18)
set(gcf, 'Position',  [100, 100, 800, 800])

saveas(gcf, 'Plots/optimal_mv_loc_rad_YnoX.png')

%% 2. Plot All X, No Y

RMSE_X_XnoY_MVMean = mean([RMSE_X_XnoY_MVGC; RMSE_X_XnoY_MVBW; RMSE_X_XnoY_MVA; RMSE_X_XnoY_MVW]); 
RMSE_Y_XnoY_MVMean = mean([RMSE_Y_XnoY_MVGC; RMSE_Y_XnoY_MVBW; RMSE_Y_XnoY_MVA; RMSE_Y_XnoY_MVW]); 

figure
subplot(2,1,1)
plot( loc_rad, RMSE_X_XnoY_MVGC, '-o', loc_rad, RMSE_X_XnoY_MVBW, '-o', ...
      loc_rad, RMSE_X_XnoY_MVA, '-o', loc_rad, RMSE_X_XnoY_MVW, '-o', 'LineWidth', 3)
hold on
plot(loc_rad, RMSE_X_XnoY_MVMean, 'k--', 'LineWidth', 3)
hold off
ylabel('RMSE X')
xlabel('Localization radius')
title('Observe X: Optimal multivariate localization radius for X')
legend('Gaspari-Cohn', 'Bolin-Wallin', 'Askey', 'Wendland', 'Mean')
set(gca, 'FontSize', 18)

subplot(2,1,2)
plot( loc_rad, RMSE_Y_XnoY_MVGC, '-o', loc_rad, RMSE_Y_XnoY_MVBW, '-o', ...
      loc_rad, RMSE_Y_XnoY_MVA,'-o', loc_rad, RMSE_Y_XnoY_MVW, '-o', 'LineWidth', 3)
hold on
plot(loc_rad, RMSE_Y_XnoY_MVMean, 'k--', 'LineWidth', 3)
hold off
ylabel('RMSE Y')
xlabel('Localization radius')
legend('Gaspari-Cohn', 'Bolin-Wallin', 'Askey', 'Wendland', 'Mean')
set(gca, 'FontSize', 18)
set(gcf, 'Position',  [100, 100, 800, 800])

saveas(gcf, 'Plots/optimal_mv_loc_rad_XnoY.png')

%% 3. Plot Both X and Y

RMSE_X_BothXY_MVMean = mean([RMSE_X_BothXY_MVGC; RMSE_X_BothXY_MVBW; RMSE_X_BothXY_MVA; RMSE_X_BothXY_MVW]); 
RMSE_Y_BothXY_MVMean = mean([RMSE_Y_BothXY_MVGC; RMSE_Y_BothXY_MVBW; RMSE_Y_BothXY_MVA; RMSE_Y_BothXY_MVW]); 

figure
subplot(2,1,1)
plot( loc_rad, RMSE_X_BothXY_MVGC, '-o', loc_rad, RMSE_X_BothXY_MVBW, '-o', ...
      loc_rad, RMSE_X_BothXY_MVA, '-o', loc_rad, RMSE_X_BothXY_MVW, '-o', 'LineWidth', 3)
hold on
plot(loc_rad, RMSE_X_BothXY_MVMean, 'k--', 'LineWidth', 3)
hold off
ylabel('RMSE X')
xlabel('Localization radius')
title('Observe X and Y: Optimal multivariate localization radius for X')
legend('Gaspari-Cohn', 'Bolin-Wallin', 'Askey', 'Wendland', 'Mean')
set(gca, 'FontSize', 18)

subplot(2,1,2)
plot( loc_rad, RMSE_Y_BothXY_MVGC, '-o', loc_rad, RMSE_Y_BothXY_MVBW, '-o', ...
      loc_rad, RMSE_Y_BothXY_MVA,'-o', loc_rad, RMSE_Y_BothXY_MVW, '-o', 'LineWidth', 3)
hold on
plot(loc_rad, RMSE_Y_BothXY_MVMean, 'k--', 'LineWidth', 3)
hold off
ylabel('RMSE Y')
xlabel('Localization radius')
legend('Gaspari-Cohn', 'Bolin-Wallin', 'Askey', 'Wendland', 'Mean')
set(gca, 'FontSize', 18)
set(gcf, 'Position',  [100, 100, 800, 800])

saveas(gcf, 'Plots/optimal_mv_loc_rad_BothXY.png')




