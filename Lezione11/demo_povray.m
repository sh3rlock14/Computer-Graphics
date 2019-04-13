%%
clear all
clc


M = load_off('./meshes/cat10.off');

%abbasso la figura
M.VERT = M.VERT - mean(M.VERT);

% ho tante righe quanti sono i vertici
f = M.VERT(:,1);



% la f dventa in funzione dei triangoli della mesh
%       nb: utilizzo i valori interni alla riga "i" di M.TRIV come indici per accedere
%           alle posizioni corrispondenti in  f.
% Poiché gli indici per riga sono 3, e le righe sono tante quante i
% triangoli, la nuova f sarà una matrice di dimensione n x 3, 
% dove n = #TRIV

f = mean(f(M.TRIV),2);



plot_mesh(M)
axis equal
shading interp

% voglio colorare la mesh con jet 
colors = jet(300);

% riscalo i valori di f per farli andare da 0 a 1
idx = (f-min(f))./range(f);

% ora da 0 a 1 devo farli andare da 0 a 300
idx = floor(299*(f-min(f))./range(f)) +1;



save_mesh_povray(...
    './cat.mesh',...
    M,...
    colors(idx,:));
    %[ones(M.m,1) zeros(M.m,2)]
    