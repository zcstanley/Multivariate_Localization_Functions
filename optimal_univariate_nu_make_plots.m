%% Produces plot of RMSE vs. univariate nu for Askey and Wendland
% Load output produced from script optimal_univariate_nu_save_output
%
% Author: Zofia Stanley

%% Load output produced from script optimal_univariate_nu_save_output
load('Data/optimal_univariate_nu.mat')

% 1. All Y, No X
figure
subplot(2,1,1)
plot( askey_nu, RMSE_X_YnoX_UVA, '-o', wendland_nu, RMSE_X_YnoX_UVW, '-o', 'LineWidth', 3)
ylabel('RMSE X')
xlabel('nu')
title('Observe Y: Optimal univariate nu')
legend('Askey', 'Wendland')
set(gca, 'FontSize', 18)

subplot(2,1,2)
plot( askey_nu, RMSE_Y_YnoX_UVA,'-o', wendland_nu, RMSE_Y_YnoX_UVW, '-o', 'LineWidth', 3)
ylabel('RMSE Y')
xlabel('nu')
legend('Askey', 'Wendland')
set(gca, 'FontSize', 18)
set(gcf, 'Position',  [100, 100, 800, 800])

saveas(gcf, 'Plots/optimal_nu_YnoX.png')


% 2. All X, No Y
figure
subplot(2,1,1)
plot( askey_nu, RMSE_X_XnoY_UVA, '-o', wendland_nu, RMSE_X_XnoY_UVW, '-o', 'LineWidth', 3)
ylabel('RMSE X')
xlabel('nu')
title('Observe X: Optimal univariate nu')
legend('Askey', 'Wendland')
set(gca, 'FontSize', 18)

subplot(2,1,2)
plot( askey_nu, RMSE_Y_XnoY_UVA,'-o', wendland_nu, RMSE_Y_XnoY_UVW, '-o', 'LineWidth', 3)
ylabel('RMSE Y')
xlabel('nu')
legend('Askey', 'Wendland')
set(gca, 'FontSize', 18)
set(gcf, 'Position',  [100, 100, 800, 800])

saveas(gcf, 'Plots/optimal_nu_XnoY.png')

% 3. Both X and Y
figure
subplot(2,1,1)
plot( askey_nu, RMSE_X_BothXY_UVA, '-o', wendland_nu, RMSE_X_BothXY_UVW, '-o', 'LineWidth', 3)
ylabel('RMSE X')
xlabel('nu')
title('Observe X and Y: Optimal univariate nu')
legend('Askey', 'Wendland')
set(gca, 'FontSize', 18)

subplot(2,1,2)
plot( askey_nu, RMSE_Y_BothXY_UVA,'-o', wendland_nu, RMSE_Y_BothXY_UVW, '-o', 'LineWidth', 3)
ylabel('RMSE Y')
xlabel('nu')
legend('Askey', 'Wendland')
set(gca, 'FontSize', 18)
set(gcf, 'Position',  [100, 100, 800, 800])

saveas(gcf, 'Plots/optimal_nu_BothXY.png')

