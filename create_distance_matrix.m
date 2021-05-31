function dis = create_distance_matrix(spatial_locations, Ny)
% This function forms a distance matrix for a periodic domain
%
% INPUTS:
% spatial_locations is an array 
% Ny is the size of the periodic domain
%
% OUTPUT:
% dis = distance matrix

% check lengths
N = length(spatial_locations); 

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

end