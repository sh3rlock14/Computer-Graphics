function cluster = vicino(p, S)
% @param p: è una terna di valori 
% @param S: è una matrice n x 3
% la funzione ritorna il punto in S (l'indice del punto in S) più vicino a p
p = double(p);
% creo tante copie dl punto quante sono gli elementi Seed
matCopia = repelem(p(1,:),length(S),1);

matDiff  = matCopia - S;

% inizializzo un vettore per salvare le distanze normate tra p e gli altri
% Seed
DistanzeNormate = zeros(length(S),1);

% calcolo la distanza colore tra p e gli elementi in S
for i=1:length(matDiff)
    DistanzeNormate(i) = norm(matDiff(i,:));
end

% il valore della distanza non mi interessa, voglio sapere
% quale sia il cluster in S
[~,I] = min(DistanzeNormate);

% restituisco l'indice del cluster tra i Seed per il punto p
cluster = I;
end