function M = fuseMeshes(M_1,M_2)
%FUSEMESHES Summary of this function goes here
%   Detailed explanation goes here

%prendo il punto più a destra della PRIMA SHAPE
maxDx = max(M_1.VERT(:,1));
%prendo il punto più a sinistra della SECONDA SHAPE
minSx = min(M_2.VERT(:,1));

%sposto a destra la seconda shape di 20 units, rispetto
% al punto più a destra della prima.
M_2.VERT(:,1) = M_2.VERT(:,1) + maxDx - abs(minSx) +2; 

%devo aggiornare i riferimenti ai triangoli
M_2.TRIV(:,1) = M_2.TRIV(:,1) + M_1.n;
M_2.TRIV(:,2) = M_2.TRIV(:,2) + M_1.n;
M_2.TRIV(:,3) = M_2.TRIV(:,3) + M_1.n;


M.VERT = [M_1.VERT; M_2.VERT];
M.TRIV = [M_1.TRIV; M_2.TRIV];
M.n = M_1.n + M_2.n;
M.m = M_1.m + M_2.m;


end

