%%
dataset = './MPI-FAUST/training/scans';
shapes = dir(sprintf('%s/*.ply',dataset));

            
X = load_ply(sprintf('%s/%s', dataset, shapes(3).name));
Y = load_ply(sprintf('%s/%s', dataset, shapes(4).name));


%sono i punti individuati su ciascuna shape con "fps"
pts.X = fps(X,10,1);
pts.Y = fps(Y,10,1);


M = fuseMeshes(X,Y);

maxDx = max(X.VERT(:,1));
%prendo il punto più a sinistra della SECONDA SHAPE
minSx = min(Y.VERT(:,1));

% plot_mesh(M);
% axis equal;axis off; shading interp;
%% stampo le figure e visualizzo sulla prima i fps dal primo vertice 

%ogni field in pts è un insieme di punti per la shape

figure,
Y.VERT(:,1) = Y.VERT(:,1) + maxDx - abs(minSx) +2; 
% yVert(:,1) = yVert(:,1) + 2;
colormap(gray)
plot_cloud(X,[xVert],10e4);
shading interp, axis off, axis equal;

plot_cloud(Y,[yVert],10e4);
shading interp, axis off, axis equal;

%sono le coordinate dei fps
xVert = GetFieldByIndex(pts,1);
yVert = GetFieldByIndex(pts,2);
yVert(:,1) = yVert(:,1) + 2;

for i=1:size(xVert,1)
    plot3([xVert(i,1);yVert(i,1)]',[xVert(i,2);yVert(i,2)]',[xVert(i,3);yVert(i,3)]','k-')
    hold on
end    
axis off, axis equal;
hold on
%%
colormap(gray)
plot_cloud(M,[xVert;yVert],10e4);
shading interp, axis off, axis equal;

%%
% %subplot(121), 
% plot_cloud(X,GetFieldByIndex(pts,1),10e4);
% shading interp, axis off, axis equal;
% hold on
% %%
% subplot(122), 
% plot_cloud(Y,GetFieldByIndex(pts,2),10e4);
% shading interp, axis off, axis equal;
% hold on


