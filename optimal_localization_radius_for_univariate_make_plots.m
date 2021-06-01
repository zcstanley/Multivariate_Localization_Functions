%% Load output produced from script optimal_localization_radius_for_univariate_save_output
load('optimal_univariate_localization_radius.mat')

%% Plot Y no X

RMSE_X_YnoX_UVMean = (1/4).* (RMSE_X_YnoX_UVGC + RMSE_X_YnoX_UVBW + RMSE_X_YnoX_UVA + RMSE_X_YnoX_UVW);
RMSE_Y_YnoX_UVMean = (1/4).* (RMSE_Y_YnoX_UVGC + RMSE_Y_YnoX_UVBW + RMSE_Y_YnoX_UVA + RMSE_Y_YnoX_UVW);

figure
subplot(2,1,1)
plot( loc_rad, RMSE_X_YnoX_UVGC, '-o', loc_rad, RMSE_X_YnoX_UVBW, '-o', ...
      loc_rad, RMSE_X_YnoX_UVA, '-o', loc_rad, RMSE_X_YnoX_UVW, '-o', 'LineWidth', 3)
hold on
plot(loc_rad, RMSE_X_YnoX_UVMean, 'k--', 'LineWidth', 3)
hold off
ylabel('RMSE X')
xlabel('Localization radius')
title('Observe Y: Optimal univariate localization radius')
legend('Gaspari-Cohn', 'Bolin-Wallin', 'Askey', 'Wendland')
set(gca, 'FontSize', 18)

subplot(2,1,2)
plot( loc_rad, RMSE_Y_YnoX_UVGC, '-o', loc_rad, RMSE_Y_YnoX_UVBW, '-o', ...
      loc_rad, RMSE_Y_YnoX_UVA,'-o', loc_rad, RMSE_Y_YnoX_UVW, '-o', 'LineWidth', 3)
hold on
plot(loc_rad, RMSE_Y_YnoX_UVMean, 'k--', 'LineWidth', 3)
hold off
ylabel('RMSE Y')
xlabel('Localization radius')
legend('Gaspari-Cohn', 'Bolin-Wallin', 'Askey', 'Wendland', 'Mean')
set(gca, 'FontSize', 18)
set(gcf, 'Position',  [100, 100, 800, 800])

saveas(gcf, 'Plots/optimal_loc_rad_YnoX.png')

%% Plot X no Y


RMSE_X_XnoY_UVMean = (1/4).* (RMSE_X_XnoY_UVGC + RMSE_X_XnoY_UVBW + RMSE_X_XnoY_UVA + RMSE_X_XnoY_UVW);
RMSE_Y_XnoY_UVMean = (1/4).* (RMSE_Y_XnoY_UVGC + RMSE_Y_XnoY_UVBW + RMSE_Y_XnoY_UVA + RMSE_Y_XnoY_UVW);

figure
subplot(2,1,1)
plot( loc_rad, RMSE_X_XnoY_UVGC, '-o', loc_rad, RMSE_X_XnoY_UVBW, '-o', ...
      loc_rad, RMSE_X_XnoY_UVA, '-o', loc_rad, RMSE_X_XnoY_UVW, '-o', 'LineWidth', 3)
hold on
plot(loc_rad, RMSE_X_XnoY_UVMean, 'k--', 'LineWidth', 3)
hold off
ylabel('RMSE X')
xlabel('Localization radius')
title('Observe X: Optimal univariate localization radius')
legend('Gaspari-Cohn', 'Bolin-Wallin', 'Askey', 'Wendland', 'Mean')
set(gca, 'FontSize', 18)

subplot(2,1,2)
plot( loc_rad, RMSE_Y_XnoY_UVGC, '-o', loc_rad, RMSE_Y_XnoY_UVBW, '-o', ...
      loc_rad, RMSE_Y_XnoY_UVA,'-o', loc_rad, RMSE_Y_XnoY_UVW, '-o', 'LineWidth', 3)
hold on
plot(loc_rad, RMSE_Y_XnoY_UVMean, 'k--', 'LineWidth', 3)
hold off
ylabel('RMSE Y')
xlabel('Localization radius')
legend('Gaspari-Cohn', 'Bolin-Wallin', 'Askey', 'Wendland', 'Mean')
set(gca, 'FontSize', 18)
set(gcf, 'Position',  [100, 100, 800, 800])

saveas(gcf, 'Plots/optimal_loc_rad_XnoY.png')

%% Plot Both X and Y

RMSE_Y_BothXY_UVGC([2,5,6]) = NaN; 
RMSE_X_BothXY_UVGC([2,5,6]) = NaN;
RMSE_Y_BothXY_UVBW(2) = NaN;
RMSE_X_BothXY_UVBW(2) = NaN; 
RMSE_Y_BothXY_UVA([1,2]) = NaN;
RMSE_X_BothXY_UVA([1,2]) = NaN;
RMSE_Y_BothXY_UVW(6) = NaN;
RMSE_X_BothXY_UVW(6) = NaN;

RMSE_X_BothXY_UVMean = nanmean([RMSE_X_BothXY_UVGC; RMSE_X_BothXY_UVBW; RMSE_X_BothXY_UVA; RMSE_X_BothXY_UVW]);
RMSE_Y_BothXY_UVMean = nanmean([RMSE_Y_BothXY_UVGC; RMSE_Y_BothXY_UVBW; RMSE_Y_BothXY_UVA; RMSE_Y_BothXY_UVW]);

figure
subplot(2,1,1)
plot( loc_rad, RMSE_X_BothXY_UVGC, '-o', loc_rad, RMSE_X_BothXY_UVBW, '-o', ...
      loc_rad, RMSE_X_BothXY_UVA, '-o', loc_rad, RMSE_X_BothXY_UVW, '-o', 'LineWidth', 3)
hold on
plot(loc_rad, RMSE_X_BothXY_UVMean, 'k--', 'LineWidth', 3)
hold off
ylabel('RMSE X')
xlabel('Localization radius')
title('Observe X and Y: Optimal univariate localization radius')
legend('Gaspari-Cohn', 'Bolin-Wallin', 'Askey', 'Wendland', 'Mean', 'location', 'southeast')
set(gca, 'FontSize', 18)

subplot(2,1,2)
plot( loc_rad, RMSE_Y_BothXY_UVGC, '-o', loc_rad, RMSE_Y_BothXY_UVBW, '-o', ...
      loc_rad, RMSE_Y_BothXY_UVA,'-o', loc_rad, RMSE_Y_BothXY_UVW, '-o', 'LineWidth', 3)
hold on
plot(loc_rad, RMSE_Y_BothXY_UVMean, 'k--', 'LineWidth', 3)
hold off
ylabel('RMSE Y')
xlabel('Localization radius')
legend('Gaspari-Cohn', 'Bolin-Wallin', 'Askey', 'Wendland', 'Mean', 'location', 'southeast')
set(gca, 'FontSize', 18)
set(gcf, 'Position',  [100, 100, 800, 800])

saveas(gcf, 'Plots/optimal_loc_rad_BothXY.png')



