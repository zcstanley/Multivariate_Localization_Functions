%% Load output produced from script optimal_multivariate_gamma_save_output
load('optimal_multivariate_gamma.mat') 

%% Plot: Observe Y

% 1A. Askey
figure
subplot(2,1,1)
imagesc(RMSE_X_YnoX_MVA); colorbar
hold on;
for xx = 1:length(gamma_xx_a)
  for yy = 1:length(gamma_yy)
      val = num2str(round(RMSE_X_YnoX_MVA(yy,xx),4));
      text(xx,yy,val)
  end
end
hold off;
title('Observe Y: Askey $\gamma$, RMSE X', 'Interpreter', 'latex')
set(gca, 'FontSize', 18, 'XTick', 1:length(gamma_xx_a), 'XTickLabel', gamma_xx_a,... 
                         'YTick', 1:length(gamma_yy), 'YTickLabel', gamma_yy)
xlabel('$\gamma_{XX}$', 'Interpreter', 'latex')
ylabel('$\gamma_{YY}$', 'Interpreter', 'latex')

subplot(2,1,2)
imagesc(RMSE_Y_YnoX_MVA); colorbar
hold on;
for xx = 1:length(gamma_xx_a)
  for yy = 1:length(gamma_yy)
      val = num2str(round(RMSE_Y_YnoX_MVA(yy,xx),4));
      text(xx,yy,val)
  end
end
hold off;
title('RMSE Y', 'Interpreter', 'latex')
set(gca, 'FontSize', 18, 'XTick', 1:length(gamma_xx_a), 'XTickLabel', gamma_xx_a,... 
                         'YTick', 1:length(gamma_yy), 'YTickLabel', gamma_yy)
xlabel('$\gamma_{XX}$', 'Interpreter', 'latex')
ylabel('$\gamma_{YY}$', 'Interpreter', 'latex')
set(gcf, 'Position',  [100, 100, 800, 800])

saveas(gcf, 'Plots/optimal_gamma_askey_YnoX.png')

% 1B. Wendland
figure
subplot(2,1,1)
imagesc(RMSE_X_YnoX_MVW); colorbar
hold on;
for xx = 1:length(gamma_xx_w)
  for yy = 1:length(gamma_yy)
      val = num2str(round(RMSE_X_YnoX_MVW(yy,xx),4));
      text(xx,yy,val)
  end
end
hold off;
title('Observe Y: Wendland $\gamma$, RMSE X', 'Interpreter', 'latex')
set(gca, 'FontSize', 18, 'XTick', 1:length(gamma_xx_w), 'XTickLabel', gamma_xx_w,... 
                         'YTick', 1:length(gamma_yy), 'YTickLabel', gamma_yy)
xlabel('$\gamma_{XX}$', 'Interpreter', 'latex')
ylabel('$\gamma_{YY}$', 'Interpreter', 'latex')

subplot(2,1,2)
imagesc(RMSE_Y_YnoX_MVW); colorbar
hold on;
for xx = 1:length(gamma_xx_w)
  for yy = 1:length(gamma_yy)
      val = num2str(round(RMSE_Y_YnoX_MVW(yy,xx),4));
      text(xx,yy,val)
  end
end
hold off;
title('RMSE Y', 'Interpreter', 'latex')
set(gca, 'FontSize', 18, 'XTick', 1:length(gamma_xx_w), 'XTickLabel', gamma_xx_w,... 
                         'YTick', 1:length(gamma_yy), 'YTickLabel', gamma_yy)
xlabel('$\gamma_{XX}$', 'Interpreter', 'latex')
ylabel('$\gamma_{YY}$', 'Interpreter', 'latex')
set(gcf, 'Position',  [100, 100, 1200, 800])

saveas(gcf, 'Plots/optimal_gamma_wendland_YnoX.png')


%% Plot: Observe X

% 2A. Askey
figure
subplot(2,1,1)
imagesc(RMSE_X_XnoY_MVA); colorbar
hold on;
for xx = 1:length(gamma_xx_a)
  for yy = 1:length(gamma_yy)
      val = num2str(round(RMSE_X_XnoY_MVA(yy,xx),4));
      text(xx,yy,val)
  end
end
hold off;
title('Observe X: Askey $\gamma$, RMSE X', 'Interpreter', 'latex')
set(gca, 'FontSize', 18, 'XTick', 1:length(gamma_xx_a), 'XTickLabel', gamma_xx_a,... 
                         'YTick', 1:length(gamma_yy), 'YTickLabel', gamma_yy)
xlabel('$\gamma_{XX}$', 'Interpreter', 'latex')
ylabel('$\gamma_{YY}$', 'Interpreter', 'latex')

subplot(2,1,2)
imagesc(RMSE_Y_XnoY_MVA); colorbar
hold on;
for xx = 1:length(gamma_xx_a)
  for yy = 1:length(gamma_yy)
      val = num2str(round(RMSE_Y_XnoY_MVA(yy,xx),4));
      text(xx,yy,val)
  end
end
hold off;
title('RMSE Y', 'Interpreter', 'latex')
set(gca, 'FontSize', 18, 'XTick', 1:length(gamma_xx_a), 'XTickLabel', gamma_xx_a,... 
                         'YTick', 1:length(gamma_yy), 'YTickLabel', gamma_yy)
xlabel('$\gamma_{XX}$', 'Interpreter', 'latex')
ylabel('$\gamma_{YY}$', 'Interpreter', 'latex')
set(gcf, 'Position',  [100, 100, 800, 800])

saveas(gcf, 'Plots/optimal_gamma_askey_XnoY.png')

% 2B. Wendland
figure
subplot(2,1,1)
imagesc(RMSE_X_XnoY_MVW); colorbar
hold on;
for xx = 1:length(gamma_xx_w)
  for yy = 1:length(gamma_yy)
      val = num2str(round(RMSE_X_XnoY_MVW(yy,xx),4));
      text(xx,yy,val)
  end
