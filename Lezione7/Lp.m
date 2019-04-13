%%
M = load_off('./meshes/cat0.off.txt');

% individuo un punto sulla mesh (è un indice)
poi = 1139; 

% power
p = 2;      

% distanza Lp dal punto p a tutti gli altri
dist = sum(abs(repmat(M.VERT(p,:),M.n,1) - M.VERT).^p , 2).^(1/p);     

figure,


plot_mesh(M,dist);
% va messo dopo plot_mesh
axis equal
shading interp;
colormap(lines);

