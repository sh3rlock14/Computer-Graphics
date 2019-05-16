%%
clear all
close all
clc 

X = load_ply();
Y = load_ply()

% la corrispondenza in questo caso è l'identità
P  = speye(X.n);

colors = (Y.VERT - min(Y.VERT))./(range(Y.VERT));

%% trasferisco il colore alla seconda shape


figure
%ogni punto ha il suo colore
subplot(121), colormap(colors), plot_mesh(X, 1:X.n);
shading flat; freeze_colors %congela la colormap sulla prima mesh

subplot(122), colormap(colors), plot_mesh(X, P*1:X.n);
shading flat; 


%%
%calcolo il laplacian delle 2 shape e le prime 10 autfunzioni
[X.S, ~, X.M] = calc_LB_FEM(X);
[X.phi,~] = eigs(X.S, X.M, 10, 'sm');



[Y.S, ~, Y.M] = calc_LB_FEM(Y);
[Y.phi,~] = eigs(Y.S, Y.M, 10, 'sm');



%visualizzo la decima autofunzione della prima shape e la trasferisco sulla seconda shape



plot_mesh(X; X.phi(:,10)); axis equal, axis off, shading interp;
%per curiosità mostro anche la 10 autof. della seconda funzione
%plot_mesh(Y; Y.phi(:,10)); axis equal, axis off, shading interp;
plot_mesh(Y; P*X.phi(:,10)); axis equal, axis off, shading interp;



%%
% calcolo la matrice C dei coefficienti di espansione
%devo pesare per le Masse quando calcolo il prodotto interno 
C = Y.phi'*Y.M*(P*X.phi);
imagesc(C), colormap(bluewhitered), axis image, colorbar;


%% Prendo una funzione su X e la mappo su Y attraverso C

f = X.VERT(:,1);

% creo una seconda funzione su X per un altro test
% funzione indicatrice
f2 = zeros(X.n,1);
f2(randi(X.n)) = 1;


% Leggo le operazioni in 'g' dall'interno verso l'esterno 
% proietto e peso
% trasfersco i coefficienti
% ricostruisco nella base standar
g = Y.phi*C*(X.phi'*X.M*f); %ricordo che devo pesare i prodotti interni per M % C*f non posso farlo. C è kxk, f è nx1, e poi SONO IN BASI DIVERSE;

figure
subplot(121), plot_mesh(X,f),axis equal, shading interp;
subplot(122), plot_mesh(Y,g),axis equal, shading interp;

%% Calcolo C, considerandola come soluzione del sistema lineare (slides 14, pg 25)

%F'*Phi*C' = G'*Psi;
%F'*Phi*C' = A;
%G'*Psi = B;
%C = A\B;

furps = fps(X.VERT, 50);

%vedo quali siano i punti
%plot_mesh(X), shading interp, hold on, plot_cloud(X, furps);

% ogni colonan della matrice nx50 ha un 1 per colonna, nella posizione del
% furthest point sampling
F = sparse(furps, 1:50, 1, X.n, 50);
% qualcuno mi ha dato la corrispondenza solo per i 50 punti
G = P*F;

%A = F_cappuccio nelle slides 14
%B = G_cappuccio nelle slides 14
% sono i coeff. di espansione
A = X.phi'*X.M*F;
B = Y.phi'*Y.M*G;

% trovare C vuol dire risolvere un problema lineare del tipo:
% A*x = b, che in matlab diventa: x = A\b

%C*A = B;

C_risolta = (A'\B')';
imagesc(C_risolta), colormap(bluewhitered), axis image, colorbar;




