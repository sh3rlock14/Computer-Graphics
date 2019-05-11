%%
X = load_off('meshes/cat0.off');

%%
% @X.M := mass matrix
% @X.S := stifness matrix
[X.S,~,X.M] = calc_LB_FEM(X); 

%%

%Laplacian Beltrami Operator 
L = inv(X.M)*X.S;

%%
[X.phi, X.lambda] = eigs(X.S,X.M, 50, 'sm');

%%
[X.lambda,idx] = sort(diag(X.lambda));


%%
% plot_mesh(M)
% axis equal;
% shading interp;



