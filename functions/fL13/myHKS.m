function [hks] = myHKS(X,v,time)

% per shapes con poci punti (tipo Wolf)
% v:= #autofunzioni in base

[X.S, ~, X.M] = calc_LB_FEM(X);
[X.phi, X.lambda] = eigs(X.S,X.M, v, 'sm');
[X.lambda, idx] = sort(diag(X.lambda));
X.phi = X.phi(:,idx);


%% costruisco l'heat kernel

hks = zeros(X.n,time); %sulla colonna i_esima avrò la digonale dell'Heat Kernel a tempo 'i'

colors = hot(200);
colors = colors(end:-1:1,:);

figure, colormap(colors)
for t=1:time
    %%%%%%% VERSIONE SEMPLICE, MA SPRECO MEMORIA %%%%%%%%
    K = X.phi * spdiag(exp(X.lambda*-t)) * X.phi';
%     prendo il valore dell'heat kernel che misura lo scmabio di calore da
%     un punto "verso se stesso"
    hks(:,t)  = diag(K); % heat kernel signature
 
    plot_mesh(X,hks(:,t)); axis equal; axis off; shading interp;
    colorbar
    %caxis([0 1e-2]);
    title(t)
    drawnow

end


end