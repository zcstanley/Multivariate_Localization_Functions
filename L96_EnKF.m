function [rmsY, rmsX, fcast_err] = L96_EnKF(params, Nt, dtObs, sigma2Y, sigma2X, Frac_Obs_Y, Frac_Obs_X, Ne, x_position, rInf, Adapt_Inf, loc_fun_name, loc_params, True_Fcast_Err)
% Implements EnKF for bivariate L96
%
% INPUTS:
% params = L96 params
% Nt = Number of assimilation cycles
% dtObs = Time between assimilation cycles
% sigma2X = X obs error variance
% sigma2Y = Y obs error variance
% NoX = Number of X obs
% NoY = Number of Y obs
% Ne = Ensemble size
% x_position =  Where is X_k located? (middle or first)
% rInf = Inflation factor 
% Adapt_Inf = Use adaptive inflation or constant inflation?
% loc_fun_name = Localization function name
% loc_params = Localization parameters
%
% OUTPUTS:
% rmsY = root mean square error for process Y
% rmsX = root mean square error for process X


%% Initial set up
[Ny, Nx, N, NoY, NoX, No] = derived_parameters(params, Frac_Obs_Y, Frac_Obs_X);
[XT, ~, X, XM] = compute_true_solution(params, N, Ne, Nt, dtObs);
s = set_up_spatial_locations(x_position, params, Ny, Nx);
loc = create_localization_matrix(s, Ny, Nx, loc_fun_name, loc_params);
[H, R, Y, YN] = set_up_observations(Ny, Nx, NoY, NoX, Nt, Ne, sigma2Y, sigma2X, XT);
if Adapt_Inf
    [rInf, rSig, obs_var, LS] = set_up_adaptive_inflation(rInf, N, NoY, NoX, Nt, sigma2Y, sigma2X);
end
rmsY = NaN(1, Nt);
rmsX = NaN(1, Nt);
if True_Fcast_Err 
    fcast_err = zeros(N, N, Nt);
end
%% Run EnKF
for ii=1:Nt
    
    % Forecast ensemble
    for jj=1:Ne
        [~,sol] = ode45(@(t,y) RHS_L96(t,y,params),[0 dtObs/2 dtObs],X(:,jj));
        X(:,jj) = sol(3,:)';
    end
    
    % Inflation
    if Adapt_Inf
        [rInf, rSig] = adaptive_inflation(H, X, Y(:, ii), N, No, Ne, obs_var, loc, rInf, rSig);
        % Store inflation factors
        LS(:,ii) = rInf ;
    end 
    xm = mean(X,2);
    X = xm + sqrt(rInf).*(X-xm);
    
    if True_Fcast_Err
        % Store true forecast error 
        EX = X - XT(:,ii); % true forecast error
        err_corr = corr(EX'); % true forecast error correlation
        fcast_err(:,:,ii) = err_corr;
    end
    
    % Form & localize ensemble covariance (inefficient, but OK for a small system)
    C = loc.*cov(X');
    K = (C*(H'))/(H*C*(H') + R); % Bad! But OK for small system
    
    % Update ensemble members
    for jj=1:Ne
        YN(1:NoX,:) = Y(1:NoX,ii) + sqrt(sigma2X)*randn(NoX,Ne);
        YN(NoX+1:No,:) = Y(NoX+1:No,ii) + sqrt(sigma2Y)*randn(NoY,Ne);
        X(:,jj) = X(:,jj) + K*(YN(:,jj) - H*X(:,jj));
    end
    
    % Store EnKF analysis mean
    XM(:,ii) = mean(X,2);
    
    % Calculate RMSE
    rmsY(ii) = sqrt(mean((XT(1:Ny,ii)  - XM(1:Ny,ii)).^2)) ;
    rmsX(ii) = sqrt(mean((XT(Ny+1:N,ii)  - XM(Ny+1:N,ii)).^2)) ;
    try
        assert( (rmsY(ii) < 5*rmsY(1)) && (rmsX(ii) < 5*rmsX(1)))
    catch
        warning('Suspected catastrophic filter divergence at iteration %g. Returning current RMSE.', ii)
        return
    end
    
end

%% Calculate RMSE
rmsY = squeeze(sqrt(mean((XT(1:Ny,:)  - XM(1:Ny,:)).^2))) ;
rmsX = squeeze(sqrt(mean((XT(Ny+1:N,:)- XM(Ny+1:N,:)).^2))) ;

end
    