%%
clear all
close all
clc

X = load_off('meshes/cat0.off');
%Y = load_off('meshes/cat1.off');

[X.S, ~, X.M] = calc_LB_FEM(X);




% [V,D] = eigs(___) returns diagonal matrix D containing the eigenvalues on 
% the main diagonal, and matrix V whose columns are the corresponding eigenvectors. 

% d = eigs(A,B,___) solves the generalized eigenvalue problem A*V = B*V*D
% 'sm' : Type of eigenvalues: smallest magnitude



%@ X.phi: autofunzioni del laplaciano (ne calcolo 50)
[X.phi, X.lambda] = eigs(X.S,X.M, 50, 'sm');

% gli autovalori sono già in ordine crescente, ma sono salvati in una
% matrice diagonale (50 x 50) -> li metto su una sola colonna

%X.lambda = diag(X.lambda);  % ho commentato perché scriverò la parte di
%       codice che riordina in ogni caso gli autovalori e le autofunzioni
%       corrispondenti: in questo modo ho la sicurezza che siano sempre in
%       ordine NON DECRESCENTE



% metto gli autovalori in ordine crescente (a seconda delle versioni di
% MATLAB può essere un'operazione ridondante)

[X.lambda, idx] = sort(diag(X.lambda));

%riordino le 50 autofunzioni
X.phi = X.phi(:,idx);


%% plotto le prime 4 autofunzioni sulla shape del gatto
% noto che ciascuna autofunzione sembrano catturare le proprietà
% geometriche del gatto (una isola la testa, un'altra la coda...)
figure, colormap(bluewhitered)
for i=1:4
    subplot(1,4,i), plot_mesh(X,X.phi(:,i));
    axis off; axis equal;shading interp;
end


%% verifico che le autofunzioni siano ortogonali
% per farlo mi basta calcolare il prodotto interno per ciascuna
% autofunzione, pesato per le masse contenute nella Mass Matrix
ID = X.phi'*X.M*X.phi;
% stampo la matrice ID: se la diagonale è a 1 e tutto il resto a 0 -> la
% base è ortogonale
imagesc(ID), colorbar

%% definisco una funzione f da esprimere con i vettori in base del Laplaciano

% prendo coordinate a caso
f = X.VERT(:,1).*X.VERT(:,3);
plot_mesh(X,f);
axis equal; shading interp;


%% voglio rappresentare f nella base delle autofunzioni del Laplaciano,
% cioè: voglio che sia una combinazione lineare delle autofunzioni in PHI.
% Per farlo, devo calcolarmi i coefficienti con cui moltiplicare ciascuna
% autofunzione
% In pratica: devo calcolare i prodotti interni tra f e le autofunzioni

% quando faccio un prodotto interno RICORDA di pesare per le MASSE
%c  = f'*M*X.phi;    % ottengo un vettore (1 x k),   k: #autofunzioni
c = X.phi'*X.M*f;     % ottengo un vettore (k x 1)

%% ricostruisco una f_ che approssima f
f_ = X.phi*c;

% controllo visivamente che le due funzioni siano simili
figure,
subplot(121), plot_mesh(X,f); shading interp; axis equal;
subplot(122), plot_mesh(X,f_); shading interp; axis equal;



%% definisco una seconda  funzione f da esprimere con i vettori in base del Laplaciano

%   prendo coord a caso
rng('default')          % per riproducibilità
p = randi(X.n);         % prendo un punto randomico sulla shape (bump sulla zampa posteriore sinistra)
fInd = zeros(X.n,1);    % definisco la "funzione nulla" per la shape
fInd(p) = 1;            % trasformo la funzione nulla in una funzione INDICATRICE DI UN PUNTO:
%                       sulla mesh ora avrò un bump su un punto randomico

plot_mesh(X,fInd);
axis equal; shading interp;

%% rappresento f nella base delle autofunzioni del Laplaciano

% calcolo i coefficienti per poche autofunzioni
cIndTrunc = X.phi(:,1:5)'*X.M*fInd;


% ricostruisco con poche autofunzioni
fIndTrunc = X.phi(:,1:5)*cIndTrunc;


% calcolo i coefficienti con un prodotto interno (ricordo di pesare per le masse)
cInd = X.phi'*X.M*fInd;

% ricostruisco f
fInd_ = X.phi*cInd;


% la f_ (ricostruita) non è identica alla f (originale) perché ho troncato
% il numero di autofunzioni con cui ricostruire la funzione originale

%verso destra sto aumentando la freuenza all'aumentare degli autovalori
figure,
subplot(131), plot_mesh(X,fInd); shading interp; axis equal;
subplot(132), plot_mesh(X,fIndTrunc); shading interp; axis equal;
subplot(133), plot_mesh(X,fInd_); shading interp; axis equal;