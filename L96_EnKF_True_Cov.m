%% Implements EnKF for bivariate L96. Uses 0.005 observation interval ~ 36 minutes
tic
%% Set up parameters
params = struct('K',36,'J',10,'F',10,'a',10,'b',10,'h',2);
Nx = params.K;
Ny = params.K*params.J;
N = params.K*(params.J+1); % Total number of dependent variables
Nt = 3000; % Number of assimilation cycles
dtObs = 0.005; % Time between assimilation cycles
%NoX = floor(.2*params.K); % Number of X obs per cycle
%NoY = floor(.9*params.K*params.J); % Number of Y obs per cycle
NoX = 0; % observe none of the X variables
NoY = Ny; % observe all of the Y variables
No = NoX + NoY; % Number of obs per cycle
Ne = 500; % Ensemble size
% s = [1:Ny (1 + params.J*(0:params.K-1))]; % spatial locations
    % Note: this definition of s is from Roh et al. To me it would make 
    % more sense to define an X variable as being in the middle of the range
    % of Y variables that it influences, i.e.
s = [1:Ny (5.5 + 10*(0:params.K-1))]; % spatial locations
    % This would also mean that X and Y are never co-located.

%% Set up Localization
% Currently supports: No localization, Askey, and Wendland Localization
% 1) No localization: 
     locFun = 'NoLoc'; locParams = 1 ;
% 2) No localization within variable, between-variable cross-covariances
% tapered by bxy (e.g. bxy = 0 or 0.1):
    % locFun = 'NoLoc'; B = YXMat(1, bxy, 1, Ny, Nx); locParams = B;
% 3) Gaspari-Cohn univariate localization, with between-variable 
% cross-covariances tapered by bxy
    % locFun = 'GC';  B = YXMat(1, bxy, 1, Ny, Nx); c = locRad / 2;
    % locParams = struct( 'c', c, 'B', B);
% 4) Askey MV localization:
    % locFun = 'Askey'; B = YXMat(1, bxy, 1, Ny, Nx); c = locRad; nu = nu;
    % mu = YXMat(muY, muXY, muX, Ny, Nx);
    % locParams = struct('c', c, 'nu', nu, 'mu', mu, 'B', B);
% 5) Wendland MV loaclization:
     % locFun = 'Wendland'; B = YXMat(1, bxy, 1, Ny, Nx); c = locRad; 
     % nu = nu; mu = YXMat(muY, muXY, muX, Ny, Nx); k = k;
     % locParams = struct('c', c, 'nu', nu, 'mu', mu, 'k', k, 'B', B);

%% Compute the true solution
[T,XT] = ode45(@(t,y) RHS_L96(t,y,params),[0 linspace(10,10+Nt*dtObs,Nt)],randn(N,1));
XT = XT(2:end,:)'; T = T(2:end);

%% Set up observations
I = eye(N);
%indX = sort(randsample(s(Ny+1:end),NoX,false)); % Indices of X observations, old
indX = sort(randsample(Ny+1:N,NoX,false)); % Indices of X observations
SoX = s(indX); % spatial locations of X observations
% H(1:NoX,:) = I(indX,:); % old
% Get indices of Y where X is not already observed, then choose random sample
tmp = sort([s(1:Ny) s(indX)]);
idp = diff(tmp)>0;
indY = sort(randsample(tmp([true idp]&[idp true]),NoY,false)); % Indices (also spatial locations) of Y observations
%H = [H;I(indY,:)]; clear I % old
H = I([indY , indX] , :) ; clear I
% Observation error
sigma2X = 0.02; % X obs error variance
sigma2Y = 0.005; % Y obs error variance
R = blkdiag(sigma2Y*eye(NoY),sigma2X*eye(NoX)); % iid obs
% Generate observations
Y = zeros(No,Nt);
%Y(NoX+1:No,:) = XT(indY,:) + sqrt(sigma2Y)*randn(NoY,Nt); % old
%Y(1:NoX,:) = XT(indX,:) + sqrt(sigma2X)*randn(NoX,Nt); % old

Y(1:NoY,:) = XT(indY,:) + sqrt(sigma2Y)*randn(NoY,Nt);
Y(NoY+1:No,:) = XT(indX,:) + sqrt(sigma2X)*randn(NoX,Nt);

%% Set up EnKF
rInf = sqrt(1.015); % Inflation factor
% Initialize ensemble
X = XT(:,1) + randn(N,Ne); % Not clear how Roh et al. initialized
% Store ensemble mean (analysis, not forecast)
XM = zeros(size(XT));
% Initialize ensemble of observations
YN = zeros(No,Ne);

%% Localization

% distance matrix
dis = zeros(N);
for jj=1:N
    for ii=1:N
        d = min([abs(s(ii)-s(jj)), abs(s(ii)+Ny-s(jj)), abs(s(ii)-Ny-s(jj))]);
        dis(ii,jj) = d;
    end
