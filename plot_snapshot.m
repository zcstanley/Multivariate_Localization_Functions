%% Plot one snapshot of bivariate Lorenz 96 process

%% Set up parameters
params = struct('K',36,'J',10,'F',10,'a',10,'b',10,'h',2);
Nx = params.K;
Ny = params.K*params.J;
N = params.K*(params.J+1); % Total number of dependent variables
Nt = 3000; % Number of assimilation cycles
dtObs = 0.005; % Time between assimilation cycles
Ne = 20; % Ensemble size
s = [1:Ny (5.5 + 10*(0:params.K-1))]; % spatial locations

%% Compute the true solution
[T,XT] = ode45(@(t,y) RHS_L96(t,y,params),[0 linspace(10,10+Nt*dtObs,Nt)],randn(N,1));
XT = XT(2:end,:)'; T = T(2:end);

%% Plot snapshot of L96 process
r = 180/pi;
sang = pi .* s ./ 180;
sx = r.* cos(sang);
sy = r.* sin(sang);
sz = XT(:, 1113);

% Define colors
ycolor = [16, 36, 66]./256;
xcolor = [42, 120, 122]./256;

plot3(sx([Ny+1:N,Ny+1]), sy([Ny+1:N, Ny+1]), sz([Ny+1:N, Ny+1]), '--.',... 
      'Color', xcolor, 'LineWidth', 3, 'MarkerSize', 18)
hold on
plot3(sx([1:Ny, 1]), sy([1:Ny,1]), sz([1:Ny,1]), '-', 'Color', ycolor, 'LineWidth', 3)
zlabel('$X_k, Y_{j,k}$', 'Interpreter', 'latex')
xlim([-60, 60])
ylim([-60, 60])
legend({'$X$', '$Y$'}, 'Interpreter', 'latex')
set(gca, 'FontSize', 18)
hold off
saveas(gcf, 'Plots/L96_circle_snapshot.png')
