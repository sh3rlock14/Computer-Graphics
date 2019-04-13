%%

%Decomposizione di Voronoi

%M = load_off('../Lezione1/meshes/cat0.off.txt');

% uso una mesh diversa
M = load_off('./meshes/dog10.off');

% fps devo implementarla
% @param2: sono 100 campioni fps
samples = fps(M.VERT, 100);        



% devo implementare plot_cloud - SUCCESSO
plot_cloud(M,samples,'r*');
axis equal
%shading interp
title('fps on mesh')

% calcolo le regioni di voronoi

% calcolo il minimo all'interno della matrice nella dimensione 2 
% il valore non mi interessa, mi interessa sapere solo l'indice

%[~,voronoi] = min(pdist2(M.VERT, M.VERT(samples,:)),[],2);

% questa funziona (quella sopra no)

[~,voronoi] = min(pdist2(M.VERT, samples),[],2);



figure,
plot_mesh(M,voronoi);
axis equal
shading flat
hold on
%each mesh line segment and face has a constant color determined
% by the color value at the endpoint of the segment or the corner of the face
%that has the smallest index or indices.


