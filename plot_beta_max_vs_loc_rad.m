%% Produces the left panel of Figure B3
% Plot maximum cross-localization weight factor (beta_max)
% as a function of kappa^2 = R_XX/R_YY
%
% Author: Zofia Stanley

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


%% Define colors
oxford_blue = [12, 27, 49, 0.85*256]./256;
maximum_green = [77, 139, 49, 0.9*256]./256;
rich_black = [8, 18, 33]./256;
color_gc = maximum_green;
color_bw = oxford_blue; 
color_a = oxford_blue;
color_w = oxford_blue;

%% Plot maximum cross-localization weight factor

figure
plot(rXX, bXY_GC, rXX, bXY_BW, rXX, bXY_A, rXX, bXY_W, 'LineWidth', 3)
set(gca, 'FontSize', 18)


plot(rXX, bXY_GC, '-', 'Color', color_gc, 'LineWidth', 5)
hold on
plot(rXX, bXY_BW, '--', 'Color', color_bw, 'LineWidth', 5)
plot(rXX, bXY_A, ':', 'Color', color_a, 'LineWidth', 5) 
plot(rXX, bXY_W,'-.', 'Color', color_w, 'LineWidth', 5)
hold off
L=legend('Gaspari-Cohn', 'Bolin-Wallin', 'Askey', 'Wendland');
set(L, 'Interpreter', 'latex', 'box', 'off', 'TextColor', rich_black)
L.ItemTokenSize = [59,18];
xlabel('$R_{XX}/ R_{YY}$', 'Interpreter', 'latex', 'Color', rich_black)
ylabel('Maximum cross-localization weight, $\beta_{\max}$', 'Interpreter', 'Latex', 'Color', rich_black)
set(gca,'TickLabelInterpreter','latex', 'Xcolor', rich_black,...
         'Ycolor', rich_black, 'box', 'off');
set(gca, 'FontSize', 18, 'LineWidth', 2)
saveas(gcf, 'Plots/beta_max_vs_loc_rad.png')