end
hold off;
title('Observe X: Wendland $\gamma$, RMSE X', 'Interpreter', 'latex')
set(gca, 'FontSize', 18, 'XTick', 1:length(gamma_xx_w), 'XTickLabel', gamma_xx_w,... 
                         'YTick', 1:length(gamma_yy), 'YTickLabel', gamma_yy)
xlabel('$\gamma_{XX}$', 'Interpreter', 'latex')
ylabel('$\gamma_{YY}$', 'Interpreter', 'latex')

subplot(2,1,2)
imagesc(RMSE_Y_XnoY_MVW); colorbar
hold on;
for xx = 1:length(gamma_xx_w)
  for yy = 1:length(gamma_yy)
      val = num2str(round(RMSE_Y_XnoY_MVW(yy,xx),4));
      text(xx,yy,val)
  end
end
hold off;
title('RMSE Y', 'Interpreter', 'latex')
set(gca, 'FontSize', 18, 'XTick', 1:length(gamma_xx_w), 'XTickLabel', gamma_xx_w,... 
                         'YTick', 1:length(gamma_yy), 'YTickLabel', gamma_yy)
xlabel('$\gamma_{XX}$', 'Interpreter', 'latex')
ylabel('$\gamma_{YY}$', 'Interpreter', 'latex')
set(gcf, 'Position',  [100, 100, 1200, 800])

saveas(gcf, 'Plots/optimal_gamma_wendland_XnoY.png')

loc_params = struct('rYY', 20, 'rXX', 40, 'rXY', 20, 'gammaYY', 2, 'gammaXX', 0); 
gammaXY = askey_wendland_gamma_cross(loc_params); 
fprintf('gammaXY is %g\n',gammaXY)

%% Plot: Observe X and Y

% 3A. Askey
figure
subplot(2,1,1)
imagesc(RMSE_X_BothXY_MVA); colorbar
hold on;
for xx = 1:length(gamma_xx_a)
  for yy = 1:length(gamma_yy)
      val = num2str(round(RMSE_X_BothXY_MVA(yy,xx),4));
      text(xx,yy,val)
  end
end
hold off;
title('Observe X and Y: Askey $\gamma$, RMSE X', 'Interpreter', 'latex')
set(gca, 'FontSize', 18, 'XTick', 1:length(gamma_xx_a), 'XTickLabel', gamma_xx_a,... 
                         'YTick', 1:length(gamma_yy), 'YTickLabel', gamma_yy)
xlabel('$\gamma_{XX}$', 'Interpreter', 'latex')
ylabel('$\gamma_{YY}$', 'Interpreter', 'latex')

subplot(2,1,2)
imagesc(RMSE_Y_BothXY_MVA); colorbar
hold on;
for xx = 1:length(gamma_xx_a)
  for yy = 1:length(gamma_yy)
      val = num2str(round(RMSE_Y_BothXY_MVA(yy,xx),4));
      text(xx,yy,val)
  end
end
hold off;
title('RMSE Y', 'Interpreter', 'latex')
set(gca, 'FontSize', 18, 'XTick', 1:length(gamma_xx_a), 'XTickLabel', gamma_xx_a,... 
                         'YTick', 1:length(gamma_yy), 'YTickLabel', gamma_yy)
xlabel('$\gamma_{XX}$', 'Interpreter', 'latex')
ylabel('$\gamma_{YY}$', 'Interpreter', 'latex')
set(gcf, 'Position',  [100, 100, 800, 800])

saveas(gcf, 'Plots/optimal_gamma_askey_BothXY.png')

% 3B. Wendland
figure
subplot(2,1,1)
imagesc(RMSE_X_BothXY_MVW); colorbar
hold on;
for xx = 1:length(gamma_xx_w)
  for yy = 1:length(gamma_yy)
      val = num2str(round(RMSE_X_BothXY_MVW(yy,xx),4));
      text(xx,yy,val)
  end
end
hold off;
title('Observe X and Y: Wendland $\gamma$, RMSE X', 'Interpreter', 'latex')
set(gca, 'FontSize', 18, 'XTick', 1:length(gamma_xx_w), 'XTickLabel', gamma_xx_w,... 
                         'YTick', 1:length(gamma_yy), 'YTickLabel', gamma_yy)
xlabel('$\gamma_{XX}$', 'Interpreter', 'latex')
ylabel('$\gamma_{YY}$', 'Interpreter', 'latex')

subplot(2,1,2)
imagesc(RMSE_Y_BothXY_MVW); colorbar
hold on;
for xx = 1:length(gamma_xx_w)
  for yy = 1:length(gamma_yy)
      val = num2str(round(RMSE_Y_BothXY_MVW(yy,xx),4));
      text(xx,yy,val)
  end
end
hold off;
title('RMSE Y', 'Interpreter', 'latex')
set(gca, 'FontSize', 18, 'XTick', 1:length(gamma_xx_w), 'XTickLabel', gamma_xx_w,... 
                         'YTick', 1:length(gamma_yy), 'YTickLabel', gamma_yy)
xlabel('$\gamma_{XX}$', 'Interpreter', 'latex')
ylabel('$\gamma_{YY}$', 'Interpreter', 'latex')
set(gcf, 'Position',  [100, 100, 1200, 800])

saveas(gcf, 'Plots/optimal_gamma_wendland_BothXY.png')

loc_params = struct('rYY', 15, 'rXX', 40, 'rXY', 15, 'gammaYY', 2, 'gammaXX', 0); 
gammaXY = askey_wendland_gamma_cross(loc_params); 
fprintf('gammaXY is %g\n',gammaXY)

