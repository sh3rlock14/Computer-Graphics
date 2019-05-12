%%
X = load_off('./meshes/david1.off');

%%
plot_mesh(X);
shading interp;
axis equal;
axis off;
%%

[X.S,~,X.M] = calc_LB_FEM(X);

%calcolo il Laplaciano
L = X.M\X.S;

[X.phi, X.lambda] = eigs(X.S, X.M, 100, 'sm');
%%
%metto gli autovalori in una colonna (sono ordinati in ordine NON DECRESCENTE)
X.lambda = diag(X.lambda);

%%
%calcolo l'HKS

hks = HKS(X.phi, X.lambda);


%%
figure
for i=10:10:30
    subplot(1,3,i/10), plot_mesh(X,hks(:,i)); shading interp; axis off; axis equal;
end