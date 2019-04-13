function adj = vertAdj(M)
%VERTADJ Summary of this function goes here
%   la funzione restituisce una matrice di adiacenza per vertici
%   presenti all'interno di una mesh poligonale
    adj = sparse(...
        [M.TRIV(:,1) ; M.TRIV(:,2); M.TRIV(:,3); M.TRIV(:,1) ; M.TRIV(:,2); M.TRIV(:,3)],... 
        [M.TRIV(:,2) ; M.TRIV(:,3); M.TRIV(:,1); M.TRIV(:,3) ; M.TRIV(:,1); M.TRIV(:,2)], ...
        1, M.n, M.n);

    % quest'operazione serve perché alcuni valori 
    % sono maggiori di 1
    adj(adj>1) = 1;


end