end
clear d


%% Store True Error Correlations

% separate distance matrix by process
% disY = dis(1:Ny, 1:Ny);
% disXY = dis(Ny+1:N, 1:Ny);
% disX = dis(Ny+1:N, Ny+1:N);
% 
% % keep track of directionality in cross-covariance
% signXY = zeros(size(disXY));
% for rr=1:18
%     signXY(rr,:) = -1;
%     signXY(rr, (6+10*(rr-1)):(175+10*rr)) = 1;
% end
% 
% for rr=19:36
%     signXY(rr, :) = 1;
%     signXY(rr, (6+10*(rr-19)):(175+10*(rr-18))) = -1;
% end

% % update distance of Cov(X,Y) to reflect directionality
% disXY = disXY.*signXY;
% disYX = -disXY;
% 
% % unique distance values by process
% dY = unique(disY);
% dXY = unique(disXY);
% dXY = dXY(dXY>=0);
% dYX = unique(disYX);
% dYX = dYX(dYX>=0);
% dX = unique(disX);

% Store true forecast error covariances
% CY = zeros(length(dY), Nt);
% CXY = zeros(length(dXY), Nt);
% CYX = zeros(length(dYX), Nt);
% CX = zeros(length(dX), Nt);
corr_mat = zeros(N, N, Nt);

