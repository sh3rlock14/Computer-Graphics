function newSeeds = myKmeans(punti,nbins)

% ho una matrice di colori ridotta, la cui lunghezza è pari al numero di
% bins richiesti
bins = zeros(nbins,3);

% è il numero di pixel nell'immagine
nPixel = length(punti); 

% è il numero di elementi interni a ciascun settore con cui ho diviso l'immagine
lenSector = nPixel/nbins;   

% utilizzo una variabile d'appoggio per scorrere i settori della matrice
pointer = 1;

% per ciascun bin ...
for i=1 : nbins
% ...genero un indice in [1,lenSector]
    % diminuisco di uno perché ho già il valore 1 in pointer -- potrei
    % sbagliare
    index = randi(lenSector-1); 
    % inserisco tra i miei bins uno dei punti interni al settore che sto
    % considerando
    bins(i,:) = punti(pointer+index,:);
    % devo spostare il puntatore per considerare il nuovo settore
    pointer = pointer + lenSector;
end

% qui ho creato l'insieme S





%MYKMEANS Summary of this function goes here
%{
    n = punti;
    k = nb;  è il numero di cluster

  Given a set of n points X in R3, implement the following algorithm:

1) Select a set of k < n points S in R3 (seed).
        Note: the selected points are not necessarily from X.

2) For each point in X, nd its nearest neighbor in S.
The result is k clusters of points.

3) For each cluster K, compute its centroid as c = 1/|k| Sum_i(x_i)

4) Replace S with the k centroids.

5) Repeat from 2 until converge.
%}

%{
    idea:
    1) dai "punti" individuo len(punti)/bins settori
    2) da ogni settore estraggo un punto: sarà uno dei miei bins
    3) per ogni punto trovo il bins più vicino
    4) i bins sono un k-cluster dei punti originali
%}

% calcolo una prima volta i centroidi 
newSeeds = kMnearestNeighbor(punti, bins);
%itero kmeans per un tot di volte e calcolo nuovi centroidi
%{
for repeat=1:2
    newSeeds = kMnearestNeighbor(punti, newSeeds);
end
%}
end

