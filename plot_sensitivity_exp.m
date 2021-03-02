% Sensitivity expriments: Askey and Wendland mu_x
load('MuX_MV_A_2.mat')
load('MuX_MV_W_2.mat')

% Process Askey
RMSE_X_A_MV = RMSE_X_A_MV(1:50, :);
MUX_A = MUX_A(1:50, :);
mux_A = unique(MUX_A(:,1));
rms_A = zeros(size(mux_A));
up_A = zeros(size(mux_A));
lp_A = zeros(size(mux_A));
for ii = 1:length(mux_A)
    this = (MUX_A==mux_A(ii));
    these = RMSE_X_A_MV(this, 1001:end);
    rms_A(ii) = mean(these(:));
    up_A(ii) = prctile(these(:), 95);
    lp_A(ii) = prctile(these(:), 05);
end

figure
plot(mux_A, rms_A, 'LineWidth', 3)
hold on
plot(mux_A, up_A, 'k--', 'LineWidth', 3)
plot(mux_A, lp_A, 'k--', 'LineWidth', 3)
hold off
xlabel('$\gamma_{XX}$', 'Interpreter', 'Latex')
ylabel('RMSE')
title('Askey')
set(gca, 'FontSize', 18)
%saveas(gcf, '../Plots/A_mux.png')
%saveas(gcf, '../Plots/A_gamma_XX.png')

% Process Wendland
RMSE_X_W_MV = RMSE_X_W_MV(1:100, :);
MUX_W = MUX_W(1:100,1);
mux_W = unique(MUX_W(:,1));
%mux_W = mux_W(2:end);
rms_W = zeros(size(mux_W));
up_W = zeros(size(mux_W));
lp_W = zeros(size(mux_W));
for ii = 1:length(mux_W)
    this = (MUX_W==mux_W(ii));
    these = RMSE_X_W_MV(this, 1001:end);
    rms_W(ii) = mean(these(:));
    up_W(ii) = prctile(these(:), 95);
    lp_W(ii) = prctile(these(:), 05);
end

figure
plot(mux_W, rms_W, 'LineWidth', 3)
hold on
plot(mux_W, up_W, 'k--', 'LineWidth', 3)
plot(mux_W, lp_W, 'k--', 'LineWidth', 3)
hold off
xlabel('$\gamma_{XX}$', 'Interpreter', 'Latex')
ylabel('RMSE')
title('Wendland')
xlim([1,10])
set(gca, 'FontSize', 18)
%saveas(gcf, '../Plots/W_mux.png')
%saveas(gcf, '../Plots/W_gamma_XX.png')