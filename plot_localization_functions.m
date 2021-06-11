%% Produces Figure 1 from Stanley et al. (2021)
%
% Author: Zofia Stanley

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
oxford_blue = [12, 27, 49, 0.85*256]./256;
maximum_green = [77, 139, 49, 0.9*256]./256;
rich_black = [8, 18, 33]./256;
color_gc = maximum_green;
color_bw = oxford_blue; 
color_a = oxford_blue;
color_w = oxford_blue;

%% Plot
% Plot YY functions together
figure
plot(dis, locYY_GC, 'Color', color_gc, 'LineWidth', 5)
hold on
plot(dis, locYY_BW,'--', 'Color', color_bw, 'LineWidth', 5)
plot(dis, locYY_A, ':', 'Color', color_a, 'LineWidth', 5) 
plot(dis, locYY_W,'-.', 'Color', color_w, 'LineWidth', 5)
hold off
%L=legend('Gaspari-Cohn', 'Bolin-Wallin', 'Askey', 'Wendland');
%set(L, 'Interpreter', 'latex', 'box', 'off', 'TextColor', rich_black)
xlabel('Distance', 'Interpreter', 'latex', 'Color', rich_black)
ylim([0,1])
xlim([-49, 49])
set(gca, 'FontSize', 24, 'LineWidth', 2)
set(gca,'TickLabelInterpreter','latex', 'Xcolor', rich_black,...
         'Ycolor', rich_black, 'box', 'off');
title('$\mathcal{L}_{YY}$', 'Interpreter', 'latex', 'Color', rich_black, 'Position', [-36 0.93 0], 'FontSize', 36)
saveas(gcf, 'Plots/Fun_YY.png')

% Plot XX functions together
figure
plot(dis, locXX_GC, 'Color', color_gc, 'LineWidth', 5)
hold on
plot(dis, locXX_BW,'--', 'Color', color_bw, 'LineWidth', 5)
plot(dis, locXX_A, ':', 'Color', color_a, 'LineWidth', 5) 
plot(dis, locXX_W,'-.', 'Color', color_w, 'LineWidth', 5)
hold off
%L=legend('Gaspari-Cohn', 'Bolin-Wallin', 'Askey', 'Wendland');
%set(L, 'Interpreter', 'latex', 'box', 'off', 'TextColor', rich_black)
xlabel('Distance', 'Interpreter', 'latex', 'Color', rich_black)
set(gca, 'FontSize', 24, 'LineWidth', 2)
set(gca,'TickLabelInterpreter','latex', 'Xcolor', rich_black,...
         'Ycolor', rich_black, 'box', 'off');
ylim([0,1])
xlim([-49, 49])
title('$\mathcal{L}_{XX}$', 'Interpreter', 'latex', 'Color', rich_black, 'Position', [-36 0.93 0], 'FontSize', 36)
saveas(gcf, 'Plots/Fun_XX.png')

% Plot XY functions together
figure
plot(dis, locXY_GC, 'Color', color_gc, 'LineWidth', 5)
hold on
plot(dis, locXY_BW,'--', 'Color', color_bw, 'LineWidth', 5)
plot(dis, locXY_A, ':', 'Color', color_a, 'LineWidth', 5) 
plot(dis, locXY_W,'-.', 'Color', color_w, 'LineWidth', 5)
hold off
L=legend('Gaspari-Cohn', 'Bolin-Wallin', 'Askey', 'Wendland');
set(L, 'Interpreter', 'latex', 'box', 'off', 'TextColor', rich_black)
L.ItemTokenSize = [59,18];
xlabel('Distance', 'Interpreter', 'latex', 'Color', rich_black)
set(gca, 'FontSize', 24, 'LineWidth', 2)
set(gca,'TickLabelInterpreter','latex', 'Xcolor', rich_black,...
         'Ycolor', rich_black, 'box', 'off');
ylim([0,1])
xlim([-49, 49])
title('$\mathcal{L}_{XY}$', 'Interpreter', 'latex', 'Color', rich_black, 'Position', [-36 0.93 0], 'FontSize', 36)
saveas(gcf, 'Plots/Fun_XY.png')