%% Run EnKF
for ii=1:2%Nt
    if ii/100 == floor(ii/100)
        toc
        fprintf('Iteration %g out of %g.\n', ii, Nt)
    end
    % forecast ensemble
    for jj=1:Ne
        [~,sol] = ode45(@(t,y) RHS_L96(t,y,params),[0 dtObs/2 dtObs],X(:,jj));
        X(:,jj) = sol(3,:)';
    end
    
    % Store forecast error correlation
    EX = X - XT(:,ii); % true forecast error
    Co = corr(EX'); % true forecast error covariance
    corr_mat(:,:,ii) = Co;
%     % separate correlation matrix by process
%     CoY = Co(1:Ny, 1:Ny);
%     CoXY = Co(Ny+1:N, 1:Ny);
%     CoX = Co(Ny+1:N, Ny+1:N);
%     
%     % true error correlation for process Y
%     for jj=1:length(dY)
%         CY(jj, ii) = mean( CoY(disY==dY(jj)) ) ;
%     end
%     
%     % true error cross-correlation
%     for jj=1:length(dXY)
%         CXY(jj, ii) = mean( CoXY(disXY==dXY(jj)) ) ;
%     end
%     % true error cross-correlation
%     for jj=1:length(dYX)
%         CYX(jj, ii) = mean( CoXY(disYX==dYX(jj)) ) ;
%     end
%     
%     % true error correlation for process X
%     for jj=1:length(dX)
%         CX(jj, ii) = mean( CoX(disX==dX(jj)) ) ;
%     end
    
    
    % Inflation
    xm = mean(X,2);
    X = bsxfun(@plus,xm,sqrt(rInf)*bsxfun(@plus,X,-xm));
    % Form & localize ensemble covariance (inefficient, but OK for a small
    % system)
    C = cov(X');
    K = (C*(H'))/(H*C*(H') + R); % Bad! But OK for small system
    
    % Update ensemble members
    for jj=1:Ne
        YN(1:NoX,:) = bsxfun(@plus,Y(1:NoX,ii),sqrt(sigma2X)*randn(NoX,Ne));
        YN(NoX+1:No,:) = bsxfun(@plus,Y(NoX+1:No,ii),sqrt(sigma2Y)*randn(NoY,Ne));
        X(:,jj) = X(:,jj) + K*(YN(:,jj) - H*X(:,jj));
    end
    % Store EnKF analysis mean
    XM(:,ii) = mean(X,2);
end


load('True_Forecast_Error_Cov.mat')
Ny = 360;
K=36;
a=10; % must be even (or change code)
Nx = Ny/a;
N = Nx + Ny;
% distance matrix
s = [1:Ny (5.5 + 10*(0:K-1))]; % spatial locations
dis = zeros(N);
for jj=1:N
    for ii=1:N
        d = min([abs(s(ii)-s(jj)), abs(s(ii)+Ny-s(jj)), abs(s(ii)-Ny-s(jj))]);
        dis(ii,jj) = d;
    end
end
corr_mat2 = mean(corr_mat(:,:,2001:3000), 3);
% YY correlations
Cy = zeros(Ny, Ny/a);
ind=0;
for ii = a/2:a:Ny
    ind = ind +1;
    Cy(:, ind) = corr_mat2([ii:Ny, 1:ii-1] , ii);
end
Cy = mean(Cy, 2);
Cy2 = Cy([Ny-49:Ny, 1:51]);

% XX correlations
Cx = zeros(Nx);
for ii = 1:Nx
    Cx(:, ii) = corr_mat2([Ny+ii:N, Ny+1:Ny+ii-1] , Ny+ii);
end
Cx = mean(Cx, 2);
Cx2 = Cx([Nx-4:Nx, 1:6]);

% XY correlations
Cxy = zeros(Ny,Nx);
for ii = 1:Nx
    Cxy(:, ii) = corr_mat2([(1+a*(ii-1)):Ny, 1:a*(ii-1)], Ny+ii);
end
Cxy = mean(Cxy, 2);
test = 0.5 + [0:Ny-1];
test2 = test([Ny-49:Ny, 1:50]);
Cxy2 = Cxy([Ny-49:Ny, 1:50]);

% YX correlations
Cyx = zeros(Nx, Nx);
ind=0;
for ii = a/2:a:Ny
    ind = ind +1;
    Cyx(:,ind) = corr_mat2([Ny+ind:N, Ny+1:Ny+ind-1], ii);    
end
Cyx = mean(Cyx, 2);
Cyx2 = Cyx([Nx-5:Nx, 1:6]);

Dyx = zeros(Nx, Nx);
ind=0;
for ii = a/2:a:Ny
    ind = ind +1;
    Dyx(:,ind) = dis([Ny+ind:N, Ny+1:Ny+ind-1], ii);    
end
Dyx = mean(Dyx, 2);
Dyx2 = Dyx([Nx-5:Nx, 1:6]);



plot([-50:50], Cy2, [-5:5]*10, Cx2, -0.5+[-49:50], Cxy2, 0.5+10*[-6:5], Cyx2, 'LineWidth', 3)
ylim([-0.2, 0.2])
xlim([-50, 50])
legend({'Cov$(Y_{5, k_1}, Y_{j, k_2})$','Cov$(X_{k_1}, X_{k_2})$',... 
        'Cov$(X_{k_1}, Y_{j, k_2})$', 'Cov$(Y_{5, k_1}, X_{k_2})$'}, 'Interpreter', 'latex')
xlabel('Distance')
ylabel('Correlation')
title('True Forecast Error Correlation')
set(gca, 'FontSize', 18)
saveas(gcf, 'fig03.png')


% load('./Data/True_Forecast_Error_Cov.mat')
% 
% rmsY = squeeze(sqrt(mean((XT(1:Ny,:)  - XM(1:Ny,:)).^2))) ;
% rmsX = squeeze(sqrt(mean((XT(Ny+1:N,:)- XM(Ny+1:N,:)).^2))) ;
% plot(T(Nt/2+1:end), rmsY(Nt/2+1:end), T(Nt/2+1:end), rmsX(Nt/2+1:end)) ;
% legend('Y', 'X')
% 
% figure
% plot(dY(1:floor(length(dY)/2)), mean( CY(1:floor(length(dY)/2), Nt/2+1:Nt), 2), 'LineWidth', 2 )
% hold on
% plot(dXY(1:floor(length(dXY)/2)), mean( CXY(1:floor(length(dXY)/2), Nt/2+1:Nt), 2), 'LineWidth', 2 )
% plot(dYX(1:floor(length(dYX)/2)), mean( CYX(1:floor(length(dYX)/2), Nt/2+1:Nt), 2), 'LineWidth', 2 )
% plot(dX(1:floor(length(dX)/2)), mean( CX(1:floor(length(dX)/2), Nt/2+1:Nt), 2), 'LineWidth', 2 )
% legend('Y', 'XY', 'YX', 'X')
% title('True Forecast Error Correlation')
% set(gca, 'FontSize', 14)
% hold off
% saveas(gcf, './Plots/for_err_cor_full_h_2_directional.png')
% 
% figure
% plot(dY(1:floor(length(dY)/2)), mean( CY(1:floor(length(dY)/2), Nt/2+1:Nt), 2), 'LineWidth', 2 )
% hold on
% plot(dXY(1:floor(length(dXY)/2)), mean( CXY(1:floor(length(dXY)/2), Nt/2+1:Nt), 2), 'LineWidth', 2 )
% plot(dYX(1:floor(length(dYX)/2)), mean( CYX(1:floor(length(dYX)/2), Nt/2+1:Nt), 2), 'LineWidth', 2 )
% plot(dX(1:floor(length(dX)/2)), mean( CX(1:floor(length(dX)/2), Nt/2+1:Nt), 2), 'LineWidth', 2 )
% %plot(linspace(0, 60), 0.05.*ones(100,1), '--', 'Color', 'k', 'LineWidth', 2)
% %plot(linspace(0, 60), -0.05.*ones(100,1), '--', 'Color', 'k', 'LineWidth', 2 )
% legend('Y', 'XY', 'YX', 'X')
% title('True Forecast Error Correlation')
% xlabel('Distance')
% ylabel('Correlation')
% set(gca, 'FontSize', 14)
% hold off
% ylim([-0.2, 0.2])
% xlim([0, 60])
% saveas(gcf, './Plots/for_err_cor.png')

    
    