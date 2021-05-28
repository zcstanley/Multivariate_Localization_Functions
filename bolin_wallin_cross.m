function loc = bolin_wallin_cross(dis, cY, cX)
% Bolin & Wallin cross-localization
%
% INPUTS:
% dis = distance (matrix)
% cY = localization radius for process Y / 2 = kernel radius (scalar)
% cX = localization radius for process X / 2 = kernel radius (scalar)
%
% OUTPUT:
% loc = localization matrix

dis = abs(dis);

% Order kernel radii
cmin = min(cY, cX);
cmax = max(cY, cX);

% Define functions

% This function calculates the volume of spherical cap with triangular height 
% x of a sphere with radius r
calculate_volume_spherical_cap = @(x, c) (pi/3) .* (c - x).^2 .* (2*c + x);

% This function calculates the volume of the lens.
calculate_volume_lens = @(d, cmax, cmin) calculate_volume_spherical_cap((d.^2 + cmax^2 - cmin^2)./(2.*d), cmax) + ...
                                         calculate_volume_spherical_cap((d.^2 + cmin^2 - cmax^2)./(2.*d), cmin); 

% Calculate volume of intersection
vol = zeros(size(dis)) ;

% Define different regions of intersection
one_sphere = dis <= (cmax - cmin) ;
one_lens = ( dis > (cmax - cmin) ) & ( dis < (cmax + cmin) ) ;

% if one circle is fully contained in the other the area of intersection is
% the area of the smaller circle. 
vol(one_sphere) = (4/3) * pi * cmin^ 3 ;
    
% if neither circle is fully in the other and the area of intersection is
% nonzero, the volume of intersection is the volume of a lens
vol(one_lens) = calculate_volume_lens(dis(one_lens), cmax, cmin) ;

% Finally, calculate the normalized volume
loc = vol ./ ( (4/3) * pi * cmin^(3/2) * cmax^(3/2)) ; 

end