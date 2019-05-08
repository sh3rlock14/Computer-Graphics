%%
X = load_off('meshes/cat0.off');


% plot_mesh(M)
% axis equal;
% shading interp;

%myStiffness = stiffnessMatrix(M.VERT,M.TRIV,'conformal','verb');

M = massMatrixProf(X);
S = stiffMatrixProf(X);

%Laplace-Beltrami operator
L = inv(M)*S;

