function A = calcolaArea(M)

%calcola l'area di ogni triangolo all'interno di una mesh

%calcolo il numero di triangoli
n = size(M.TRIV,1);
A = zeros(n,1);

for i=1:n
         %[M.VERT(riga i, prima componente (x)) M.VERT(riga i, seconda componente (y))  
    W = [M.VERT(M.TRIV(i,1),1) M.VERT(M.TRIV(i,1),2) 1;...
        M.VERT(M.TRIV(i,2),1) M.VERT(M.TRIV(i,2),2) 1;...
        M.VERT(M.TRIV(i,3),1) M.VERT(M.TRIV(i,3),2) 1];

    A(i) = (W)*0.5;

end