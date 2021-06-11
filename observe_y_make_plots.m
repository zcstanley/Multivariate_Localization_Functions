%% Produces Figure 3 from Stanley et al. (2021)
% Load output produced from script observe_y_save_output
%
% Author: Zofia Stanley

%% Load output produced from script observe_y_save_output
load('Data/observe_y.mat') 
addpath('violin/')
title_str = 'Observe only the short process';
savename = 'Plots/obs_y_primary.png';
start = 1001;

% colors
oxford_blue = [12, 27, 49]./256;
maximum_green = [77, 139, 49]./256;
rich_black = [8, 18, 33]./256;
xcolors = [oxford_blue; maximum_green; oxford_blue; oxford_blue;... 
           oxford_blue; oxford_blue; oxford_blue; oxford_blue; ];
ycolors = oxford_blue;

% 1. RMSE X
RMSE_X_YnoX_UVGC = RMSE_X_YnoX_UVGC(:, start:end);
RMSE_X_YnoX_MVGC = RMSE_X_YnoX_MVGC(:, start:end);
RMSE_X_YnoX_UVBW = RMSE_X_YnoX_UVBW(:, start:end);
RMSE_X_YnoX_MVBW = RMSE_X_YnoX_MVBW(:, start:end);
RMSE_X_YnoX_UVA = RMSE_X_YnoX_UVA(:, start:end);
RMSE_X_YnoX_MVA = RMSE_X_YnoX_MVA(:, start:end);
RMSE_X_YnoX_UVW = RMSE_X_YnoX_UVW(:, start:end);
RMSE_X_YnoX_MVW = RMSE_X_YnoX_MVW(:, start:end);

RMSE_X_full = [sort(RMSE_X_YnoX_UVGC(:)), sort(RMSE_X_YnoX_MVGC(:)), ...
          sort(RMSE_X_YnoX_UVBW(:)), sort(RMSE_X_YnoX_MVBW(:)), ...
          sort(RMSE_X_YnoX_UVA(:)),  sort(RMSE_X_YnoX_MVA(:)), ...
          sort(RMSE_X_YnoX_UVW(:)),  sort(RMSE_X_YnoX_MVW(:))];
height = size(RMSE_X_full, 1);
RMSE_X = RMSE_X_full(1+floor(0.005*height):floor(0.995*height), :);
      
xlab = {'UV GC', 'MV GC', 'UV BW', 'MV BW', 'UV A', 'MV A', 'UV W', 'MV W'};
line1 = {'\textrm{Univariate}', '\textrm{Multivariate}',... 
         '\textrm{Univariate}', '\textrm{Multivariate}',...
         '\textrm{Univariate}', '\textrm{Multivariate}',...
         '\textrm{Univariate}', '\textrm{Multivariate}'};
line2 = {'\textrm{Gaspari-Cohn}', '\textrm{Gaspari-Cohn}',... 
         '\textrm{Bolin-Wallin}', '\textrm{Bolin-Wallin}',... 
         '\textrm{Aksey}', '\textrm{Askey}',... 
         '\textrm{Wendland}', '\textrm{Wendland}'};
for iXTick = 1:length(line1)
	xlab{iXTick} = ['$$\begin{array}{r}' ...
                    line1{iXTick} '\\'...
                    line2{iXTick} '\\'...
                    '\end{array}$$'];
end


% 2. RMSE Y
RMSE_Y_YnoX_UVGC = RMSE_Y_YnoX_UVGC(:, start:end);
RMSE_Y_YnoX_MVGC = RMSE_Y_YnoX_MVGC(:, start:end);
RMSE_Y_YnoX_UVBW = RMSE_Y_YnoX_UVBW(:, start:end);
RMSE_Y_YnoX_MVBW = RMSE_Y_YnoX_MVBW(:, start:end);
RMSE_Y_YnoX_UVA = RMSE_Y_YnoX_UVA(:, start:end);
RMSE_Y_YnoX_MVA = RMSE_Y_YnoX_MVA(:, start:end);
RMSE_Y_YnoX_UVW = RMSE_Y_YnoX_UVW(:, start:end);
RMSE_Y_YnoX_MVW = RMSE_Y_YnoX_MVW(:, start:end);

RMSE_Y_full = [sort(RMSE_Y_YnoX_UVGC(:)), sort(RMSE_Y_YnoX_MVGC(:)), ...
          sort(RMSE_Y_YnoX_UVBW(:)), sort(RMSE_Y_YnoX_MVBW(:)), ...
          sort(RMSE_Y_YnoX_UVA(:)),  sort(RMSE_Y_YnoX_MVA(:)), ...
          sort(RMSE_Y_YnoX_UVW(:)),  sort(RMSE_Y_YnoX_MVW(:))];
height = size(RMSE_Y_full, 1);
RMSE_Y = RMSE_Y_full(floor(0.005*height):floor(0.995*height), :);

% Make Plots

figure
subplot(2,1,1)
[h1, L1] = violin(RMSE_X, 'facecolor', xcolors, 'facealpha', 0.7, 'edgecolor', rich_black, ...
               'mc', '', 'medc', rich_black);
%set(L1,  'Position', [0.72 0.8840 0.1081 0.0275])
set(L1, 'Location', 'best')
ylabel('RMSE X', 'Interpreter', 'latex')
title(title_str, 'Interpreter', 'latex', 'Color', rich_black)
set(gca, 'FontSize', 18,'XTick',1:length(xlab),'XTickLabel','', ...
         'TickLabelInterpreter','latex', 'Xcolor', rich_black,...
         'Ycolor', rich_black, 'box', 'off');

subplot(2,1,2)
[h2, L2] = violin(RMSE_Y, 'facecolor', ycolors, 'facealpha', 0.7, 'edgecolors', rich_black, ... 
               'mc', '', 'medc', rich_black, 'plotlegend', 0);
set(L2,  'Position', [0.72 0.4104 0.1081 0.0275])
ylabel('RMSE Y', 'Interpreter', 'latex')
set(gca, 'FontSize', 18,'XTick',1:length(xlab),'XTickLabel',xlab,...
         'TickLabelInterpreter','latex', 'Xcolor', rich_black,...
         'Ycolor', rich_black, 'box', 'off');
set(gcf, 'Position',  [100, 100, 800, 800])
xtickangle(50)

saveas(gcf, savename)

