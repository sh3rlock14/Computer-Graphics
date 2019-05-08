function [Sc,Sl] = massMatrixProf(M)

areas = calc_tri_areas(M);

indicesI = [M.TRIV(:,1);M.TRIV(:,2);M.TRIV(:,3);M.TRIV(:,3);M.TRIV(:,2);M.TRIV(:,1)];
indicesJ = [M.TRIV(:,2);M.TRIV(:,3);M.TRIV(:,1);M.TRIV(:,2);M.TRIV(:,1);M.TRIV(:,3)];
values   = [areas(:); areas(:); areas(:); areas(:); areas(:); areas(:)]./3;
Sc = sparse(indicesI, indicesJ, values, M.n, M.n);
Sc = Sc+sparse(1:M.n, 1:M.n, sum(Sc));

Sl = spdiag(sum(Sc,2));

end