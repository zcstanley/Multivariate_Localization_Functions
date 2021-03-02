load('UV_MV_GC.mat')
load('UV_MV_BW.mat')
load('UV_MV_A.mat')
load('UV_MV_W.mat')

% Gaspari-Cohn
gc_uv = RMSE_X_GC_UV(:, 1001:end);
gc_mv = RMSE_X_GC_MV(:, 1001:end);
str_gc_uv = sprintf('Univariate,\nMedian RMSE = %.2g', median(gc_uv(:)));
str_gc_mv = sprintf('Multivariate,\nMedian RMSE = %.2g', median(gc_mv(:)));
figure
histogram(gc_uv, linspace(0.015, 0.075), 'Normalization', 'probability','LineStyle', 'none')
hold on
histogram(gc_mv, linspace(0.015, 0.075), 'Normalization', 'probability','LineStyle', 'none')
legend(str_gc_uv, str_gc_mv)
title('Gaspari-Cohn', 'horizontalAlignment', 'left', 'Position', [0.013, 0.0465, 1]); 
ylabel('Probability'); xlabel('RMSE')
set(gca, 'FontSize', 18, 'LineWidth', 2)
ylim([0, 0.05])
hold off
%saveas(gcf, '../Plots/HIST_UV_MV_GC.png')

% Bolin-Wallin
bw_uv = RMSE_X_BW_UV(:, 1001:end);
bw_mv = RMSE_X_BW_MV(:, 1001:end);
str_bw_uv = sprintf('Univariate,\nMedian RMSE = %.2g', median(bw_uv(:)));
str_bw_mv = sprintf('Multivariate,\nMedian RMSE = %.2g', median(bw_mv(:)));
% plot
figure
histogram(bw_uv, linspace(0.015, 0.075), 'Normalization', 'probability','LineStyle', 'none')
hold on
histogram(bw_mv, linspace(0.015, 0.075), 'Normalization', 'probability','LineStyle', 'none')
legend(str_bw_uv, str_bw_mv)
title('Bolin-Wallin', 'horizontalAlignment', 'left', 'Position', [0.013, 0.0465, 1]); 
ylabel('Probability'); xlabel('RMSE')
set(gca, 'FontSize', 18, 'LineWidth', 2)
ylim([0, 0.05])
hold off
%saveas(gcf, '../Plots/HIST_UV_MV_BW.png')

% Askey
a_uv = RMSE_X_A_UV(:, 1001:end);
a_mv = RMSE_X_A_MV(:, 1001:end);
str_a_uv = sprintf('Univariate,\nMedian RMSE = %.2g', median(a_uv(:)));
str_a_mv = sprintf('Multivariate,\nMedian RMSE = %.2g', median(a_mv(:)));
% plot
figure
histogram(a_uv, linspace(0.015, 0.075), 'Normalization', 'probability','LineStyle', 'none')
hold on
histogram(a_mv, linspace(0.015, 0.075), 'Normalization', 'probability','LineStyle', 'none')
legend(str_a_uv, str_a_mv)
title('Askey', 'horizontalAlignment', 'left', 'Position', [0.013, 0.0465, 1]); 
ylabel('Probability'); xlabel('RMSE')
set(gca, 'FontSize', 18, 'LineWidth', 2)
ylim([0, 0.05])
hold off
%saveas(gcf, '../Plots/HIST_UV_MV_A.png')

% Wendland
figure
w_uv = RMSE_X_W_UV(:, 1001:end);
w_mv = RMSE_X_W_MV(:, 1001:end);
str_w_uv = sprintf('Univariate,\nMedian RMSE = %.2g', median(w_uv(:)));
str_w_mv = sprintf('Multivariate,\nMedian RMSE = %.2g', median(w_mv(:)));
histogram(w_uv, linspace(0.015, 0.075), 'Normalization', 'probability','LineStyle', 'none')
hold on
histogram(w_mv, linspace(0.015, 0.075), 'Normalization', 'probability','LineStyle', 'none')
legend(str_w_uv, str_w_mv)
title('Wendland', 'horizontalAlignment', 'left', 'Position', [0.013, 0.0465, 1]); 
ylabel('Probability'); xlabel('RMSE')
set(gca, 'FontSize', 18, 'LineWidth', 2)
ylim([0, 0.05])
hold off
%saveas(gcf, '../Plots/HIST_UV_MV_W.png')
