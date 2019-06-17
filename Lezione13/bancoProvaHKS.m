%%
%X = load_off('./meshes/david1.off');

%uso il lupo se voglio fare esperimenti strani perchè ha pochi vertici!
dataset = './meshes/';

X = load_off(sprintf('%s/david1.off', dataset));
%X = load_off(sprintf('%s/wolf0.off', dataset));

%%

plot_mesh(X);
shading interp;
axis equal;
axis off;
%%

[X.S,~,X.M] = calc_LB_FEM(X);

%calcolo il Laplaciano
L = X.M\X.S;

[X.phi, X.lambda] = eigs(X.S, X.M, 1, 'sm');
%%
%metto gli autovalori in una colonna (sono ordinati in ordine NON DECRESCENTE)
[X.lambda, idx] = sort(diag(X.lambda));
X.phi = X.phi(:,idx);

%%
%calcolo l'HKS

% HKS trovata in giro e modificata leggermente
%hks = HKS(X.phi, X.lambda);

% qui sotto: hks costruito basandomi sull' heat kernel visto a lezione
% @eig = 30 autofunzioni 
% @t = 50 unità di tempo

%hks = myHKS(X,1,1);
hks = myHKSv2(X,1,1);


%%
figure
for i=10:10:30
    subplot(1,3,i/10), plot_mesh(X,hks(:,i)); shading interp; axis off; axis equal;
end