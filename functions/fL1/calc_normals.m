function outputArg1= calc(M)
%CALC Summary of this function goes here
%   Detailed explanation goes here
    e12 = M.VERT(M.TRIV(:,2),:) - M.VERT(M.TRIV(:,1),:);
    e13 = M.VERT(M.TRIV(:,3),:) - M.VERT(M.TRIV(:,1),:);
    n = cross(e12,e13); 
    n = spdiag(1./sqrt(sum(n.^2,2)))*n;


outputArg1 = n;

end

