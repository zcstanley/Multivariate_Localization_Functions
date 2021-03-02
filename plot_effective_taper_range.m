%% Plot cross correlation at lag-zero
k2 = 3;
nu = 2; 
muX = 0:10;
muY = 0;
%muXY = 1/2.*(muY + muX/(k2));
bXY_A = sqrt( (k2).^(-nu) .* ( beta(nu, 1/2.*(muY + muX./(k2))+1).^2 ./ (beta(nu, muX+1).*beta(nu, muY+1)) ) ) ; 
nu = 3; 
muX = 0:10;
%muY = 0;
%muXY = 1/2.*(muY + muX/(k2));
bXY_W = sqrt( (k2).^(-nu-2) .* ( beta(nu+2, 1/2.*(muY + muX./(k2))+1).^2 ./ (beta(nu+2, muX+1).*beta(nu+2, muY+1)) ) ) ;

plot(0:10, bXY_A, 0:10, bXY_W, 'LineWidth', 3)
legend('Askey', 'Wendland')
ylabel('Maximum cross-localization weight, $\beta_{\max}$', 'Interpreter', 'latex')
xlabel('$\gamma_{XX}$', 'Interpreter', 'latex')
set(gca, 'FontSize', 18)

%% Plot effective taper range
% Find distance at which cross localization is 0.
% Askey effective distance
locFun = 'Askey'; 
dis = linspace(0, 20, 1000);
cY = 15;
cX = 45;
cXY = min(cX, cY);
nu = 2 ;
muY = 0;
edist_A = zeros(11,1);
for muX = 0:10 
muXY = 1/2.*(muY + muX./(cX/cY));
bXY = sqrt( (cXY^2 / (cX*cY))^(nu) * ( beta(nu, muXY+1)^2 / (beta(nu, muX+1)*beta(nu, muY+1)) ) ) ;
% XY
B = bXY; 
c = cXY; 
mu = muXY; 
locParams = struct('c', c, 'nu', nu, 'mu', mu, 'B', B);
locXY_A = feval(locFun, dis, locParams); 
plot(dis, locXY_A, dis, 0.05.* ones(size(dis)) )

% find first place where localization drops below 0.05
these = (locXY_A < 0.05);
first = find(these, 1, 'first');
effective = dis(first);
edist_A(muX+1) = effective;
end

% Wendland effective distance
locFun = 'Wendland'; 
dis = linspace(0, 20, 1000);
cY = 15;
cX = 45;
cXY = min(cX, cY);
muY = 0;
nu = 3 ;
k = 1;
muY = 0;
edist_W = zeros(11,1);
for muX = 0:10 
muXY = 1/2.*(muY + muX./(cX/cY));
bXY = sqrt( (cXY^2 / (cX*cY))^(nu+2) * ( beta(nu+2, muXY+1)^2 / (beta(nu+2, muX+1)*beta(nu+2, muY+1)) ) ) ;% XY
B = bXY; 
c = cXY; 
mu = muXY; 
locParams = struct('c', c, 'nu', nu, 'mu', mu, 'k', k, 'B', B);
locXY_W = feval(locFun, dis, locParams); 

% find first place where localization drops below 0.05
these = (locXY_W < 0.05);
first = find(these, 1, 'first');
effective = dis(first);
edist_W(muX+1) = effective;
end

% Askey cross-localization weight
k2 = 3;
nu = 2; 
muX = 0:10;
muY = 0;
%muXY = 1/2.*(muY + muX/(k2));
bXY_A = sqrt( (k2).^(-nu) .* ( beta(nu, 1/2.*(muY + muX./(k2))+1).^2 ./ (beta(nu, muX+1).*beta(nu, muY+1)) ) ) ; 

% Wendland cross-localization weight
k2 = 3;
nu = 3; 
muX = 0:10;
muY = 0;
%muXY = 1/2.*(muY + muX/(k2));
bXY_W = sqrt( (k2).^(-nu-2) .* ( beta(nu+2, 1/2.*(muY + muX./(k2))+1).^2 ./ (beta(nu+2, muX+1).*beta(nu+2, muY+1)) ) ) ;


