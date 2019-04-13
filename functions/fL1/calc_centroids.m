function outputArg1 = calc_centroids(M)
%UNTITLED2 Summary of this function goes here
%  itero lungo la matrice contenente i triangoli, riga per riga considero
% i valori di TRIV (puntatori alla riga di VERT)
    
    %centroids = zeros(M.m);  % inizializzo il vettore che stiperà i centroidi
    centroids = [];
    [m] = size(M.TRIV);
    for r=1 : m
        for c=1 : 1
            v1 = M.TRIV(r,c);       % ho l'indice del primo vertice 
            v2 = M.TRIV(r, c+1);    % ho l'indice del secondo vertice 
            v3 = M.TRIV(r, c+2);    % ho l'indice del terzo vertice
            % devo calcolare le coordinate del centroide del triangolo
            centroide = centroid(M,v1,v2,v3);
            centroids(r,:) = centroide;
        end
    end
outputArg1 = centroids;

end

