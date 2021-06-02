%% Define common parameters
dis = -50:50;   % distance matrix
rYY = 15;       % localization radius for Y
rXX = 45;       % localization radius for X
rXY = min(rXX, rYY);    % cross-localization radius for Askey and Wendland
cY = rYY/2;     % kernel radius
cX = rXX/2;     % kernel radius

%% Gaspari-Cohn
locYY_GC = gaspari_cohn_univariate(dis, cY);
locXX_GC = gaspari_cohn_univariate(dis, cX);
locXY_GC = gaspari_cohn_cross(dis, cY, cX);

%% Bolin-Wallin
locYY_BW = bolin_wallin_univariate(dis, cY);
locXX_BW = bolin_wallin_univariate(dis, cX);
locXY_BW = bolin_wallin_cross(dis, cY, cX);

%% Askey
% Parameters
nu = 1; gammaYY = 0; gammaXX = 1;
params = struct('rYY', rYY, 'rXX', rXX, 'rXY', rXY, 'nu', nu,... 
                'gammaYY', gammaYY, 'gammaXX', gammaXX);
gammaXY = askey_wendland_gamma_cross(params);
params.gammaXY = gammaXY;
bXY = askey_beta_max(params);
% Calculate localization weights
locYY_A = askey_univariate(dis, rYY, nu + gammaYY + 1); 
locXX_A = askey_univariate(dis, rXX, nu + gammaXX + 1); 
locXY_A = bXY * askey_univariate(dis, rXY, nu + gammaXY + 1); 

%% Wendland
% Parameters
nu = 2; k = 1; gammaYY = 0; gammaXX = 5;
params = struct('rYY', rYY, 'rXX', rXX, 'rXY', rXY, 'nu', nu, 'k', k,... 
                'gammaYY', gammaYY, 'gammaXX', gammaXX);
gammaXY = askey_wendland_gamma_cross(params);
params.gammaXY = gammaXY;
bXY = wendland_beta_max(params);
% Calculate localization weights
locYY_W = wendland_univariate(dis, rYY, nu, gammaYY, k); 
locXX_W = wendland_univariate(dis, rXX, nu, gammaXX, k); 
locXY_W = bXY * wendland_univariate(dis, rXY, nu, gammaXY, k);

%% Define colors
color_gc = [179, 86, 89]./256;
color_bw = [28, 63, 115]./256;
color_a = [16, 36, 66]./256;
color_w = [4, 9, 16]./256;

%% Plot
% Plot YY functions together
figure
plot(dis, locYY_GC, 'Color', color_gc, 'LineWidth', 5)
hold on
plot(dis, locYY_BW,'--', 'Color', color_bw, 'LineWidth', 5)
plot(dis, locYY_A, ':', 'Color', color_a, 'LineWidth', 5) 
plot(dis, locYY_W,'-.', 'Color', color_w, 'LineWidth', 5)
hold off
legend('Gaspari-Cohn', 'Bolin-Wallin', 'Askey', 'Wendland')
title('$\mathcal{L}_{YY}$', 'Interpreter', 'latex')
xlabel('Distance')
ylim([0,1])
xlim([-49, 49])
set(gca, 'FontSize', 20, 'LineWidth', 2)
saveas(gcf, 'Plots/Fun_YY.png')

% Plot XX functions together
figure
plot(dis, locXX_GC, 'Color', color_gc, 'LineWidth', 5)
hold on
plot(dis, locXX_BW,'--', 'Color', color_bw, 'LineWidth', 5)
plot(dis, locXX_A, ':', 'Color', color_a, 'LineWidth', 5) 
plot(dis, locXX_W,'-.', 'Color', color_w, 'LineWidth', 5)
hold off
legend('Gaspari-Cohn', 'Bolin-Wallin', 'Askey', 'Wendland')
title('$\mathcal{L}_{XX}$', 'Interpreter', 'latex')
xlabel('Distance')
set(gca, 'FontSize', 20, 'LineWidth', 2)
ylim([0,1])
xlim([-49, 49])
saveas(gcf, 'Plots/Fun_XX.png')

% Plot XY functions together
figure
plot(dis, locXY_GC, 'Color', color_gc, 'LineWidth', 5)
hold on
plot(dis, locXY_BW,'--', 'Color', color_bw, 'LineWidth', 5)
plot(dis, locXY_A, ':', 'Color', color_a, 'LineWidth', 5) 
plot(dis, locXY_W,'-.', 'Color', color_w, 'LineWidth', 5)
hold off
legend('Gaspari-Cohn', 'Bolin-Wallin', 'Askey', 'Wendland')
title('$\mathcal{L}_{XY}$', 'Interpreter', 'latex')
xlabel('Distance')
set(gca, 'FontSize', 20, 'LineWidth', 2)
ylim([0,1])
xlim([-49, 49])
saveas(gcf, 'Plots/Fun_XY.png')


