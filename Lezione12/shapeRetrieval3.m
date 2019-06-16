%%
clear all
close all
clc

%  X e Y sono quasi isometriche
%% voglio far vedere che le autofunzioni calcolate su shape quasi isometriche sono molto simili
X = load_off('meshes/cat0.off');
Y = load_off('meshes/cat10.off');

[X.S, ~, X.M] = calc_LB_FEM(X);
[Y.S, ~, Y.M] = calc_LB_FEM(Y);

%X.phi: autofunzioni (ne calcolo 500)

[X.phi, X.lambda] = eigs(X.S,X.M, 50, 'sm');
%metto gli autovalori in ordine crescente
[X.lambda,idx] = sort(diag(X.lambda));
X.phi = X.phi(:,idx);


[Y.phi, Y.lambda] = eigs(Y.S,Y.M, 50, 'sm');
%metto gli autovalori in ordine crescente
[Y.lambda,idxY] = sort(diag(Y.lambda));
Y.phi = Y.phi(:,idxY);


figure, colormap(bluewhitered)
for i=1:5
    subplot(2, 5, i), plot_mesh(X,X.phi(:,i)); shading interp; axis off; axis equal;
    subplot(2, 5, i+5), plot_mesh(Y,Y.phi(:,i)); shading interp; axis off; axis equal;
end

% nota: se di due figure non conosco la corrispondenza punto-punto, ma vedo
% che il valore delle autofunzioni per due punti è molto simile -> posso
% pensare di definire il concetto di vicinanza tra punti come differenza
% tra i valori dei vaolori delle autofunzioni in quei punti.