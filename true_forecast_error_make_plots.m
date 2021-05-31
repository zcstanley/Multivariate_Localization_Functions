%% Load output produced from script true_forecast_error_save_output
load('true_forecast_error.mat')
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
title('Observe Y')
colormap(flipud(bone));
colorbar

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

%% Plot correaltion by distance

% distance matrix
s = set_up_spatial_locations(x_position, params, Ny, Nx);
dis = create_distance_matrix(s, Ny);
a = params.a;

% which correlation?
corr_mat = FCAST_ERR_XnoY;

% YY correlations
Cyy = zeros(Ny, Ny/a);
ind=0;
for ii = a/2:a:Ny
    ind = ind +1;
    Cyy(:, ind) = corr_mat([ii:Ny, 1:ii-1] , ii);
end
Cyy = mean(Cyy, 2);
Cyy = Cyy([Ny-49:Ny, 1:51]);

% XX correlations
Cxx = zeros(Nx);
for ii = 1:Nx
    Cxx(:, ii) = corr_mat([Ny+ii:N, Ny+1:Ny+ii-1] , Ny+ii);
end
Cxx = mean(Cxx, 2);
Cxx = Cxx([Nx-4:Nx, 1:6]);

% XY correlations
Cxy = zeros(Ny,Nx);
for ii = 1:Nx
    Cxy(:, ii) = corr_mat([(1+a*(ii-1)):Ny, 1:a*(ii-1)], Ny+ii);
end
Cxy = mean(Cxy, 2);
Cxy = Cxy([Ny-49:Ny, 1:50]);

% YX correlations
Cyx = zeros(Nx, Nx);
ind=0;
for ii = a/2:a:Ny
    ind = ind +1;
    Cyx(:,ind) = corr_mat([Ny+ind:N, Ny+1:Ny+ind-1], ii);    
end
Cyx = mean(Cyx, 2);
Cyx = Cyx([Nx-5:Nx, 1:6]);


plot(-50:50, Cyy, (-5:5)*10, Cxx, -0.5+(-49:50), Cxy, 0.5+10*(-6:5), Cyx, 'LineWidth', 3)
ylim([-0.2, 0.4])
xlim([-50, 50])
legend({'Cov$(Y_{5, k_1}, Y_{j, k_2})$','Cov$(X_{k_1}, X_{k_2})$',... 
        'Cov$(X_{k_1}, Y_{j, k_2})$', 'Cov$(Y_{5, k_1}, X_{k_2})$'}, 'Interpreter', 'latex')
xlabel('Distance')
ylabel('Correlation')
title('True Forecast Error Correlation')
set(gca, 'FontSize', 18)


