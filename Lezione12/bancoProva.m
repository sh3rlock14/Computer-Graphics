%%
X = load_off('meshes/cat0.off');

%%
% @X.M := mass matrix
% @X.S := stifness matrix
[X.S,~,X.M] = calc_LB_FEM(X); 

%%

%Laplacian Beltrami Operator 
L = X.M\X.S;    %inv(X.M)*X.S;

%%
[X.phi, X.lambda] = eigs(X.S,X.M, 50, 'sm');

%%
%utilizzo il sort per sicurezza, ma i valori dovrebbero essere già ordinati
[X.lambda,idx] = sort(diag(X.lambda));

%%
X.phi = X.phi(:,idx);
X.phi2 = X.phi(:,idx(1:1,:));
X.phi3 = X.phi(:,idx(1:2,:));


%tronco alle prime 50 AUTOFUNZIONI
X.phi = X.phi(:,idx);

%prendo delle coordinate a caso
f = X.VERT(:,1).*X.VERT(:,3);

%ricavo i coefficienti delle funzioni
c = X.phi'*X.M*f;
c2 = X.phi2'*X.M*f;
c3 = X.phi3'*X.M*f;


%ricostruisco f approssimandola con le prime 50 autofunzioni
f_ = X.phi*c;

f_2 = X.phi2*c2;
f_3 = X.phi3*c3;

%%
figure

subplot(231), plot_mesh(X);shading interp, axis equal
subplot(234), plot_mesh(X,f_2);shading interp, axis equal
subplot(235), plot_mesh(X,f_3);shading interp, axis equal
subplot(236), plot_mesh(X,f_);shading interp, axis equal
