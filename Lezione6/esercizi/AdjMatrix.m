%%
%{          QUESTA è UNA SESSIONE DI PROVA

%M = load_off('./meshes/tr_reg_000.off');
M.TRIV = [1 2 3;2 3 4];
M.n = 4;

adj = spalloc(4, 4, 1);

for i=1:2
    adj(M.TRIV(i,:), M.TRIV(i,:)) = 1;
end

adj = adj - diag(diag(adj))

%{

%QUESTA è LA MIA - Testata con SUCCESSO, implementata nella funzione vertAdj
A = sparse(...
    [M.TRIV(:,1) ; M.TRIV(:,2); M.TRIV(:,3); M.TRIV(:,1) ; M.TRIV(:,2); M.TRIV(:,3)],... 
    [M.TRIV(:,2) ; M.TRIV(:,3); M.TRIV(:,1); M.TRIV(:,3) ; M.TRIV(:,1); M.TRIV(:,2)], ...
    1, M.n, M.n);

% quest'operazione serve perché alcuni valori 
% sono maggiori di 1
A(A>1) = 1;
%}


A = vertAdj(M)

%QUESTA è LA VERSIONE DEL PROF
B = sparse(...
    [M.TRIV(:,1) ; M.TRIV(:,2); M.TRIV(:,3)],... 
    [M.TRIV(:,2) ; M.TRIV(:,3); M.TRIV(:,1)], ...
    1, M.n, M.n);

C = A - B;

D = A - adj; 



figure,
subplot(2,3,1), spy(A)
title("mia matrice")
subplot(2,3,2), spy(B)
title("matrice prof")
subplot(2,3,3), spy(C)
title("differenza mia - prof")
subplot(2,3,5), spy(adj)
title("steph")
subplot(2,3,6), spy(D)
title("differenza mia - steph")

%}

%%

% VERSIONCINA DEMO

A = sparse(1:5,1:5, ones(5,1), 5,5);

B = sparse(1:5,1:5, ones(5,1), 20,20);



figure,

% spy(S): plots the sparsity pattern of any matrix S.
subplot(1,2,1), spy(A,'dk') % plots black (b) diamond shapes (d) 
subplot(1,2,2), spy(B)

%%




M = load_off('./meshes/tr_reg_000.off');
% Adiacenza vertice-vertice

%La seguente è la versione del professore, pare SBAGLIATA

A = sparse(...
    [M.TRIV(:,1) ; M.TRIV(:,2); M.TRIV(:,3)],... 
    [M.TRIV(:,2) ; M.TRIV(:,3); M.TRIV(:,1)], ...
    1, M.n, M.n);

figure,
subplot(1,1,1), spy(A);
