%% Plot functions: Askey
locFun = 'Askey'; 
dis =-50:50;
cY = 15;
cX = 45;
cXY = min(cX, cY);
muY = 0;
muX = 1;
muXY = 1/2.*(muY + muX./(cX/cY));
nu = 2 ;
bXY = sqrt( (cXY^2 / (cX*cY))^(nu) * ( beta(nu, muXY+1)^2 / (beta(nu, muX+1)*beta(nu, muY+1)) ) ) ;
% YY
B = 1; 
c = cY; 
mu = muY; 
locParams = struct('c', c, 'nu', nu, 'mu', mu, 'B', B);
locY_A = feval(locFun, dis, locParams); 
% XX
B = 1; 
c = cX; 
mu = muX; 
locParams = struct('c', c, 'nu', nu, 'mu', mu, 'B', B);
locX_A = feval(locFun, dis, locParams); 
% XY
B = bXY; 
c = cXY; 
mu = muXY; 
locParams = struct('c', c, 'nu', nu, 'mu', mu, 'B', B);
locXY_A = feval(locFun, dis, locParams); 

figure
plot(dis, locY_A, dis, locX_A, dis, locXY_A, 'LineWidth', 2) 
title('Askey')
legend('YY',  'XX', 'XY') 
xlabel('Distance')
set(gca, 'FontSize', 12)
%saveas(gcf, '../Plots/Fun_Askey.png')

%% Plot functions: Wendland

locFun = 'Wendland'; 
dis = -50:50;
cY = 15;
cX = 45;
cXY = min(cX, cY);
muY = 0;
muX = 5;
muXY = 1/2.*(muY + muX./(cX/cY));
nu = 3 ;
k = 1;
bXY = sqrt( (cXY^2 / (cX*cY))^(nu+2) * ( beta(nu+2, muXY+1)^2 / (beta(nu+2, muX+1)*beta(nu+2, muY+1)) ) ) ;
% YY
B = 1; 
c = cY; 
mu = muY; 
locParams = struct('c', c, 'nu', nu, 'mu', mu, 'k', k, 'B', B);
locY_W = feval(locFun, dis, locParams); 
% XX
B = 1; 
c = cX; 
mu = muX; 
locParams = struct('c', c, 'nu', nu, 'mu', mu, 'k', k, 'B', B);
locX_W = feval(locFun, dis, locParams); 
% XY
B = bXY; 
c = cXY; 
mu = muXY; 
locParams = struct('c', c, 'nu', nu, 'mu', mu, 'k', k, 'B', B);
locXY_W = feval(locFun, dis, locParams); 

figure
plot(dis, locY_W, dis, locX_W, dis, locXY_W, 'LineWidth', 2)
legend('YY', 'XX', 'XY')
title('Wendland')
xlabel('Distance')
set(gca, 'FontSize', 12)
%saveas(gcf, '../Plots/Fun_Wendland.png')

%% Plot functions: Gaspari-Cohn

locFun = 'GC'; 
dis = -50:50;
cY = 15;
cX = 45;
cXY = 0.5 *(cX+cY);
bXY = (5/2)*(cY/cX)^(3/2) - (3/2)*(cY/cX)^(5/2) ; 
% YY
B = 1; 
c = cY/2; 
locParams = struct( 'c', c, 'B', B);
locY_GC = feval(locFun, dis, locParams); 
% XX
B = 1; 
c = cX/2; 
locParams = struct( 'c', c, 'B', B);
locX_GC = feval(locFun, dis, locParams); 
% XY
B = bXY; 
c = cXY/2; 
locParams = struct( 'c', c, 'B', B);
locXY_GC = feval(locFun, dis, locParams); 

figure
plot(dis, locY_GC, dis, locX_GC, dis, locXY_GC, 'LineWidth', 2)
legend('YY', 'XX', 'XY')
title('Gaspari-Cohn')
xlabel('Distance')
set(gca, 'FontSize', 12)
ylim([0,1])
%saveas(gcf, '../Plots/Fun_GC.png')

%% Plot functions: BW

locFun = 'bolin_wallin_3d'; 
dis = -50:50;
cY = 15;
cX = 45;
cXY = 0.5 *(cX+cY);
bXY = (min(cX, cY)/ max(cX, cY))^(3/2); 
% YY
B = 1; 
c = cY/2; 
locParams = struct('rad1', c*ones(size(dis)), 'rad2', c*ones(size(dis)), 'B', B);
locY_BW = feval(locFun, abs(dis), locParams); 
% XX
B = 1; 
c = cX/2; 
locParams = struct('rad1', c*ones(size(dis)), 'rad2', c*ones(size(dis)), 'B', B);
locX_BW = feval(locFun, abs(dis), locParams); 
% XY
B = bXY; 
c = cXY/2; 
locParams = struct('rad1', c*ones(size(dis)), 'rad2', c*ones(size(dis)), 'B', B);
locXY_BW = feval(locFun, abs(dis), locParams); 

figure
plot(dis, locY_BW, dis, locX_BW, dis, locXY_BW, 'LineWidth', 2)
legend('YY', 'XX', 'XY')
title('Bolin-Wallin')
xlabel('Distance')
set(gca, 'FontSize', 12)
ylim([0,1])
%saveas(gcf, '../Plots/Fun_BW_3d.png')

% Plot YY functions together
figure
plot(dis, locY_GC, dis, locY_BW, dis, locY_A, dis, locY_W, 'LineWidth', 5)
legend('Gaspari-Cohn', 'Bolin-Wallin', 'Askey', 'Wendland')
title('$\mathcal{L}_{YY}$', 'Interpreter', 'latex')
xlabel('Distance')
ylim([0,1])
xlim([-49, 49])
set(gca, 'FontSize', 20, 'LineWidth', 2)
%saveas(gcf, '../Plots/L_YY.png')
%saveas(gcf, '../Plots/Fun_YY.png')

% Plot XX functions together
figure
plot(dis, locX_GC, dis, locX_BW, dis, locX_A, dis, locX_W, 'LineWidth', 5)
legend('Gaspari-Cohn', 'Bolin-Wallin', 'Askey', 'Wendland')
title('$\mathcal{L}_{XX}$', 'Interpreter', 'latex')
xlabel('Distance')
set(gca, 'FontSize', 20, 'LineWidth', 2)
ylim([0,1])
xlim([-49, 49])
%saveas(gcf, '../Plots/L_XX.png')
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
%saveas(gcf, '../Plots/L_XY.png')
%saveas(gcf, '../Plots/Fun_XY.png')


