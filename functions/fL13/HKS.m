function [hks] = HKS(phi,lambda, A, scale)


%HKS Summary 
% INPUTS
%   evecs: ith each *column* in this matrix is the ith *eigenfunction* of the
%           Laplace Beltrami Operator 
%   evals: ith *element* in this vector is the ith *eigenvalue* of the Laplace
%           Beltrami operator
%   A:      ith element in this vector is the area assosciated with the ith
%           vertex
%   scale: if scale = true, output the scaled HKS
%           o.w. output the HKS not scaled
% 
% OUTPUTS
%   HKS: ith row in this matrix is the heat kernel signature of the ith
%           vertex


tmin = abs(4*log(10) /lambda(end));
tmax = abs(4*log(10) /lambda(2));
nstep = 100;

stepsize = (log(tmax) - log(tmin)) / nstep;
logts = log(tmin):stepsize:log(tmax);
ts = exp(logts);

% if nargin > 3 
%     if scale == true
%         hks = abs( phi(:,2:end) ) .^2 * exp( (abs(lambda(2)) - abs(lambda(2:end)) ) *ts);
%         Am = sparse([1:length(A)], [1:length(A)], A);
%         colsum = sum(Am*hks);
%         scale = 1.0./colsum;
%         scalem = sparse([1:length(scale)], [1:length(scale)], scale);
%         hks = hks * scalem;
%         return
%     end
% end

if nargin == 2
        hks = abs( phi(:,2:end) ).^2 * exp( - abs(lambda(2:end)) * ts);

    end

end

% note: calcolare i valori assoluti degli *eigenvalues* serve: sono tutti
% positivi ed escludendo il primo sono tutti strettamente positivi