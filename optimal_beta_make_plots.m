%% Produces right panel of figure B3 in Stanley et al. (2021)
% Load output produced from script optimal_beta_save_output
%
% Author: Zofia Stanley

%% Load output produced from script optimal_beta_save_output
load('Data/optimal_beta.mat') 

%% Define colors
oxford_blue = [12, 27, 49, 0.85*256]./256;
maximum_green = [77, 139, 49, 0.9*256]./256;
rich_black = [8, 18, 33]./256;
color_gc = maximum_green;
color_bw = oxford_blue; 
color_a = oxford_blue;
color_w = oxford_blue;

%% 1. Plot All Y, No X
 
figure
subplot(2,1,1)
plot(b_gc_YnoX, RMSE_X_YnoX_MVGC, '-o', 'Color', color_gc, 'LineWidth', 5)
hold on
plot(b_bw_YnoX, RMSE_X_YnoX_MVBW, '--o', 'Color', color_bw, 'LineWidth', 5)
plot( b_a_YnoX, RMSE_X_YnoX_MVA, ':o', 'Color', color_a, 'LineWidth', 5) 
plot( b_w_YnoX, RMSE_X_YnoX_MVW,'-.o', 'Color', color_w, 'LineWidth', 5)
hold off
L=legend('Gaspari-Cohn', 'Bolin-Wallin', 'Askey', 'Wendland');
set(L, 'Interpreter', 'latex', 'box', 'off', 'TextColor', rich_black)
L.ItemTokenSize = [59,18];
set(gca, 'FontSize', 24, 'LineWidth', 2)
set(gca,'TickLabelInterpreter','latex', 'Xcolor', rich_black,...
         'Ycolor', rich_black, 'box', 'off');
ylabel('RMSE X', 'Interpreter', 'latex', 'Color', rich_black)
xlabel('Cross-localization weight factor, $\beta$', 'Interpreter', 'latex')
ylim([0.022 0.114])
title('Optimal cross-localization weight factor', 'Interpreter', 'latex')

subplot(2,1,2)
plot(b_gc_YnoX, RMSE_Y_YnoX_MVGC, '-o', 'Color', color_gc, 'LineWidth', 5)
hold on
plot(b_bw_YnoX, RMSE_Y_YnoX_MVBW, '--o', 'Color', color_bw, 'LineWidth', 5)
plot( b_a_YnoX, RMSE_Y_YnoX_MVA, ':o', 'Color', color_a, 'LineWidth', 5) 
plot( b_w_YnoX, RMSE_Y_YnoX_MVW,'-.o', 'Color', color_w, 'LineWidth', 5)
hold off
L=legend('Gaspari-Cohn', 'Bolin-Wallin', 'Askey', 'Wendland');
set(L, 'Interpreter', 'latex', 'box', 'off', 'TextColor', rich_black)
L.ItemTokenSize = [59,18];
set(gca, 'FontSize', 24, 'LineWidth', 2)
set(gca,'TickLabelInterpreter','latex', 'Xcolor', rich_black,...
         'Ycolor', rich_black, 'box', 'off');
ylabel('RMSE Y', 'Interpreter', 'latex', 'Color', rich_black)
xlabel('Cross-localization weight factor, $\beta$', 'Interpreter', 'latex')
ylim([0.0143 0.0245])
set(gcf, 'Position',  [100, 100, 800, 800])

saveas(gcf, 'Plots/optimal_beta_YnoX.png')

%% 2. Plot X no Y

figure
subplot(2,1,1)
plot( b_gc_XnoY, RMSE_X_XnoY_MVGC, '-o', b_bw_XnoY, RMSE_X_XnoY_MVBW, '-o',...
      b_a_XnoY, RMSE_X_XnoY_MVA, '-o', b_w_XnoY, RMSE_X_XnoY_MVW, '-o', 'LineWidth', 3)
ylabel('RMSE X')
xlabel('cross-localization weight factor')
title('Observe X: Optimal cross-localization weight factor')
legend('Gaspari-Cohn', 'Bolin-Wallin', 'Askey', 'Wendland', 'location', 'southeast')
set(gca, 'FontSize', 18)

subplot(2,1,2)
plot( b_gc_XnoY, RMSE_Y_XnoY_MVGC, '-o', b_bw_XnoY, RMSE_Y_XnoY_MVBW, '-o',...
      b_a_XnoY, RMSE_Y_XnoY_MVA, '-o', b_w_XnoY, RMSE_Y_XnoY_MVW, '-o', 'LineWidth', 3)
ylabel('RMSE Y')
xlabel('cross-localization weight factor')
legend('Gaspari-Cohn', 'Bolin-Wallin', 'Askey', 'Wendland', 'location', 'southeast')
set(gca, 'FontSize', 18)
set(gcf, 'Position',  [100, 100, 800, 800])

saveas(gcf, 'Plots/optimal_beta_XnoY.png')

%% 3. Plot Both X and Y

figure
subplot(2,1,1)
plot( b_gc_BothXY, RMSE_X_BothXY_MVGC, '-o', b_bw_BothXY, RMSE_X_BothXY_MVBW, '-o', ...
      b_a_BothXY, RMSE_X_BothXY_MVA, '-o', b_w_BothXY, RMSE_X_BothXY_MVW, '-o', 'LineWidth', 3)
ylabel('RMSE X')
xlabel('cross-localization weight factor')
title('Observe X and Y: Optimal cross-localization weight factor')
legend('Gaspari-Cohn', 'Bolin-Wallin', 'Askey', 'Wendland', 'location', 'southeast')
set(gca, 'FontSize', 18)

subplot(2,1,2)
plot( b_gc_BothXY, RMSE_Y_BothXY_MVGC, '-o', b_bw_BothXY, RMSE_Y_BothXY_MVBW, '-o',...
      b_a_BothXY, RMSE_Y_BothXY_MVA, '-o', b_w_BothXY, RMSE_Y_BothXY_MVW, '-o', 'LineWidth', 3)
ylabel('RMSE Y')
xlabel('cross-localization weight factor')
legend('Gaspari-Cohn', 'Bolin-Wallin', 'Askey', 'Wendland', 'location', 'southeast')
set(gca, 'FontSize', 18)
set(gcf, 'Position',  [100, 100, 800, 800])

saveas(gcf, 'Plots/optimal_beta_BothXY.png')

