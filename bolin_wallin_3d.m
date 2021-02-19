function [norm_vol, vol] = bolin_wallin_3d(dist, locParams)
% This function calculates the volume of intersection of two spheres with
% centers d units apart, where one sphere has radius R and the other has
% radius r. 
%
% This function also calculates the normalized volume, which is the volume
% divided by 4/3 * pi * (R * r)^3. The normalization is chosen so that the 
% normalized volume of two colocated spheres (d=0) with the same radius 
% (R=r) is 1. 
%
% This function takes 3 scalars/vectors/matrices as inputs. The 3 inputs
% must have the same dimension. 
% (1) dist is the distance between the centers of the two circles
% (2) rad1 is the radius of one circle
% (3) rad2 is the radius of the other circle.
%
% EDIT: locParams now contains both rad1 and rad2 and B
%
% Hyperspherical tapers from Bolin and Wallin (2016), Section 2.1
% Note that there is an error in Bolin and Wallin, which is corrected here.
% B & W write pi * r^3/2 when they mean pi * r^3.
%
% Function defined in Bolin & Wallin (2016). Code written by Zofia Stanley.

%% 
rad1 = locParams.rad1;
rad2 = locParams.rad2;
B = locParams.B;

%% Define functions to calculate the area of intersection of two circles.

% This function calculates the area of spherical cap with triangular height 
% x of a sphere with radius r
V3 = @(r, x) (pi/3) .* (r - x).^2 .* (2.*r + x);

% This function calculates the area of the lens.
lens_cap = @(x, R, r) V3(R, (x.^2 + R.^2 - r.^2)./(2.*x)) + V3(r, (x.^2 + r.^2 - R.^2)./(2.*x)); 

%% Calculate area of intersection

% Define big and little radii. 
bigR = max(rad1, rad2) ;
lilR = min(rad1, rad2) ;

% Define different cases of intersection
zero_rad = ( lilR ==0 ) ;
one_circle = ( dist <= (bigR - lilR) ) & ~zero_rad ;
two_lens_caps = ( dist > (bigR - lilR) ) & ( dist < (bigR + lilR) ) & ~zero_rad ;
no_intersection = ( dist > (bigR + lilR) ) & ~zero_rad ;

vol = zeros(size(dist)) ;

% if one circle is fully contained in the other the area of intersection is
% the area of the smaller circle. 
vol(one_circle) = (4/3) .* pi .* lilR(one_circle) .^ 3 ;
    
% if neither circle is fully in the other and the area of intersection is
% nonzero, the area of intersection is the sum of two circular segements.
vol(two_lens_caps) = lens_cap(dist(two_lens_caps), bigR(two_lens_caps), lilR(two_lens_caps)) ;

% otherwise, the area of intersection is zero. 
vol(no_intersection) = 0 ;
vol(zero_rad) = 0 ;
    

%% Finally, calculate the normalized area
norm_vol = zeros(size(vol));
norm_vol(~zero_rad) = vol(~zero_rad) ./ ( (4/3) .* pi .* lilR(~zero_rad).^(3/2) .* bigR(~zero_rad).^(3/2)) ; 
norm_vol(zero_rad) = 0 ;

norm_vol = norm_vol .* B;

end