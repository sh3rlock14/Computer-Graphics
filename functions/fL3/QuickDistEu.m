function vettDist = QuickDistEu(M)
    
    M = (M.VERT)';
    nVertici = size(M,2);      % mi salvo quanti sono i Punti (vertici) della shape
    vettDist = zeros(nVertici,1);   % è il mio vettore dei f(xi) , for ALL i
    
    
    for j=1:nVertici
        % creo una copia 1 x size(A,2), ovvero tanti quanti sono i vettori
        matCopia = repelem(M(:,j),1,size(M,2));
        % è la matrce che salverà le differenze tra i punti della shape con il punto su cui sto iterando
        matDiff =  sum(sqrt(sum((M - matCopia).^2)))/nVertici; 
        vettDist(j) = matDiff;  
    end