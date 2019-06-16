function [hks] = myHKS(X,point,time)

[X.S, ~, X.M] = calc_LB_FEM(X);
[X.phi, X.lambda] = eigs(X.S,X.M, k, 'sm');
[X.lambda, idx] = sort(diag(X.lambda));
X.phi = X.phi(:,idx);


%% costruisco l'heat kernel

colors = hot(200);
colors = colors(end:-1:1,:);

figure, colormap(colors)
for t=1:time
    
    K = spdiag(X.phi * spdiag(exp(X.lambda*-t)) * X.phi');
    k  = diag(K);
    
    plot_mesh(X,k); axis equal; axis off; shading interp;
    colorbar
    caxis([0 1e-2]);
    drawnow

end


end