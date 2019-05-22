%%
dataset = './MPI-FAUST/training/scans';
shapes = dir(sprintf('%s/*.ply',dataset));

            
X = load_ply(sprintf('%s/%s', dataset, shapes(3).name));
Y = load_ply(sprintf('%s/%s', dataset, shapes(4).name));


%sono i punti individuati su ciascuna shape con "fps"
%pts.X = fps(X,10,1);

%eseguo un altro tipo di campionamento
pts.X = X.VERT(ceil(linspace(1,size(X.VERT,1),15)),:);

%se calccolo dopo i fps per la seconda shape, non devo spostare 2 volte i
%punti
%pts.Y = fps(Y,10,1);

%non serve più avere 2 mesh fuse assieme
%M = fuseMeshes(X,Y);

%prendo il punto più a DESTRA della PRIMA SHAPE
maxDx = max(X.VERT(:,1));

%prendo il punto più a sinistra della SECONDA SHAPE
minSx = min(Y.VERT(:,1));

%sposto verso destra la seconda figura nel seguente modo:
%prima faccio sì che l'estremo sinistro della seconda shape venga allineato
%col l'estremo destro della prima shape, poi sposto sempre verso destra per
%un valore arbitrario
Y.VERT(:,1) = Y.VERT(:,1) + abs(maxDx - minSx) + 1.5; 
%pts.Y = fps(Y,10,1);

%eseguo un altro tipo di campionamento
pts.Y = Y.VERT(ceil(linspace(1,size(Y.VERT,1),15)),:);

%sono le coordinate dei fps (sposto quelli della SECONDA shape)
xVert = GetFieldByIndex(pts,1);
yVert = GetFieldByIndex(pts,2);

%se i fps li calcolo dopo aver spostato la shape, non devo toccare i pfs
%yVert(:,1) = yVert(:,1) + maxDx - abs(minSx)+1;
%prima lo spostamento era arbitrario
% yVert(:,1) = yVert(:,1) + 2;

%% stampo le figure e visualizzo sulla prima i fps dal primo vertice 

%ogni field in pts è un insieme di punti per la shape

figure,


%definisco la colormap per entrambe le shape
colormap(gray)

%stampo la prima shape
plot_cloud(X,[xVert],10e4);
shading interp, axis off, axis equal;

%stampo la seconda shape
plot_cloud(Y,[yVert],10e4);
shading interp, axis off, axis equal;

for i=1:size(xVert,1)
    plot3([xVert(i,1);yVert(i,1)]',[xVert(i,2);yVert(i,2)]',[xVert(i,3);yVert(i,3)]','k-')
    hold on
end    
axis off, axis equal;
hold on



%%  quando avevo fuso le mesh usavo questo codice
% colormap(gray)
% plot_cloud(M,[xVert;yVert],10e4);
% shading interp, axis off, axis equal;
% 
% %%
% % %subplot(121), 
% % plot_cloud(X,GetFieldByIndex(pts,1),10e4);
% % shading interp, axis off, axis equal;
% % hold on
% % %%
% % subplot(122), 
% % plot_cloud(Y,GetFieldByIndex(pts,2),10e4);
% % shading interp, axis off, axis equal;



