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


x = X.VERT(:,1);
y = X.VERT(:,2);
z = X.VERT(:,3);

%%
figure
i = 1;

for k = 10:10:50 %prendo prima 10, poi 30, poi 50... fino a 100 autofunzioni che mi descrivono la shape
    subplot(1,5,i)
    % proietto e ricostruisco subito
    %metto le () per un discorso di efficienza

    %  
    x_ = X.phi(:,1:k)*(X.phi(:,1:k)'*X.M*x); %proietto e ricostruisco subito %metto le () per un discorso di efficienza
    y_ = X.phi(:,1:k)*(X.phi(:,1:k)'*X.M*y);
    z_ = X.phi(:,1:k)*(X.phi(:,1:k)'*X.M*z);
    
    Z = X;
    Z.VERT = [x_,y_,z_];

%nota: le autofunzioni catturano meglio le parti a "ad alta frequenza",
    %ovvero le parti della shape più dettagliata
    
    %prendo coordinate a caso
    f = Z.VERT(:,1).*Z.VERT(:,3);
    
    c = Z.phi'*Z.M*f;
   
    f_ = Z.phi*c;
    
    plot_mesh(Z,f_), shading interp; axis equal;
    i = i+1;
end