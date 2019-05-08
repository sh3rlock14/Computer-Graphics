%%
clear all
close all
clc

X = load_off('meshes/cat0.off');
%Y = load_off('meshes/cat1.off');

[X.S, ~, X.M] = calc_LB_FEM(X);

%X.phi: autofunzioni (ne calcolo 50)

[X.phi, X.lambda] = eigs(X.S,X.M, 50, 'sm');
%metto gli autovalori in ordine crescente
[X.lambda,idx] = sort(diag(X.lambda));
X.phi = X.phi(:,idx)


x = X.VERT(:,1);
y = X.VERT(:,2);
z = X.VERT(:,3);


figure
i = 1;
for k=10:20:100 %prendo prima 10, poi 30, poi 50... fino a 100 autofunzioni che mi descrivono la shape
    subplot(1,5,i)
    x_ = X.phi(:,1:k)*(X.phi(:,1:k)'*X.M*x); %proetto e ricostruisco subito %metto le () per un discorso di efficienza
    y_ = X.phi(:,1:k)*(X.phi(:,1:k)'*X.M*y);
    z_ = X.phi(:,1:k)*(X.phi(:,1:k)'*X.M*z);
    Z = X;
    Z.VERT = [x_,y_,]
    
    %nota: le autofunzioni catturano meglio le parti a "ad alta freuenza",
    %ovvero le parti della shape più dettagliata
    
%prendo coordinate a caso
f = X.VERT(:,1).*X.VERT(:,3);

% %prendo coord MOLTO A CASO
% p = randi(X.n);
% f = zeros(X.n,1);
% f(p) = 1; %altrove rimane 0: è la funzione INDICATRICE DI UN PUNTO

%coefficienti c
c = X.phi'*X.M*f;

%ricostruisco f
f_ = X.phi*c;


%la f ricostruita non è identica alla f originale perché ho calcolato un
%numero finito di autofunzioni

%verso destra sto aumentando la freuenza all'aumentare degli autovalori
figure
subplot(131), plot_mesh();
subplot(132), plot_mesh();
subplot(133), plot_mesh();
