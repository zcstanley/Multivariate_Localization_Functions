function loc = create_localization_matrix(spatial_locations, Ny, Nx, loc_fun_name, loc_params)
% This function forms a localization matrix
%
% INPUTS:
% spatial_locations is an array 
% Ny is the number of Y locations
% Nx is the number of X locations
% loc_fun_name is a string: 'gaspari_cohn', 'bolin_wallin', 'askey', 'wendland'
% params is a struct which holds localization parameters
%
% OUTPUT:
% loc = localization matrix

% check lengths
loc_params.Ny = Ny;
loc_params.Nx = Nx;
N = Ny + Nx;
assert(length(spatial_locations)==N, 'Number of spatial locations does not match expectations.')

% create distance matrix
dis = zeros(N);
for jj=1:N
    for ii=1:N
        d = min([abs(spatial_locations(ii)-spatial_locations(jj)), ...
                 Ny-abs(spatial_locations(ii)-spatial_locations(jj))]);
        delta_theta = pi * d / 180;
        dis(ii, jj) = (180 * sqrt(2) / pi) * sqrt(1 - cos(delta_theta));
    end
end

% create localization matrix
switch loc_fun_name
    case 'gaspari_cohn' 
        loc = gaspari_cohn(dis, loc_params);
    case 'bolin_wallin'
        loc = bolin_wallin(dis, loc_params);
    case 'askey'
        loc = askey(dis, loc_params);
    case 'wendland'
        loc = wendland(dis, loc_params);
    case 'no_loc'
        loc = ones(N);
    otherwise
        warning('Unexpected localization function name. No localization matrix created.')
end

end
