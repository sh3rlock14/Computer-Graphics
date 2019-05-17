%%
% Voglio l'immagine come nuvola di punti di colore -> la nuvola esiste
% nelle 3 dimensoni (una per colore)
I = imread('./images/ralph.png');


% coordinate

r = I(:,:,1);
r = r(:);

g = I(:,:,2);
g = g(:);

b = I(:,:,3);
b = b(:);

rgb = [r,g,b];

% visualizzo come una nuvola di punti
% i 3 assi rappresentano ciscun un canale r/g/b

figure('Name', 'Ralph''s Colours'),
subplot(2,1,1), imshow(I)               % stampo l'immagine originale

subplot(2,2,3), plot3(r,g,b,'r.')       % converte tutti i punti-colore in rosso
title('Punti Colore in Rosso')
axis equal

subplot(2,2,4), scatter3(r, g, b, 20, double(rgb)./255,'fill')  % dimensione, colore, opzioni % matlab vuole i colori in 0 e 1 
xlabel('red')
ylabel('green')
zlabel('blue')
title('Punti Colore')


%%

% produco l'istogramma 3D
% voglio raccogliere i punti colori in n bin: i punti vengono raccolti in
% modo tale che nello stesso bin ci finiscono colori simili


%{
                            k-means CLSTERING

k-means clustering, or Lloyd?s algorithm, is an iterative, data-partitioning
algorithm that assigns n observations to exactly one of k clusters
defined by centroids, where k is chosen before the algorithm starts.

%}

%{
        ----- [idx,C,sumd] = kmeans(X,k) -----
Returns the within-cluster sums of point-to-centroid distances in the k-by-1 vector sumd.

INPUT DATA

X: data
k: numbers of clusters into which the algo divides data

OUTPUT DATA

idx: Cluster indices, returned as a numeric column vector. idx has as many rows as X,
        and each row indicates the cluster assignment of the corresponding observation.

C: Cluster centroid locations, returned as a numeric matrix.
        C is a k-by-p matrix, where row j is the centroid of cluster j.

sumd: Within-cluster sums of point-to-centroid distances, returned as a numeric column vector.
        sumd is a k-by-1 vector, where element j is the sum of point-to-centroid distances within cluster j.


%}


n = 20;    % numero di bin
[~,c,s] = kmeans(double(rgb), n); % kmeans(dati in input, quanti gruppi fare)

% Visualizzo l'istogramma


figure,
scatter3( c(:,1), c(:,2), c(:,3), s*1e-4, c./255,'filled')
% displays circles at the locations specified by the vectors X, Y, and Z,
% di dimensione S, colore, opzioni
% diviso per 255 perchè matlab vuole i colori in [0,1]
                                                          
axis equal
xlabel('r')
ylabel('g')
zlabel('b')