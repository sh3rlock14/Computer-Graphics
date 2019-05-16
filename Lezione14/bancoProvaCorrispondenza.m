%%
dataset = './MPI-FAUST/training/scans';
shapes = dir(sprintf('%s/*.ply',dataset));

X(1) = load_ply(sprintf('%s/%s', dataset, shapes(3).name));
X(2) = load_ply(sprintf('%s/%s', dataset, shapes(4).name));
pts(1) = fps(X(1),10,1);

%% stampo le figue e visualizzo sulla prima i fps dal primo vertice 

for i=3:4%size(shapes,1)
    %devo scalare l'index i
    subplot(1,2,i-2),
    %devo scalare gli indici
    X(i-2) = load_ply(sprintf('%s/%s', dataset, shapes(i).name));
    plot_mesh(X(i-2));
    shading interp, axis off, axis equal;
    %devo scalare l'index i
    %calcolo i 10 fps per ogni shape 
    pts(i-2) = fps(X(i-2),10,1);
end

%%
plot_cloud(X(1), pts(1));

