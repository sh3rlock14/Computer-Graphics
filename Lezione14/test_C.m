%%
clear all
close all
clc

X = load_off('./meshes/tr_reg_000.off');
Y = load_off('./meshes/tr_reg_001.off');

P = speye(X.n);

% i colori sono esattamente le coordinate sul secondo oggetto (riscalati tra 0 e 1)
colors = (Y.VERT - min(Y.VERT))./(range(Y.VERT));

figure
% immergo la shape in una matrice di colori tutti differenti
subplot(121), colormap(P*colors), plot_mesh(X, 1:X.n) % ho portato i colori della seconda shape sulla prima, conoscendo la Corrispondenza ground-truth
axis equal; axis off; shading flat; freezeColors % freeze_colors serve per fissare la prima colormap, altrimenti MATLAB impiega l'ultima indicata, per tutte le altre 
subplot(122), colormap(colors), plot_mesh(Y, 1:Y.n)
axis equal; axis off; shading flat;


%% Calcolo le autofunzioni del Laplaciano di X e Y

[X.S,~,X.M] = calc_LB_FEM(X);
[X.phi, ~] = eigs(X.S, X.M, 50, 'sm');

[Y.S,~,Y.M] = calc_LB_FEM(Y);
[Y.phi, ~] = eigs(Y.S, Y.M, 50, 'sm');

%% Visualizzo un'autofunzione di X mappata su Y

% visualizzo la decima autofunzione di X su X
% per curiosità vedo com'è la decima autofunzione di Y su Y
% visualizzo l'autofunzione di X su Y

figure, colormap(bluewhitered)
subplot(131), plot_mesh(X, X.phi(:,10)); axis off; shading interp; view([0 90]); title('autofunzione originale di X');
subplot(132), plot_mesh(Y, Y.phi(:,10)); axis off; shading interp; view([0 90]); title('autofunzione originale di Y');
% il trasferimento avviene con la corrispondenza P 
subplot(133), plot_mesh(Y, P*X.phi(:,10)); axis off; shading interp; view([0 90]); title('autofunzione di X mappata su Y'); 

%% Calcolo C e la visualizzo

%utilizzo la formula vista sulle slides: C = B'TA

% dove T è la matrice delle corrispondenze
% A è la base contentente le autofunzioni del Laplaciano della prima shape
% B è la base contentente le autofunzioni del Laplaciano della seconda shape
% ricordo di pesare per le Masse quando eseguo il PRODOTTO INTERNO

%C = Y.phi'*(P*X.phi);  PROBLEMINO!...

C = Y.phi'*Y.M*(P*X.phi);
% ... ogni valore in C è il prodotto interno tra un'autofunzione di una shape e
% un'autofunzione trasportata sulla seconda shape. Il prodotto interno va
% pesato con gli ELEMENTI DI AREA di dove il prodotto interno viene
% calcolato (sulla seconda shape in questo caso).


figure, colormap(bluewhitered)
imagesc(C),axis image,colorbar

%% Trasporto una funzione indicatrice usando C

rng('default') % per riproducibilità: è un punto poco sotto l'anulare destro

f = zeros(X.n,1);
% creo la funzione indicatrice
% f è in base standard
f(randi(X.n)) = 1;

% calcolo la funzione indicatrice g, che mapperà (anche in modo
% approssimato **) il punto individuato sulla prima shape, sulla seconda

% ** Se ho poche autofunzioni in X.phi, il calcolo: (X.phi'*X.M*f)
% (approssimerà) molto la funzione f: nel momento in cui "mappo" la
% funzione è già arrivata "smoothed".

g = Y.phi*C*(X.phi'*X.M*f);


% Se voglio creare una funzione indicatrice più precisa, posso seguire
% un'idea stupida ma efficace: calcolata g, ne prendo il valore massimo e
% azzero gli altri: in questo modo annullo l'effetto "bump" che otterei
% altrimenti
[maxg, idx] = max(g);
g = zeros(size(g,1),size(g,2));
g(idx) = maxg;
% il risultato non viene preciso: il punto individuato non corrisponde
% esattamente a quello della shape di partenza, ma almeno ho ristretto
% l'area di bump.


figure
subplot(121), plot_mesh(X, f); shading interp; axis equal; axis off;
subplot(122), plot_mesh(Y, g); shading interp; axis equal; axis off;


%% Trasporto un'altra funzione

f2 = X.VERT(:,1);
% C*f NON POSSO FARLO: non tornano le dimensioni: C: (k x k); f: (n x 1);
% -> devo trasportare f nella base che C "capisce", ovvero la base del
% Laplaciano

g2 = Y.phi*C*(X.phi'*X.M*f2);

figure
subplot(121), plot_mesh(X, f2); shading interp; axis equal; axis off;
subplot(122), plot_mesh(Y, g2); shading interp; axis equal; axis off;



%% Risolvo per C usando funzioni indicatrici come descrittori

% qualcuno mi ha dato le corrispondenze per questi 50 punti...voglio quella
% per i rimanenti punti
fps = fps_euclidean(X.VERT, 50, 1);
plot_mesh(X), hold on, plot_cloud(X,X.VERT(fps,:),100);shading interp; axis equal; axis off;

% F matrice contente descrittori
F = sparse(fps, 1:50, 1, X.n, 50); % alle righe fps e alle colonne da 1 a 50 metto 1. 
% (ogni colonna è una funzione indicatrice di uno degli fps)

% matrice contente i descrittori calcolati sulla seconda shape
G = P*F; % posso farlo perché "qualcuno" mi ha dato la corrispondenza per quei punti

A = X.phi'*X.M*F; % F_cappuccio nelle slides
B = Y.phi'*Y.M*G; % G_cappuccio nelle slides

% l'obiettivo è trovare la C migliore che risolva: C*A = B

% A*x = b in matlab x = A\b
C_risolta = (A'\B')';


figure, colormap(bluewhitered)
imagesc(C_risolta), axis image, colorbar

%% verifico quanto sia buona la C_risolta, trasportando una funzione calcolata prima
f = zeros(X.n,1);
f(randi(X.n)) = 1;

g = Y.phi*C_risolta*(X.phi'*X.M*f); % è rumorosa ma corretta: per correggere un po' il tiro posso pensare di fare come ho fatto sopra1 

figure
subplot(121), plot_mesh(X, f);shading interp; axis equal; axis off;
subplot(122), plot_mesh(Y, g);shading interp; axis equal; axis off;