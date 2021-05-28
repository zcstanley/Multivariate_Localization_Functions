%% Define common parameters
dis = -50:50;   % distance matrix
rYY = 15;       % localization radius for Y
rXX = 45;       % localization radius for X
cY = rYY/2;     % kernel radius
cX = rXX/2;     % kernel radius

%% Askey
rXY = min(rXX, rYY);
nu = 1;
gammaYY = 0;
gammaXX = 1;
gammaXY = 1/2*(gammaYY + gammaXX/(rXX/rYY));
params = struct('rYY', rYY, 'rXX', rXX, 'rXY', rXY, 'nu', nu,... 
                'gammaYY', gammaYY, 'gammaXX', gammaXX, 'gammaXY', gammaXY);
bXY = askey_beta_max(params);
% Calculate localization weights
locYY_A = askey_univariate(dis, rYY, nu + gammaYY + 1); 
locXX_A = askey_univariate(dis, rXX, nu + gammaXX + 1); 
locXY_A = bXY * askey_univariate(dis, rXY, nu + gammaXY + 1); 

%% Wendland
rXY = min(rXX, rYY);
nu = 2;
k = 1;
gammaYY = 0;
gammaXX = 5;
gammaXY = 1/2*(gammaYY + gammaXX/(rXX/rYY));
params = struct('rYY', rYY, 'rXX', rXX, 'rXY', rXY, 'nu', nu, 'k', k,... 
                'gammaYY', gammaYY, 'gammaXX', gammaXX, 'gammaXY', gammaXY);
bXY = wendland_beta_max(params);
% Calculate localization weights
locYY_W = wendland_univariate(dis, rYY, nu, gammaYY, k); 
locXX_W = wendland_univariate(dis, rXX, nu, gammaXX, k); 
locXY_W = bXY * wendland_univariate(dis, rXY, nu, gammaXY, k);

%% Gaspari-Cohn
locYY_GC = gaspari_cohn_univariate(dis, cY);
locXX_GC = gaspari_cohn_univariate(dis, cX);
locXY_GC = gaspari_cohn_cross(dis, cY, cX);

%% Bolin-Wallin
locYY_BW = bolin_wallin_univariate(dis, cY);
locXX_BW = bolin_wallin_univariate(dis, cX);
locXY_BW = bolin_wallin_cross(dis, cY, cX);

%% Plot
% Plot YY functions together
figure
plot(dis, locYY_GC, dis, locYY_BW, dis, locYY_A, dis, locYY_W, 'LineWidth', 5)
legend('Gaspari-Cohn', 'Bolin-Wallin', 'Askey', 'Wendland')
title('$\mathcal{L}_{YY}$', 'Interpreter', 'latex')
xlabel('Distance')
ylim([0,1])
xlim([-49, 49])
set(gca, 'FontSize', 20, 'LineWidth', 2)
%saveas(gcf, '../Plots/Fun_YY.png')

% Plot XX functions together
figure
plot(dis, locXX_GC, dis, locXX_BW, dis, locXX_A, dis, locXX_W, 'LineWidth', 5)
legend('Gaspari-Cohn', 'Bolin-Wallin', 'Askey', 'Wendland')
title('$\mathcal{L}_{XX}$', 'Interpreter', 'latex')
xlabel('Distance')
set(gca, 'FontSize', 20, 'LineWidth', 2)
ylim([0,1])
xlim([-49, 49])
%saveas(gcf, '../Plots/Fun_XX.png')

% Plot XY functions together
figure
plot(dis, locXY_GC, dis, locXY_BW, dis, locXY_A, dis, locXY_W, 'LineWidth', 5)
legend('Gaspari-Cohn', 'Bolin-Wallin', 'Askey', 'Wendland')
title('$\mathcal{L}_{XY}$', 'Interpreter', 'latex')
xlabel('Distance')
set(gca, 'FontSize', 20, 'LineWidth', 2)
ylim([0,1])
xlim([-49, 49])
%saveas(gcf, '../Plots/Fun_XY.png')


