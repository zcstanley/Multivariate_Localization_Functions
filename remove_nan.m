function [RMSE, len] = remove_nan(RMSE, start)
% Removes nans and outliers from vector
%
% INPUTS:
% RMSE = vector of errors
% start = first index to use in analysis
%
% OUTPUTS:
% RMSE = vector with no nans and outliers removed
% len = length of RMSE vector
%
% Author: Zofia Stanley

RMSE = RMSE(:, start:end);              % remove spin up
RMSE = RMSE(~isnan(RMSE(:, end)), :);   % remove nans
RMSE = sort(RMSE(:));                   % sort
height = length(RMSE);
RMSE = RMSE(floor(0.005*height):floor(0.995*height));   % extract inner 99% of data
len = length(RMSE);                     % save length

end