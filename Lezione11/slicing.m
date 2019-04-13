%%
clear all
clc


M = load_off('./meshes/dog2.off');


%prendo tutte le coordinate y
coordY = M.VERT(:,2);


oldVert = M.VERT;
M.oldVert = M.VERT;
oldm = M.m;
oldn = M.n;


%coordNeg = coordY(coordY<0);

%M.oldTRIV = M.TRIV;

%sono gli indici dei vertici la cui y vale > 0
idx = find(coordY<=0);


%per ogni indice nella lista

%{
for j=size(idx,1):-1:1
    %rimuovo il vertice che non mi serve più
    M.VERT(idx(j),:) = [];
    %nb: scorro la lista al contrario, perchè quando assegno ... = [] la
    %lunghezza della lista scala e gli indici dei vertici "in fondo" alla
    %lista non si trovano più dove si trovavano prima. 
    %devo dunque eseguire una pulizia dal basso
end
%}

%sono il numero di triangoli nella mesh
len = size(M.TRIV,1);

%è l'indice che utilizzo per creare la nuova matrice dei triangoli
M.m2 = 1;

%per ogni triangolo
for i=1:len
    %{
    %verifico che uno degli vertici sia in nel triangolo alla riga i
    a(:,i) = ismember(idx, M.TRIV(i,:));
    b(i) = sum(a(:,i),1);
    %cioè: se il triangolo NON ha un vertice la cui y è al dilà dello 0
    if (b(i)==0)
        M.TRIV2(i,:) = [M.TRIV(i+1412,:)]; 
    %}
    if (~ismember(M.TRIV(i,:),idx))
        M.TRIV2(M.m2,:) = M.TRIV(i,:);
        M.m2 = M.m2 + 1;
    
    end
end



%aggiorno la lista dei triangoli
M.TRIV = M.TRIV2;
%...il numero di triangoli 
M.m = size(M.TRIV,1);
%...e di vertici
M.n = M.n - size(idx,1);

%{
plot_mesh(M);
axis equal
shading interp
colormap(lines(20));
%}

 
%        RIMUOVO I VERTICI CHE NON MI SERVONO PIU'
%           FACCIO QUESTO DOPO AVER PLOTTATO
for j=size(idx,1):-1:1
    %rimuovo il vertice che non mi serve più
    M.VERT(idx(j),:) = [];
    %nb: scorro la lista al contrario, perchè quando assegno ... = [] la
    %lunghezza della lista scala e gli indici dei vertici "in fondo" alla
    %lista non si trovano più dove si trovavano prima. 
    %devo dunque eseguire una pulizia dal basso
end



%riposiziono verso il basso la figura
M.VERT = M.VERT - mean(M.VERT);


f = oldVert(:,3);
%f = mean(f(M.TRIV),2);
fpovRay = mean(f(M.TRIV),2);

colors = lines(20);

idc = (f-min(f)./range(f));
idc = floor(19*(f-min(f))./range(f)) +1;

M.VERT = M.oldVert;
M.n = oldn;

save_mesh_povray(...
    './culoDiCane.mesh',...
    M,...
    colors(idc,:));

%%

%devo creare f in moto tale che il 
%numero di righe sia pari al numero
%di vertici attuali (quelli che non
%contengono y > 0)

%{
oldVert = size(M.VERT,1)
index = 1;
for i=1:oldVert
    if (~ismember(i,idx))
        f(index,:) = M.VERT(i,3);
        index = index +1;
    end
end
%}







f = mean(f(M.TRIV),2);



fpovRay = mean(f(M.TRIV),2);

colors = lines(20);

idc = (f-min(f)./range(f));
idc = floor(19*(f-min(f))./range(f)) +1;


save_mesh_povray(...
    './culoDiCane.mesh',...
    M,...
    colors(idc,:));

