%%
clear all
close all
clc

dataset = './meshes';

%% Calcola Shape DNA per tutte le shape nel dataset

shapes = dir(sprintf('%s/*.off', dataset));

k = 20;

%creo una matrice (length(shakpes)x k) di  "scalari" che rappresentino
%l'infinito (positivo)

all_dna = Inf(length(shapes), k);

for i=1:length(shapes)
    
    %scrivo quale figura sto processando
    fprintf('Shape %d/%d\n', i, length(shapes))
    
    %non tutte le shapes sono ben formate: devo prevedere alcuni errori
    %durante la procedura
    try
        X = load_off(sprintf('%s/%s', dataset, shapes(i).name));
        %calcolo le Matrici "Stiffness" e "Mass" 
        [X.S, ~, X.M] = calc_LB_FEM(X);
        
        % in eigs(A,B,...):
        % When B is specified, eigs solves the generalized eigenvalue problem A*V = B*V*D
        [~, dna] = eigs(X.S, X.M, k, 'sm');
        
        % per la i_esima shape, metto sull' i_esima riga i descrittori (colonna per colonna)
        % riordinati in ordine crescente
        all_dna(i,:) = sort(diag(dna));
    catch
        fprintf('Error with shape %s\n', shapes(i).name)
    end
    
end

%% Ranking per una query a caso

query_idx = randi(length(shapes));

% shapes ha di default una colonna di nome name, in cui sono memorizzati i
% nomi dei file caricati
Q = load_off(sprintf('%s/%s', dataset, shapes(query_idx).name));

% prendo i descrittori della shape di riferimento (presa comunque a caso)
query_dna = all_dna(query_idx,:);

% calcolo la distanza tra i descrittori della shape con i decrittori delle
% altre shapes
dist = pdist2(query_dna, all_dna);

% le riordino in ordine crescente:
%   valori bassi -> alta somiglianza 
%   valori altri -> bassa somiglianza

% ranking è un array, nella cella "i" è indicata la posizione nel riordinamento dell' i_esimo elemento 
[dist_sorted, ranking] = sort(dist);

figure
subplot(2,5,1), plot_mesh(Q); axis equal; shading interp; axis off; light; camlight head; lighting phong;
title('query')
for i=1:5
    X = load_off(sprintf('%s/%s', dataset, shapes(ranking(i+1)).name));
    subplot(2,5,5+i), plot_mesh(X); axis equal; shading interp; axis off; light; camlight head; lighting phong;
	title(sprintf('%d',i))
end