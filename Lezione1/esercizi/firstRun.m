%%
clear all
close all
clc

M = load_off('./Lezione1/meshes/cat0.off.txt');



e12 = M.VERT(M.TRIV(:,2),:) - M.VERT(M.TRIV(:,1),:);
e13 = M.VERT(M.TRIV(:,3),:) - M.VERT(M.TRIV(:,1),:);

% cross è il prodotto vettoriale che calcola la normale per ogni triangolo
% le normali definiscono il comportamento delle mesh rispetto a "chi le
% guarda": a seconda del loro orientamento posso esporre:
    % la PARTE INTERNA (della mesh)
    % la PARTE ESTERNA (della mesh)
n = cross(e12,e13); 

% calcolo il quadrato elemento per elemento nella matrice
% eseguo la somma dei quadrati lunga la riga (la seconda dimensione)
% costruisco una matrice e la moltiplico con la mia matrice contenente le
% normali: il risultato è una matrice contentente le normali divise per le
% norme corrispondenti

% sovrascrivo n: sovrascrivo le righe calcolate prima con la loro versione
% normalizzata


% spdiag è una funzione che ha scritto il professore. serve perché essendo
% la matrice molto grande ma sparsa, non memorizza gli zeri e risparmia
% spazio in memoria

% notazione: il . (punto) dopo 'n' significa che il quadrato è un'operazione
% che viene eseguita elemento per elemento all'interno della matrice stessa
% (NON viene elevata al quadrato la matrice)

%------------------------------------
% n = spdiag(1./sqrt(sum(n.^2,2)))*n;
%------------------------------------


%questa è la funzione di matlab, il prof non ricorda la sintassi

n = sparse(...
    1:M.m,...
    1:M.m,...
    1./sqrt(sum(n.^2,2)))* n;



plot_mesh(M);
hold on;
%   pcshow() plotta la cloud 

%pcshow([M.VERT(:,1),M.VERT(:,2),M.VERT(:,3)]);

%devo scrivere la funzione per calcolare il centroide di ogni triangolo
%------------------------------------

c = calc_centroids(M);

%------------------------------------
% quiver permette di plottare delle frecce in R3
%------------------------------------


quiver3(c(:,1), c(:,2), c(:,3),...
    n(:,1),n(:,2),n(:,3));
