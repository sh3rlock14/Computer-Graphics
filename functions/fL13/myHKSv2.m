function hks = myHKSv2(X,v,time)

% v:= #autofunzioni in base

[X.S, ~, X.M] = calc_LB_FEM(X);
[X.phi, X.lambda] = eigs(X.S,X.M, v, 'sm');
[X.lambda, idx] = sort(diag(X.lambda));
X.phi = X.phi(:,idx);


%% costruisco l'heat kernel

hks = zeros(X.n,time); %sulla colonna i_esima avrò la digonale dell'Heat Kernel a tempo 'i'

% provo la colormap jet invece di quella customizzata
colors = hot(200);
colors = colors(end:-1:1,:);

Xt = X.phi';




%%%%%%%%%%%%%% CALCOLO HKS PER TUTTI I PUNTI, PER TUTTI I TEMPI %%%%%%%%%%%
for t=1:time % per ogni istante di tempo
    for p=1:X.n % per ogni punto della shape
        hks(p,t) = X.phi(p,:) * spdiag(exp(X.lambda*-t)) * Xt(:,p);
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%% ORA VISUALIZZO HKS SULLA MESH %%%%%%%%%%%%%%%%%%%%%
figure, colormap(jet)

for t=1:time
    
    plot_mesh(X,hks(:,t)); axis equal; axis off; shading interp;
    colorbar
    %caxis([0 1e-2]);
    drawnow

end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




end