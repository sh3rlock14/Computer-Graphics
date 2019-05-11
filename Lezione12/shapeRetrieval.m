%%
clear all
close all
clc

X = load_off('meshes/cat0.off');
%Y = load_off('meshes/cat1.off');

[X.S, ~, X.M] = calc_LB_FEM(X);

%X.phi: autofunzioni (ne calcolo 50)

[X.phi, X.lambda] = eigs(X.S,X.M, 50, 'sm');

% [V,D] = eigs(___) returns diagonal matrix D containing the eigenvalues on 
% the main diagonal, and matrix V whose columns are the corresponding eigenvectors. 

% d = eigs(A,B,___) solves the generalized eigenvalue problem A*V = B*V*D
% 'sm' : Type of eigenvalues: smallest magnitude

%metto gli autovalori in ordine crescente
[X.lambda,idx] = sort(diag(X.lambda));

%prendo 50 autofunzioni
X.phi = X.phi(:,idx);

X.phi2 = X.phi(:,idx-20);
X.phi3 = X.phi(:,idx-30);

%prendo coordinate a caso
f = X.VERT(:,1).*X.VERT(:,3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %prendo coord MOLTO A CASO
% p = randi(X.n);
% f = zeros(X.n,1);
% f(p) = 1; %altrove rimane 0: è la funzione INDICATRICE DI UN PUNTO

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%coefficienti c
c = X.phi'*X.M*f;
c2 = X.phi2'*X.M*f;
c3 = X.phi3'*X.M*f;

%ricostruisco f
f_ = X.phi*c;
f_2 = X.phi2*c2;
f_3 = X.phi3*c3;

%la f ricostruita non è identica alla f originale perché ho calcolato un
%numero finito di autofunzioni

%verso destra sto aumentando la freuenza all'aumentare degli autovalori
figure
subplot(131), plot_mesh(X);
subplot(214), plot_mesh(X,f_2);
subplot(225), plot_mesh(X,f_3);
subplot(236), plot_mesh(X,f_);