function [Ny, Nx, N, NoY, NoX, No] = derived_parameters(params, Frac_Obs_Y, Frac_Obs_X)
% Derives dependent parameters from independent ones for EnKF
%
% INPUTS: 
% params is a struct containing parameters for the bivariate Lorenz 96 model
% Frac_Obs_Y is the fraction of Y variables that are observed
% Frac_Obs_X is the fraction of X variables that are observed
%
% OUTPUTS:
% Ny is the number of state variables in the Y process
% Nx is the number of state variables in the X process
% N is the total number of state variables
% NoY is the number of observarions of Y
% NoX is the number of observations of X
% No is the number of obs per cycle
%
% Author: Zofia Stanley

% Number of state variables
Nx = params.K ;
Ny = params.K * params.J ;
N = params.K * ( params.J + 1 ) ; 

% Number of observations
NoY = floor( Frac_Obs_Y * Ny ) ;
NoX = floor( Frac_Obs_X * Nx ) ;
No = NoX + NoY ; 

end