%%
close all
clear all
clc


M = load_off('./meshes/cat0.off.txt');
%M = remesh(M,struct('vertices',5e3));

%{
figure,

plot_mesh(M,M.VERT(:,1))
axis equal
shading interp
caxis([0 50])
colorbar
%}

% calcolo le normali (per ogni triangolo) sulla superficie per "ingrassare il gatto"

n = calc_normals(M);

% voglio una matrice di adiacenza sparsa vertici-triangoli
% la riga i identifica il vertice "i"
% la colonna j il triangolo j

% per ogni vertice voglio la somma dei triangoli a cui appartiene  

P = sparse(M.TRIV(:),[1:M.m, 1:M.m, 1:M.m],1,M.n,M.m);

% ogni riga contiene normali sui vertici 
% implemento la somma delle normali di triangoli che insistono su un punto
n_v = P*n;
n_v = spdiag(1./sqrt(sum(n_v.^2,2)))*n_v;

figure, 

plot_mesh(M)
shading interp
axis equal
hold on
c = calc_centroids(M);

%quiver3(c(:,1), c(:,2), c(:,3),...
%    n(:,1),n(:,2),n(:,3));

quiver3(M.VERT(:,1), M.VERT(:,2), M.VERT(:,3),...
    n_v(:,1),n_v(:,2),n_v(:,3));


% Gonfio il cane
% ogni vertice è una posizione nello spazio, implemnto lo spostamento lungo
% il vettore con una somma tra vettori (punto e sua normale (normale pesata))

for a=0:0.01:1
    M.VERT = M.VERT + a*n_v;
    plot_mesh(M), shading interp
    light; lighting phong; camlight head;axis off
    drawnow
end


% Calcolo la distanza per ogni punto nella posizine attuale e la posizione
% originale

%{
N = M;
N.VERT = N.VERT + 0.2*n_v;
% calcolo la distanza in L3
errore = sum(abs(N.VERT - M.VERT).^3).^(1/3);
%}

% Voglio "stondare" il gatto (togliere gli spigoli) 

% costruisco la matrice adiacenza vert-vert
A = sparse(...
    [M.TRIV(:,1) ; M.TRIV(:,2); M.TRIV(:,3)],...
    [M.TRIV(:,2) ; M.TRIV(:,3); M.TRIV(:,1)], ...
    1, M.n, M.n);

% laplaciano
L = speye(M.n) - spdiag(1./sum(A,2))*A;

figure
for i=1:1000
    M.VERT = spdiag(1./sum(A,2))*A*M.VERT;
    %    FLUSSO DI CURVATURA MEDIA mediante Laplaciano
    % M.VERT = spdiag(1./sum(A,2))*A*M.VERT; -> M.VERT -a*L*M.VERT  
    % cioé: lo smoothing lo ottengo sottraendo ai vertici il loro laplaciano
    % @param a: è un peso 
    plot_mesh(M); shading interp
    light; lighting phong; camlight head;axis off
    drawnow
end
