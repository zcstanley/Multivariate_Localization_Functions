%% Produces Figure 4 from Stanley et al. (2021)
% Load output produced from scripts 
% observe_x_save_output and observe_x_and_y_save_output
%
% Author: Zofia Stanley

load('Data/observe_x.mat') 
load('Data/observe_x_and_y.mat')
addpath('violin/')
title_str1 = 'Observe only the long process';
title_str2 = 'Observe both processes';
savename = 'Plots/obs_gc_Ne50.png';
start = 1001;

% Define colors
oxford_blue = [12, 27, 49]./256;
maximum_green = [77, 139, 49]./256;
rich_black = [8, 18, 33]./256;
xcolors = [oxford_blue; oxford_blue;  maximum_green;];
ycolors = oxford_blue;

%% Observe X, no Y
% 1A. RMSE X
RMSE_X_XnoY_UVGC = RMSE_X_XnoY_UVGC(:, start:end);
RMSE_X_XnoY_WCGC = RMSE_X_XnoY_WCGC(:, start:end);
RMSE_X_XnoY_MVGC = RMSE_X_XnoY_MVGC(:, start:end);

RMSE_X_full = [sort(RMSE_X_XnoY_UVGC(:)), sort(RMSE_X_XnoY_WCGC(:)), sort(RMSE_X_XnoY_MVGC(:))];
height = size(RMSE_X_full, 1);
RMSE_X_XnoY = RMSE_X_full(floor(0.005*height):floor(0.995*height), :);
      
xlab = {'UV GC', 'MV GC', 'WC GC'};
line1 = {'\textrm{Univariate}', '\textrm{Weakly Coupled}', '\textrm{Multivariate}'};
line2 = {'\textrm{Gaspari-Cohn}', '\textrm{Gaspari-Cohn}', '\textrm{Gaspari-Cohn}'};
for iXTick = 1:length(line1)
	xlab{iXTick} = ['$$\begin{array}{r}' ...
                    line1{iXTick} '\\'...
                    line2{iXTick} '\\'...
                    '\end{array}$$'];
end


% 1B. RMSE Y
RMSE_Y_XnoY_UVGC = RMSE_Y_XnoY_UVGC(:, start:end);
RMSE_Y_XnoY_WCGC = RMSE_Y_XnoY_WCGC(:, start:end);
RMSE_Y_XnoY_MVGC = RMSE_Y_XnoY_MVGC(:, start:end);


RMSE_Y_full = [sort(RMSE_Y_XnoY_UVGC(:)), sort(RMSE_Y_XnoY_WCGC(:)), sort(RMSE_Y_XnoY_MVGC(:))];
height = size(RMSE_Y_full, 1);
RMSE_Y_XnoY = RMSE_Y_full(floor(0.005*height):floor(0.995*height), :);

%% Observe Both X and Y
% 2A. RMSE X, remove nans
[RMSE_X_BothXY_UVGC, len_UV] = remove_nan(RMSE_X_BothXY_UVGC, start);
[RMSE_X_BothXY_WCGC, len_WC] = remove_nan(RMSE_X_BothXY_WCGC, start);
[RMSE_X_BothXY_MVGC, len_MV] = remove_nan(RMSE_X_BothXY_MVGC, start);

% Concatenate
len = max([len_UV, len_MV, len_WC]);
RMSE_X_BothXY = NaN(len, 3);
RMSE_X_BothXY(1:len_UV, 1) = RMSE_X_BothXY_UVGC;
RMSE_X_BothXY(1:len_WC, 2) = RMSE_X_BothXY_WCGC;
RMSE_X_BothXY(1:len_MV, 3) = RMSE_X_BothXY_MVGC;

% 2B. RMSE Y, remove nans
[RMSE_Y_BothXY_UVGC, len_UV] = remove_nan(RMSE_Y_BothXY_UVGC, start);
[RMSE_Y_BothXY_WCGC, len_WC] = remove_nan(RMSE_Y_BothXY_WCGC, start);
[RMSE_Y_BothXY_MVGC, len_MV] = remove_nan(RMSE_Y_BothXY_MVGC, start);

% Concatenate
len = max([len_UV, len_MV, len_WC]);
RMSE_Y_BothXY = NaN(len, 3);
RMSE_Y_BothXY(1:len_UV, 1) = RMSE_Y_BothXY_UVGC;
RMSE_Y_BothXY(1:len_WC, 2) = RMSE_Y_BothXY_WCGC;
RMSE_Y_BothXY(1:len_MV, 3) = RMSE_Y_BothXY_MVGC;

%% Make Plots

% X only, RMSE X
figure
subplot(2,2,1)
[h1, L1] = violin(RMSE_X_XnoY, 'facecolor', ycolors, 'facealpha', 0.7, 'edgecolor', rich_black, ...
               'mc', '', 'medc', rich_black);
%set(L1,  'Position', [0.72 0.8840 0.1081 0.0275])
set(L1, 'Location', 'northeast')
ylabel('RMSE X', 'Interpreter', 'latex')
title(title_str1, 'Interpreter', 'latex', 'Color', rich_black)
set(gca, 'FontSize', 18,'XTick',1:length(xlab),'XTickLabel','', ...
         'TickLabelInterpreter','latex', 'Xcolor', rich_black,...
         'Ycolor', rich_black, 'box', 'off');

% Both X and Y, RMSE X
subplot(2,2,2)
[h2, L2] = violin(RMSE_X_BothXY, 'facecolor', ycolors, 'facealpha', 0.7, 'edgecolor', rich_black, ...
               'mc', '', 'medc', rich_black);
set(L2, 'Location', 'northeast')
ylabel('RMSE X', 'Interpreter', 'latex')
title(title_str2, 'Interpreter', 'latex', 'Color', rich_black)
set(gca, 'FontSize', 18,'XTick',1:length(xlab),'XTickLabel','', ...
         'TickLabelInterpreter','latex', 'Xcolor', rich_black,...
         'Ycolor', rich_black, 'box', 'off');

% X only, RMSE Y
subplot(2,2,3)
violin(RMSE_Y_XnoY, 'facecolor', ycolors, 'facealpha', 0.7, 'edgecolors', rich_black, ... 
               'mc', '', 'medc', rich_black, 'plotlegend', 0);
ylabel('RMSE Y', 'Interpreter', 'latex')
set(gca, 'FontSize', 18,'XTick',1:length(xlab),'XTickLabel',xlab,...
         'TickLabelInterpreter','latex', 'Xcolor', rich_black,...
         'Ycolor', rich_black, 'box', 'off');
set(gcf, 'Position',  [100, 100, 800, 800])
xtickangle(50)

% Both X and Y, RMSE Y
subplot(2,2,4)
violin(RMSE_Y_BothXY, 'facecolor', ycolors, 'facealpha', 0.7, 'edgecolors', rich_black, ... 
               'mc', '', 'medc', rich_black, 'plotlegend', 0);
ylabel('RMSE Y', 'Interpreter', 'latex')
set(gca, 'FontSize', 18,'XTick',1:length(xlab),'XTickLabel',xlab,...
         'TickLabelInterpreter','latex', 'Xcolor', rich_black,...
         'Ycolor', rich_black, 'box', 'off');
set(gcf, 'Position',  [100, 100, 800, 800])
xtickangle(50)

saveas(gcf, savename)
