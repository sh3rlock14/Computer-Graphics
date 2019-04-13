%%
clear all
clc

M = load_off('./meshes/cat2.off')


%creerò una telecamera ORTOGRAFICA (lunghezza focale alta -> riduco l'effetto prospettico)

%mi metto sui vertici dei triangoli, su ogni vertice "fingo" sia arrivato
%un raggio partito dalla telecamera: eseguo i calcoli su ciascun vertice e
%poi eseguo l'interpolazoine sulle facce. 


%per eseguire lo shading devo calcolare: le normali 

normals = cross(...
    M.VERT(M.TRIV(:,2),:) - M.VERT(M.TRIV(:,3))...
     M.VERT(M.TRIV(:,3),:) - M.VERT(M.TRIV(:,1),:));

%adiacenza vertice triangolo

P = sparse(...
    M.TRIV(:),...
    [1:M.m 1:M.m 1:M.m],...
    1,...
    M.n, M.n);

normals = P*normals;

% la telecamera guarda verso il gatto
% a ogni punto applico il vettore [0 1 0] alle coord x,y,z del gatto

normals = spdiag(1./sqrt(sum(normals.^2,2)))*normals;

plot_mesh(M);
hold on

%plot_vfield(M.VERT, normals, 1, 'b');
%plot_vfield(M.VERT, repmat([0 1 0], M.n)  )

%genero dei vettori orientati casualemnte, e non più paralleli all'asse y
view = rand(3,1);
%normalizo i miei vettori: in questo modo quando calcolo il cos(theta) tra
%normali e vettori "view" devo calcolare solamente il PRODOTTO SCALARE
view = view./norm(view);

%calcolo l'angolo tra ogni normale e il vettore colonna [0 1 0] attraverso
%il PRODOTTO SCALARE
shading = normals*[0;1;0];


plot_mesh(M,shading);





