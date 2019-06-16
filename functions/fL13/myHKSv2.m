function hks = myHKSv2(X,v,time)

% v:= #autofunzioni in base
if (v==1)
    v = 2;
end


[X.S, ~, X.M] = calc_LB_FEM(X);
[X.phi, X.lambda] = eigs(X.S,X.M, v, 'sm');
[X.lambda, idx] = sort(diag(X.lambda));
X.phi = X.phi(:,idx);
X.lambda = X.lambda(2:end,:);
X.phi = X.phi(:,2:end);

%% costruisco la matrice che ospiterà l'HKS

hks = zeros(X.n,time); %sulla colonna i_esima avrò la digonale dell'Heat Kernel a tempo 'i'

% customizzo la hot come visto in classe
colors = hot(200);
colors = colors(end:-1:1,:);


Xt = X.phi';
%l'accesso e la trasposizione in contemporanea non credo si possa fare
%(MATLAB stava dando problemi: ho risolto creando una matrice PHI già
%trasposta)


%% CALCOLO HKS PER TUTTI I PUNTI, PER TUTTI I TEMPI 
for t=1:time % per ogni istante di tempo
    for p=1:X.n % per ogni punto della shape
        hks(p,t) = X.phi(p,:) * spdiag(exp(X.lambda*-t)) * Xt(:,p);
    end
end



%% visualizzazione di prova, senza fissare i limiti -> la cMap cresce velocemente
% figure, colormap(colors)
% 
% for t=1:time
%     plot_mesh(X,hks(:,t)); axis equal; axis off; shading interp;
%     colorbar
%     title(t)
%     drawnow
%    
% end



%% ORA VISUALIZZO HKS SULLA MESH 
figure, colormap(jet(50))

for t=1:time
%     hks(:,t) = (hks(:,t) - min(hks(:,t)) ./ (max(hks(:,t) - min(hks(:,t)))));
    minn = min(hks(:,time));
    maxx = max(hks(:,time));
    plot_mesh(X,hks(:,t)); axis equal; axis off; shading interp;
    colorbar
    caxis([minn maxx]); % in questo modo la cMap si assesta
    title(t)
    drawnow
   
end

end