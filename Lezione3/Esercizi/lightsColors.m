%%
clear all
close all
clc

M = load_off('./meshes/cat0.off.txt');
%M.normals = calc_normals(M);
%M.tri_area = calc_area(M);

f = M.VERT(:,3);
h = plot_mesh(M,f);
colormap(jet(300)) % provo un altra cMap, incrementato i punti colore da "default" a 300
colorbar
axis equal
shading interp
xlabel('x')
ylabel('y')
zlabel('z')
%h.EdgeColor = [1 0 0]; %coloro gli archi di rosso

%%

figure
for i=0:0.01:1
    h = plot_mesh(M,f);
    h.EdgeColor = [1 0 0];
    axis equal
    axis off
    rotate3d on
    shading interp
    light
    camlight head
    lighting gouraud
    set(h,'AmbientStrength',i)
    drawnow
end

%%

% definisco una nuova colormap
colors = hot(500);
colors = colors(end:-1:1,:); % upsidedown della matrice colors
%colors = sin(10*colors);
colormap(colors)

% creo una colormap da bianco a rosso che decresce linearmente
n = 100;
r = ones(n,1);
g = linspace(1,0,n)';
b = linspace(1,0,n)';
whitered = [r,g,b];
colormap(whitered);
