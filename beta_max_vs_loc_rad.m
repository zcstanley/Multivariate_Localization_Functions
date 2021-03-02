%% Plot maximum cross-localization weight factor (beta_max)
% as a function of kappa^2 = R_XX/R_YY

% kappa^2 = R_XX/R_YY
k2 = linspace(1,5); 

% beta_max for Gaspari-Cohn and Bolin-Wallin
bXY_GC = (5/2).*(k2).^(-3/2) - (3/2).*(k2).^(-5/2) ;
bXY_BW_3D = k2.^(-3/2);

% beta_max for Askey
nu = 1; 
gammaXX = 1;
gammaYY = 0;
%gammaXY = 1/2.*(muY + muX/(k2));
bXY_A = sqrt( (k2).^(-(nu+1)) .* ( beta(nu+1, 1/2.*(gammaYY + gammaXX./(k2))+1).^2 ./ (beta(nu+1, gammaXX+1)*beta(nu+1, gammaYY+1)) ) ) ; 

% beta_max for Wendland
nu = 2; 
gammaXX = 5;
gammaYY = 0;
%gammaXY = 1/2.*(muY + muX/(k2));
bXY_W = sqrt( (k2).^(-(nu+3)) .* ( beta(nu+3, 1/2.*(gammaYY + gammaXX./(k2))+1).^2 ./ (beta(nu+3, gammaXX+1)*beta(nu+3, gammaYY+1)) ) ) ;

% plot maximum cross-localization weight factor
figure
plot(k2, bXY_GC, k2, bXY_BW_3D, k2, bXY_A, k2, bXY_W, 'LineWidth', 3)
legend('Gaspari-Cohn', 'Bolin-Wallin', 'Askey', 'Wendland')
ylabel('Maximum cross-localization weight, $\beta_{\max}$', 'Interpreter', 'Latex')
xlabel('$R_{XX}/ R_{YY}$', 'Interpreter', 'latex')
set(gca, 'FontSize', 18)
%saveas(gcf, '../Plots/4functions_bXY_cY_cX.png')