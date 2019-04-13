function dist = distEuclid(M)
%DISTEUCLID 
%   Devo ritornare una lista contenente le media delle sommatoria della 
%   distanza euclidea per un punto dagli altri punti

nVertici = size(M.VERT,1);    % mi salvo quanti sono i Punti (vertici) della shape    

dist = zeros(nVertici,1);

for vectorI=1:nVertici        % devo calcolare la distanza tra vettori di ogni vettore
    diff = 0;                 % inizializzo la sommatoria delle distanze dal punto i a tutti gli altri a zero
    for vectorJ=1:nVertici   % devo considerare ciascun vettore
         %diff = diff + sqrt( dot( (M.VERT(vectorI,:) - M.VERT(vectorJ,:)),(M.VERT(vectorI,:) - M.VERT(vectorJ,:))) );    % aggiorno la distanza da ciascun punto
         diff = diff + norm(M.VERT(vectorJ,:) - M.VERT(vectorI,:));
    end
    diff = diff/nVertici;
    dist(vectorI) = diff;     % aggiorno il vettore delle distanze per ciscun punto della mesh
end
    %dist(i,:) = vertcat(dist,computeEuDist(M.VERT(i,:),M));
    
end


