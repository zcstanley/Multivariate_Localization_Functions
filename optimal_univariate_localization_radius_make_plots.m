%% Produces Figure B2 in Stanley et al. (2021)
% Load output produced from script optimal_univariate_localization_radius_save_output
% 
% Author: Zofia Stanley

%% Load output produced from script optimal_univariate_localization_radius_save_output
load('Data/optimal_univariate_localization_radius.mat')

%% Colors
oxford_blue = [12, 27, 49, 0.85*256]./256;
maximum_green = [77, 139, 49, 0.9*256]./256;
rich_black = [8, 18, 33]./256;

%% Plot Y no X

RMSE_X_YnoX_UVMean = (1/4).* (RMSE_X_YnoX_UVGC + RMSE_X_YnoX_UVBW + RMSE_X_YnoX_UVA + RMSE_X_YnoX_UVW);
RMSE_Y_YnoX_UVMean = (1/4).* (RMSE_Y_YnoX_UVGC + RMSE_Y_YnoX_UVBW + RMSE_Y_YnoX_UVA + RMSE_Y_YnoX_UVW);

figure
subplot(2,1,1)
plot(loc_rad, RMSE_X_YnoX_UVGC,'-o', 'Color', oxford_blue, 'LineWidth', 5)
hold on
plot(loc_rad, RMSE_X_YnoX_UVBW, '--o', 'Color', oxford_blue, 'LineWidth', 5)
plot(loc_rad, RMSE_X_YnoX_UVA, ':o', 'Color', oxford_blue, 'LineWidth', 5) 
plot(loc_rad, RMSE_X_YnoX_UVW,'-.o', 'Color', oxford_blue, 'LineWidth', 5)
hold off
ylabel('RMSE X', 'Interpreter', 'latex')
xlabel('Localization radius', 'Interpreter', 'latex')
title('Optimal univariate localization radius', 'Interpreter', 'latex', 'Color', rich_black)
L=legend('Gaspari-Cohn', 'Bolin-Wallin', 'Askey', 'Wendland');
set(L, 'Interpreter', 'latex', 'box', 'off', 'TextColor', rich_black, 'Location', 'southeast')
L.ItemTokenSize = [59,18];
set(gca, 'FontSize', 18, 'TickLabelInterpreter','latex', 'Xcolor', rich_black,...
         'Ycolor', rich_black, 'box', 'off');

subplot(2,1,2)
plot(loc_rad, RMSE_Y_YnoX_UVGC, '-o', 'Color', oxford_blue, 'LineWidth', 5)
hold on
plot(loc_rad, RMSE_Y_YnoX_UVBW, '--o', 'Color', oxford_blue, 'LineWidth', 5)
plot(loc_rad, RMSE_Y_YnoX_UVA, ':o', 'Color', oxford_blue, 'LineWidth', 5) 
plot(loc_rad, RMSE_Y_YnoX_UVW,'-.o', 'Color', oxford_blue, 'LineWidth', 5)
hold off
ylabel('RMSE Y', 'Interpreter', 'latex')
xlabel('Localization radius', 'Interpreter', 'latex')
L=legend('Gaspari-Cohn', 'Bolin-Wallin', 'Askey', 'Wendland');
set(L, 'Interpreter', 'latex', 'box', 'off', 'TextColor', rich_black, 'Location', 'southeast')
L.ItemTokenSize = [59,18];
set(gca, 'FontSize', 18, 'TickLabelInterpreter','latex', 'Xcolor', rich_black,...
         'Ycolor', rich_black, 'box', 'off');
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



