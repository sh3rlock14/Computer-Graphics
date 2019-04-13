%%
clear all
clc

M = load_off('./meshes/cat2.off')

myAutumn = autumn(300);

for i=1:30
    myAutumn(i,:) = [0 0 0];
end


%abbasso la figura verso il suolo
M.VERT = M.VERT - mean(M.VERT);

%f = M.VERT(:,1);
f2 = sin(M.VERT(:,2) + M.VERT(:,1));
%f3 = M.VERT(:,3);

%{
figure,

subplot(1,3,1), plot_mesh(M,f); shading interp; axis equal
colormap(myAutumn)
t = max(abs(min(f)),abs(max(f)));
caxis([-t t])
colorbar
xlabel('x');
ylabel('y');
zlabel('z');


subplot(1,3,2), plot_mesh(M,f2); shading interp; axis equal
colormap(myAutumn)
t = max(abs(min(f2)),abs(max(f2)));
caxis([-t t])
colorbar
xlabel('x');
ylabel('y');
zlabel('z');

subplot(1,3,3), plot_mesh(M,f3); shading interp; axis equal
colormap(myAutumn)
t = max(abs(min(f3)),abs(max(f3)));
caxis([-t t])
colorbar
xlabel('x');
ylabel('y');
zlabel('z');

%}





f = mean(f2(M.TRIV),2);

colors = myAutumn;
idx = (f-min(f))./range(f);
idx = floor(299*(f-min(f))./range(f)) +1;

save_mesh_povray(...
    './tigrrCat.mesh',...
    M,...
    colors(idx,:));
