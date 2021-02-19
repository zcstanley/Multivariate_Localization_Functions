function rho = Wendland(d, params)
% Wendland localization; Daley et al. (2015)

% get parameters
c = params.c;
nu = params.nu;
mu = params.mu;
k = params.k;
B = params.B;

% rescale with localization radius
x = abs(d)./c ;
near = x <=1 ;
rho = zeros(size(x)) ;

% Use symbolic integration to find univariate Wendland function
syms u t

% do symbolic integration the minimum number of times required
% most applications use only a handful of distinct values of nu and mu
% compared to much larger distance matrix d.
vals = unique(nu+mu) ;
for vv = 1:length(vals)
    nu_mu = vals(vv) ;
    W(t) = int( (u.^2 - t.^2).^k .* (1 - u).^(nu_mu - 1), u, t, 1 ) / beta(2*k + 1, nu_mu);
    
    these = (nu+mu == nu_mu)  & near ;
    rho(these) = W(x(these)) ;
end

rho = rho .* B;
end

