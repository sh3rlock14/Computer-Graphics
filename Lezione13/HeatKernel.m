%%
clear all
close all
clc

dataset = './meshes/';

X = load_off(sprintf('%s/wolf0.off', dataset));

p = 224;%3000;

% pi� vettori in base considero, pi� mi avicino all'Heat Kernel, meno ne
% prendo, pi� la soluzione a cui arrivo � approssimata
k = 100;

[X.S, ~, X.M] = calc_LB_FEM(X);
[X.phi, X.lambda] = eigs(X.S,X.M, k, 'sm');
[X.lambda, idx] = sort(diag(X.lambda));
X.phi = X.phi(:,idx);


%% costruisco l'heat kernel

colors = hot(200);
colors = colors(end:-1:1,:);

figure, colormap(colors)
for t =1:1:500
% t � un valore arbitrario, ma poich� � un valore che moltiplica gli
% autovalori all'esponente, e gli autovalori sono proporzionali alla
% superficie, il tempo di diffusione dipende da quanto � vasta la
% superficie

% @n: numero di vertici della shape 
% heat kernel ha dimensioni (n x n)

%%%%%%%%%%%%%%%%%%%%%%%     PARTE DUBBIA     %%%%%%%%%%%%%%%%%%%%%%%
% se devo isolarmi solo i valori per m vertici, tronco le
% autofunzioni (NON IN NUMERO; MA PER LUNGHEZZA ???)
%%%%%%%%%%%%%%%%%%%%%%%                      %%%%%%%%%%%%%%%%%%%%%%%


    K = X.phi * spdiag(exp(X.lambda*-t)) * X.phi';


%% voglio visualizzare l'heat kernel da un punto 'p' a tutti gli altri

    k  = K(p,:);    % mi basta selezionare la riga che fa riferimento al vertice 'p';
%                   in realt� anche la colonna: l'Heat Kernel � simmetrico

    plot_mesh(X,k); axis equal; axis off; shading interp;
    colorbar
    caxis([0 1e-2]);
    drawnow
end