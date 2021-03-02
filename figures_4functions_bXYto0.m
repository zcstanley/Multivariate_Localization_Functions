load('cY15_cX45_A_bXYto0.mat')
load('cY15_cX45_BW_bXYto0.mat')
load('cY15_cX45_GC_bXYto0.mat')
load('cY15_cX45_W_bXYto0.mat')

% Process Askey
beta_A = unique(bXY_A);
rms_A = zeros(size(beta_A));
for ii = 1:length(beta_A)
    this = (bXY_A==beta_A(ii));
    rms_A(ii) = mean(mean(RMSE_X_A(this, 200:end)));
end

% Process Bolin-Wallin
beta_BW = unique(bXY_BW);
rms_BW = zeros(size(beta_BW));
for ii = 1:length(beta_BW)
    this = (bXY_BW==beta_BW(ii));
    rms_BW(ii) = mean(mean(RMSE_X_BW(this, 200:end)));
end

% Process Gaspari-Cohn
beta_GC = unique(bXY_GC);
rms_GC = zeros(size(beta_GC));
for ii = 1:length(beta_GC)
    this = (bXY_GC==beta_GC(ii));
    rms_GC(ii) = mean(mean(RMSE_X_GC(this, 200:end)));
end

% Process Wendland
beta_W = unique(bXY_W);
rms_W = zeros(size(beta_W));
for ii = 1:length(beta_W)
    this = (bXY_W==beta_W(ii));
    rms_W(ii) = mean(mean(RMSE_X_W(this, 200:end)));
end


plot(beta_GC, rms_GC, beta_BW, rms_BW, beta_A, rms_A, beta_W, rms_W, 'LineWidth', 3)
legend('Gaspari-Cohn', 'Bolin-Wallin', 'Askey', 'Wendland')
ylabel('RMSE', 'Interpreter', 'latex')
xlabel('Cross-localization weight factor, $\beta$', 'Interpreter', 'latex')
set(gca, 'FontSize', 18)
%saveas(gcf, '../Plots/4functions_bXYto0.png')


