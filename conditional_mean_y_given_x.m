%% Calculates RMSE for conditional mean of Y given X
%
% Author: Zofia Stanley

%% Compute the true solution
params = struct('K',36,'J',10,'F',10,'a',10,'b',10,'h',2);
Ny = params.K*params.J;
N = params.K*(params.J+1);      % Total number of dependent variables
Nt = 3000;                      % Number of assimilation cycles
dtObs = 0.005;                  % Time between assimilation cycles

% True solution
[T,XT] = ode45(@(t,y) RHS_L96(t,y,params),[0 linspace(10,10+Nt*dtObs,Nt)],randn(N,1));
XT = XT(2:end,:)'; T = T(2:end);
Y = XT(1:Ny, :);
X = repelem(XT(Ny+1:N, :), params.J, 1);

% Simple linear regression prediction
y = Y(:);
x = X(:);
b = x\y; 
ypred = b.*x; 

% RMSE
y_rmse = sqrt(mean(y.^2));
y_cond_rmse = sqrt(mean((y-ypred).^2));

% Plot
histogram2(x,y, 'DisplayStyle','tile')
hold on
plot(x, ypred, 'LineWidth', 2)
hold off

