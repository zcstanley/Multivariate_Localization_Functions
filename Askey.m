function rho = Askey(d, params)
% Askey localization; Roh et al. (9)
c = params.c;
nu = params.nu;
mu = params.mu;
B = params.B;

rho = B .* ( max( (1 - abs(d)./c), 0 ) ) .^ (nu+mu) ;

end