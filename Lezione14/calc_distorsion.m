function distorsione = calc_distorsion(X,Y)
%CALC_DISTORSION Summary of this function goes here
% INPUT
%     X: è una shape caricata con la funzione load_off()
%     Y: è una shape caricata con la funzione load_off()
%     assumo che sia nota la corrispondenza tra X e Y
%     e che il vertice i_esimo di X sia in corrispondenza
%     col vertice i_eismo di Y

% OUTPUT
%     il valore della distorsione tra le due shapes


%matice nx3 contenente tutti i vertici di X
vertX = X.VERT;
%matice nx3 contenente tutti i vertici di Y
vertY = Y.VERT;

% calcolo le distanze punto punto sui vertici delle 
% singole mesh

%inizializzo a zero un vettore della dimesone
% pari al numero di vertici nelle due shape (che considero di pari vertici)
distorsione = zeros(1,size(vertX,1));

%per ogni vertice
for i = size(vertX,1)
    %calcolo la distanza di un vertice da TUTTI gli altri sulla mesh X
    dX = pdist2(vertX(i,:), vertX);
    dY = pdist2(vertY(i,:),vertY);

%applico la definizione di distorsione nota la corrispondenza tra punti
%sto calcolando la massima distorsione del primo punto per le 2 mesh
% devo calcolarla per tutti gli altri punti
    distorsione(i) = max((abs(dX-dY)));

end
    
    %tra tutte le distorsioni prendo la più grnade
    %mi sono assicurato prima che fossero prese in valore assoluto
    distorsione = max(distorsione);
end
