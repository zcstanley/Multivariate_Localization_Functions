% Plot true forecast error covariance 
load('True_Forecast_Error.mat')

plot([-50:50], Cyy, [-5:5]*10, Cxx, -0.5+[-49:50], Cxy, 0.5+10*[-6:5], Cyx, 'LineWidth', 3)
ylim([-0.2, 0.2])
xlim([-50, 50])
legend({'Cov$(Y_{5, k_1}, Y_{j, k_2})$','Cov$(X_{k_1}, X_{k_2})$',... 
        'Cov$(X_{k_1}, Y_{j, k_2})$', 'Cov$(Y_{5, k_1}, X_{k_2})$'}, 'Interpreter', 'latex')
xlabel('Distance')
ylabel('Correlation')
title('True Forecast Error Correlation')
set(gca, 'FontSize', 18)
%saveas(gcf, 'fig03.png')



    
    