%% carico la priam shape del lupo
dataset = './meshes/';
X = load_off(sprintf('%s/wolf0.off', dataset));
% X = load_off(sprintf('%s/david1.off', dataset));

%% calcolo l'Heat Kernel Signature
hks = myHKS(X,1,1);
hks2 = myHKSv2(X,1,1);

%% visualizzo le porzioni del lupo 
areas = 2;

% in hks_areas ho i 2 centroidi 
% in idx ho, per ogni punto, l'informazioni a quale centroide il punto
% appartenga
[idx, hks_areas] = kmeans(hks, areas);

% calcolo per ogni indicatore qual è la distanza con i 2 centroidi
% poi prendo quella minima
% nota: in voronoi non viene riportata la distanza minima, ma l'indice che
% si riferisce alla distanza minima
[~, voronoi] = min(pdist2(hks, hks_areas),[],2);

figure, colormap(jet(2))
subplot(121), plot_mesh(X,idx); shading interp; axis equal; axis off
% subplot(122), plot_mesh(X,voronoi); shading interp; axis equal; axis off


%% visualizzo le porzioni del lupo con hks2

[idx2, hks_areas2] = kmeans(hks2, areas);

% [~, voronoi] = min(pdist2(hks, hks_areas),[],2)

figure, colormap(jet(areas))
plot_mesh(X,idx2)
shading interp; axis equal; axis off