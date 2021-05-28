function s = set_up_spatial_locations(x_position, params, Ny, Nx)
% This function sets up the spatial locations for the state variables
% The implemented options are:
%   middle : X is in the middle of the sector associated with it
%   first : X is colocated with the first Y variable in the sector
%
% INPUTS:
% x_position is a string, either 'middle', or 'first'
% params is a struct containing parameters of the bivariate Lorenz 96 model
% Ny is the number of Y state variables
% Nx is the number of X state variables
% 
% OUTPUT:
% s = spatial locations

switch x_position
    case 'middle' 
        s = [1:Ny ((params.J + 1)/2 + params.J*(0:Nx-1))];
    case 'first'
        s = [1:Ny (1 + params.J*(0:Nx-1))];
    otherwise
        warning('Unexpected x position. Expected middle or first. No spatial location array created.')
end

end