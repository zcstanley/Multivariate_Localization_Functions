%% Produces the right panel of Figure 2 from Stanley et al. (2021)
% Plot one snapshot of bivariate Lorenz 96 process
%
% Author: Zofia Stanley

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
xcolor = [145, 47, 64]./256;

% Plot
plot3(sx([Ny+1:N,Ny+1]), sy([Ny+1:N, Ny+1]), sz([Ny+1:N, Ny+1]), '--.',... 
      'Color', xcolor, 'LineWidth', 6, 'MarkerSize', 36)
hold on
plot3(sx([1:Ny, 1]), sy([1:Ny,1]), sz([1:Ny,1]), '-', 'Color', ycolor, 'LineWidth', 6)
zlabel('$X_k, Y_{j,k}$', 'Interpreter', 'latex', 'Color', ycolor)
xlim([-58, 58])
ylim([-58, 58])
zlim([-2, 6.5])
L=legend({'$X$', '$Y$'}, 'Interpreter', 'latex', 'box', 'off', 'Location', 'best', 'TextColor', ycolor);
L.ItemTokenSize = [75,18];
set(gca, 'FontSize', 40, 'LineWidth', 2)
set(gca,'TickLabelInterpreter','latex', 'Xcolor', ycolor,...
         'Ycolor', ycolor, 'box', 'off');
hold off
saveas(gcf, 'Plots/L96_circle_snapshot.png')
