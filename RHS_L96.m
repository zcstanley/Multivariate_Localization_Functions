function OUT = RHS_L96(~,IN,p)
% Computes RHS for two-layer L-96 model
% Inputs:
%   p   struct with fields F, h, a, b, K, and J
%   IN  IN(k*(1:J)) are the Y_{j,k} variables for k=1:K
%       IN(K*J+1:K*(J+1)) are the X_k variables
% Output:
%   OUT RHS computed as follows
%   dX/dt =-X_{k-1}*(X_{k-2}-X_{k+1}) - X_k - (h*a/b)*sum_{j=1}^J Y_{j,k} + F
%   dY/dt =a*(-b*Y_{j+1,k}*(Y_{j+2,k}-Y_{j-1,k}) - Y_{j,k} +(h/b)*X_k)
%
% Author: Ian Grooms
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
y = IN(1:p.K*p.J);
Y = reshape(y,[p.J p.K]);
X = IN(p.K*p.J+1:p.K*(p.J+1));

%% dX/dt
OUT = zeros(size(IN));
OUT(p.K*p.J+1:p.K*(p.J+1)) = -circshift(X,1).*(circshift(X,2)-circshift(X,-1))...
                             -X - (p.h*p.a/p.b)*sum(Y)' + p.F;

%% dY/dt
OUT(1:p.J*p.K)=-p.b*circshift(y,-1).*(circshift(y,-2)-circshift(y,1)) - y;
tmp = repmat(X,1,p.J)';
OUT(1:p.J*p.K)=OUT(1:p.J*p.K) + (p.h/p.b)*tmp(:);
OUT(1:p.J*p.K)=p.a*OUT(1:p.J*p.K);