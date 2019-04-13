k = 10;

% genero una matrice d'adiacenza per descrivere la connettività (topologia) dei vertici
% @param k: lato della griglia (nb: non conosco la sua posizone nello spazio)
% @out boundary_idx: sono gli indexes dei vertici che stanno sul bordo
% @out: boundary_xyz: sono vincoli prescritti in posizione "a quadrato"
[TRIV,A,boundary_xyz,boundary_idx]  = create_grid_topology(k);

n = size(A,1);

boundary_n = length(boundaty_idx);

% creo il Laplaciano del Grafo 
% matrice di adiancenza A pesata
% ho un 1 nella posizione dell'ancora
% tante righe quante ancore
% qui le ancore sono i vertici del bordo
L = speye(n) - spdiag(1./sum(A,2))*A;
H = sparse(1:boundary_n, bpundary_idx,1,boundaty_n,n);

% devo risolvere il sistema lineare con:
VERT_ls = [L;H] \ [zeros(n,3); boundary_xyz]; % provo a pesare e scrivo 100*H


%%

%{      per l'Handler creato dal prof
quando eseguo il drag&drop, non sto modificando i vincoli, ([L;H]), ma sto semplicemente cambiando le posizioni 
dei punti
%}