figure
hold on
% Askey
yyaxis right
plot(muX, edist_A, muX, edist_W,'LineWidth', 3)
ylabel('Effective cross-localization radius')
yyaxis left
plot(muX, bXY_A, muX, bXY_W,'LineWidth', 3)  
ylabel('Maximum cross-localization weight, $\beta_{\max}$', 'Interpreter', 'latex')
legend('Askey', 'Wendland', 'Askey', 'Wendland', 'Location', 'southeast')
xlabel('$\gamma_{XX}$', 'Interpreter', 'latex')
set(gca, 'FontSize', 18)
hold off
%saveas(gcf, '../Plots/coloc_coeff_effective_range_A_W.png')
%saveas(gcf, '../Plots/crossloc_weight_effective_range_A_W.png')


%% increasing nu
% Plot effective taper range
% Find distance at which cross localization is 0.
% Askey effective distance
locFun = 'Askey'; 
dis = linspace(0, 20, 1000);
cY = 15;
cX = 45;
cXY = min(cX, cY);
muY = 0;
muX = 1;
muXY = 1/2.*(muY + muX./(cX/cY));
edist_A = zeros(9,1);
for nu = 2:10 
bXY = sqrt( (cXY^2 / (cX*cY))^(nu) * ( beta(nu, muXY+1)^2 / (beta(nu, muX+1)*beta(nu, muY+1)) ) ) ;
% XY
B = bXY; 
c = cXY; 
mu = muXY; 
locParams = struct('c', c, 'nu', nu, 'mu', mu, 'B', B);
locXY_A = feval(locFun, dis, locParams); 
plot(dis, locXY_A, dis, 0.05.* ones(size(dis)) )

% find first place where localization drops below 0.05
these = (locXY_A < 0.05);
first = find(these, 1, 'first');
effective = dis(first);
edist_A(nu-1) = effective;
end

% Wendland effective distance
locFun = 'Wendland'; 
dis = linspace(0, 20, 1000);
cY = 15;
cX = 45;
cXY = min(cX, cY);
k = 1;
muY = 0;
muX = 5;
muXY = 1/2.*(muY + muX./(cX/cY));
edist_W = zeros(8,1);
for nu = 3:10 
bXY = sqrt( (cXY^2 / (cX*cY))^(nu+2) * ( beta(nu+2, muXY+1)^2 / (beta(nu+2, muX+1)*beta(nu+2, muY+1)) ) ) ;% XY
B = bXY; 
c = cXY; 
mu = muXY; 
locParams = struct('c', c, 'nu', nu, 'mu', mu, 'k', k, 'B', B);
locXY_W = feval(locFun, dis, locParams); 

% find first place where localization drops below 0.05
these = (locXY_W < 0.05);
first = find(these, 1, 'first');
effective = dis(first);
edist_W(nu-2) = effective;
end

% Askey cross-localization weight
k2 = 3;
nu = 2:10; 
muX = 0;
muY = 0;
%muXY = 1/2.*(muY + muX/(k2));
bXY_A = sqrt( (k2).^(-nu) .* ( beta(nu, 1/2.*(muY + muX./(k2))+1).^2 ./ (beta(nu, muX+1).*beta(nu, muY+1)) ) ) ; 

% Wendland cross localization weight
k2 = 3;
nu = 3:10; 
muX = 5;
muY = 0;
%muXY = 1/2.*(muY + muX/(k2));
bXY_W = sqrt( (k2).^(-nu-2) .* ( beta(nu+2, 1/2.*(muY + muX./(k2))+1).^2 ./ (beta(nu+2, muX+1).*beta(nu+2, muY+1)) ) ) ;


figure
hold on
% Askey
yyaxis right
plot([2:10] - 1, edist_A,'LineWidth', 3) % shifted notation to align with Daley et al
plot([3:10] - 1, edist_W, 'LineWidth', 3) % shifted notation to align with Daley et al
ylabel('Effective cross-localization radius')
yyaxis left
plot([2:10] - 1, bXY_A,'LineWidth', 3)  % shifted notation to align with Daley et al
plot([3:10] - 1 , bXY_W,'LineWidth', 3) % shifted notation to align with Daley et al
ylabel('Maximum cross-localization weight, $\beta_{\max}$', 'Interpreter', 'latex')
legend('Askey', 'Wendland', 'Askey', 'Wendland', 'Location', 'northeast')
xlabel('$\nu$', 'Interpreter', 'latex')
set(gca, 'FontSize', 18)
xlim([1, 9])
hold off
%saveas(gcf, '../Plots/coloc_coeff_effective_range_A_W_nu.png')
%saveas(gcf, '../Plots/crossloc_weight_effective_range_A_W_nu.png')
%saveas(gcf, '../Plots/figB4.png')


