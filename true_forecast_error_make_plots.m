% Makes plots of true forecast error correlations. To save true forecast
% error correlations, run script true_forecast_error_save_output
%
% Author: Zofia Stanley
%% Load output produced from script true_forecast_error_save_output
load('Data/true_forecast_error.mat')
params = struct('K',36,'J',10,'F',10,'a',10,'b',10,'h',2);  %L96 params
Nt = 3000;                      % Number of assimilation cycles
sigma2Y = 0.005;                % Y obs error variance
sigma2X = 0.28;                 % X obs error variance
x_position = 'middle';          % Where is X_k located? (middle or first)
rInf = sqrt(1.21);              % Inflation factor 
Adapt_Inf = true;               % Use adaptive inflation or constant inflation?
Ne = 500;                       % Ensemble size
True_Fcast_Err = true;          % Save true forecast error correlations?
loc_fun_name = 'no_loc';        % localization function name
loc_params = struct('hack',1);  % localization parameters
Ntrial = 10;                    % Number of trials
[Ny, Nx, N] = derived_parameters(params, NaN, NaN);


%% Plot true forecast error correaltion matrices
figure
imagesc(FCAST_ERR_YnoX, [0, 1])
title('True Forecast Error Correlations')
colormap(flipud(bone));
colorbar
saveas(gcf, 'Plots/true_fcast_err_corr_matrix_YnoX.png')

figure
imagesc(FCAST_ERR_XnoY, [0, 1]) 
title('Observe X')
colormap(flipud(bone));
colorbar 

figure
imagesc(FCAST_ERR_BothXY, [0, 1])
title('Observe both X and Y')
colormap(flipud(bone));
colorbar

%% Plot correlation by distance

% distance matrix
s = set_up_spatial_locations(x_position, params, Ny, Nx);
dis = create_distance_matrix(s, Ny);
a = params.a;

% which correlation?
corr_mat = FCAST_ERR_YnoX;

% YY correlations
Cyy = zeros(Ny, Ny/a);
Dyy = Cyy;
ind=0;
for ii = a/2:a:Ny
    ind = ind +1;
    Cyy(:, ind) = corr_mat([ii:Ny, 1:ii-1] , ii);
    Dyy(:, ind) = dis([ii:Ny, 1:ii-1], ii);
end
Cyy = mean(Cyy, 2);
Dyy = mean(Dyy, 2);
Cyy = Cyy([Ny-51:Ny, 1:53]);
Dyy = Dyy([Ny-51:Ny, 1:53]);
Dyy(1:52) = -1*Dyy(1:52);

% XX correlations
Cxx = zeros(Nx);
Dxx = Cxx;
for ii = 1:Nx
    Cxx(:, ii) = corr_mat([Ny+ii:N, Ny+1:Ny+ii-1] , Ny+ii);
    Dxx(:, ii) = dis([Ny+ii:N, Ny+1:Ny+ii-1] , Ny+ii);
end
Cxx = mean(Cxx, 2);
Dxx = mean(Dxx, 2);
Cxx = Cxx([Nx-5:Nx, 1:7]);
Dxx = Dxx([Nx-5:Nx, 1:7]);
Dxx(1:6) = -1 * Dxx(1:6);

% XY correlations
Cxy = zeros(Ny,Nx);
Dxy = Cxy;
for ii = 1:Nx
    Cxy(:, ii) = corr_mat([(1+a*(ii-1)):Ny, 1:a*(ii-1)], Ny+ii);
    Dxy(:, ii) = dis([(1+a*(ii-1)):Ny, 1:a*(ii-1)], Ny+ii);
end
Cxy = mean(Cxy, 2);
Dxy = mean(Dxy, 2);
Cxy = Cxy([Ny-47:Ny, 1:58]);
Dxy = Dxy([Ny-47:Ny, 1:58]);
Dxy(1:53) = -1 * Dxy(1:53);

% YX correlations
Cyx = zeros(Nx, Nx);
Dyx = Cyx;
ind=0;
for ii = a/2:a:Ny
    ind = ind +1;
    Cyx(:,ind) = corr_mat([Ny+ind:N, Ny+1:Ny+ind-1], ii);    
    Dyx(:,ind) = dis([Ny+ind:N, Ny+1:Ny+ind-1], ii);  
end
Cyx = mean(Cyx, 2);
Dyx = mean(Dyx, 2);
Cyx = Cyx([Nx-5:Nx, 1:7]);
Dyx = Dyx([Nx-5:Nx, 1:7]);
Dyx(1:6) = -1*Dyx(1:6);

%% Define colors
oxford_blue = [12, 27, 49]./256;
aero = [135, 188, 222]./256;
mystic_maroon = [166, 78, 121]./256;
wine = [108, 35, 47]./256;
rich_black = [8, 18, 33]./256;

%% Plot

plot(Dyy, Cyy, 'Color', oxford_blue, 'LineWidth', 5)
hold on
plot(Dxx, Cxx, 'Color', wine, 'LineWidth', 5)
plot(Dxy, Cxy, 'Color', mystic_maroon, 'LineWidth', 5)
plot(Dyx, Cyx, 'Color', aero, 'LineWidth', 5)
ylim([-0.2, 0.4])
xlim([-50, 50])
xlabel('Distance', 'Interpreter', 'latex', 'Color', rich_black)
ylabel('Correlation', 'Interpreter', 'latex', 'Color', rich_black)
title('True Forecast Error Correlation', 'Interpreter', 'latex', 'Color', rich_black)
L=legend('Cov$(Y_{5, k_1}, Y_{j, k_2})$','Cov$(X_{k_1}, X_{k_2})$',... 
        'Cov$(X_{k_1}, Y_{j, k_2})$', 'Cov$(Y_{5, k_1}, X_{k_2})$');
set(L, 'Interpreter', 'latex', 'box', 'off', 'TextColor', rich_black)
L.ItemTokenSize = [59,18];
set(gca, 'FontSize', 24, 'LineWidth', 2)
set(gca,'TickLabelInterpreter','latex', 'Xcolor', rich_black,...
         'Ycolor', rich_black, 'box', 'off');
set(gcf, 'Position',  [100, 100, 1200, 400])

saveas(gcf, 'Plots/true_fcast_err_corr_YnoX.png')


