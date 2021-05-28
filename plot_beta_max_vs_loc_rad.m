%% Plot maximum cross-localization weight factor (beta_max)
% as a function of kappa^2 = R_XX/R_YY

%% Define common parameters
rYY = 1;                    % localization radius for Y
rXX = linspace(1,5);        % localization radius for X

%% Askey
rXY = min(rXX, rYY);
nu = 1;
gammaYY = 0;
gammaXX = 1;
gammaXY = 1/2*(gammaYY + gammaXX./(rXX./rYY));
params = struct('rYY', rYY, 'rXX', rXX, 'rXY', rXY, 'nu', nu,... 
                'gammaYY', gammaYY, 'gammaXX', gammaXX, 'gammaXY', gammaXY);
bXY_A = askey_beta_max(params);

%% Wendland
rXY = min(rXX, rYY);
nu = 2;
k = 1;
gammaYY = 0;
gammaXX = 5;
gammaXY = 1/2*(gammaYY + gammaXX./(rXX./rYY));
params = struct('rYY', rYY, 'rXX', rXX, 'rXY', rXY, 'nu', nu, 'k', k,... 
                'gammaYY', gammaYY, 'gammaXX', gammaXX, 'gammaXY', gammaXY);
bXY_W = wendland_beta_max(params);

%% Gaspari-Cohn and Bolin-Wallin
params = struct('rYY', rYY, 'rXX', rXX) ;
bXY_GC = gaspari_cohn_beta_max(params);
bXY_BW = bolin_wallin_beta_max(params);


% plot maximum cross-localization weight factor
figure
plot(rXX, bXY_GC, rXX, bXY_BW, rXX, bXY_A, rXX, bXY_W, 'LineWidth', 3)
legend('Gaspari-Cohn', 'Bolin-Wallin', 'Askey', 'Wendland')
ylabel('Maximum cross-localization weight, $\beta_{\max}$', 'Interpreter', 'Latex')
xlabel('$R_{XX}/ R_{YY}$', 'Interpreter', 'latex')
set(gca, 'FontSize', 18)
%saveas(gcf, '../Plots/beta_max_vs_loc_rad.png')