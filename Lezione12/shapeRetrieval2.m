%%
clear all
close all
clc

X = load_off('meshes/cat0.off');
%Y = load_off('meshes/cat1.off');

[X.S, ~, X.M] = calc_LB_FEM(X);

%X.phi: autofunzioni (ne calcolo 500)

[X.phi, X.lambda] = eigs(X.S,X.M, 50, 'sm');
%metto gli autovalori in ordine crescente
[X.lambda,idx] = sort(diag(X.lambda));
X.phi = X.phi(:,idx);



%% OBIETTIVO: rappresentare le "funzioni coordinate" del gatto nella base del Laplaciano

% interpreto le coordinate xyz come 3 funzioni scalari
x = X.VERT(:,1);
y = X.VERT(:,2);
z = X.VERT(:,3);

%%
figure
i = 1;

for k = 10:10:50 
%     considero ad ogni ciclo un numero sempre più alto di funzioni in
%     base, per cercare di approssimare meglio la shape
    subplot(1,5,i)

%       le 3 funzioni scalari le proietto sulla base del Laplaciano,
%       troncandola.
%       proietto e ricostruisco subito %metto le () per un discorso di
%       efficienza.
%   ricostruisco subito  <-   proietto
    x_ = X.phi(:,1:k)*(X.phi(:,1:k)'*X.M*x); 
    y_ = X.phi(:,1:k)*(X.phi(:,1:k)'*X.M*y);
    z_ = X.phi(:,1:k)*(X.phi(:,1:k)'*X.M*z);
    
    Z = X;
    Z.VERT = [x_,y_,z_];
    plot_mesh(Z); shading interp; axis off; axis equal; light; camlight head; lighting phong;
    i = i+1;
% nota: le autofunzioni catturano meglio le parti a "ad alta frequenza",
%     -> all' aumentare del #autofunzioni considerate, le parti che via via
%     acquisiscono sempre più dettaglio sono quelle più "dettagli/particolari"    
end