%%
close all
clear all
clc

M = load_off('meshes/cat10.off');

figure, colormap(jet)


subplot(131)
f = M.VERT(:,1);
plot_mesh(M, f); 
axis off
axis equal
shading interp
t = max(abs(min(f)),abs(max(f)));
caxis([-t t])
colorbar

subplot(132)
f = M.VERT(:,2);
plot_mesh(M, f)
axis off
axis equal
shading interp
t = max(abs(min(f)),abs(max(f)));
caxis([-t t])
colorbar

subplot(133)
f = M.VERT(:,3);
plot_mesh(M, f);
axis off
axis equal
shading interp
t = max(abs(min(f)),abs(max(f)));
caxis([-t t])
colorbar



%%

colors = (M.VERT - min(M.VERT)) ./ range(M.VERT);

figure
colormap(colors)
plot_mesh(M, 1:M.n);
shading flat
colorbar
