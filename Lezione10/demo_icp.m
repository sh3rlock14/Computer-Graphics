%%
clear all
close all
clc

%carica le meshes
X = load_ply('./meshes/bun000.ply');
Y = load_ply('./meshes/bun045.ply');


% le plotto assieme per vedere la situazione di partenza

% definisco una colormap di 2 colori con cui colorerò le 2 meshes
colors = [1 0 0; 0 0 1];

% figure, colormap(colors)
% 
% plot_mesh(X,ones(X.n,1)), shading interp, axis equal; light
% hold on
% plot_mesh(Y,2*ones(Y.n,1)), shading interp, axis equal; light


% Trovo gli fps su Y (la mia funzione non torna un insieme di indici, ma
% una matrice contenente gli fps) non voglio considerare tutti i punti
% sulla superficie
Y.fps = fps(Y.VERT, 100, 1);

% plotto i fps sulla seconda superfice
%plot_cloud(Y, Y.fps, 20,'w');


%colors = [1 0 0; 0 0 1];
figure, colormap(colors)

errs = [];

for iter=1:20
    
    clf;    %pulisce la figura
    plot_mesh(X, ones(X.n,1)); shading interp;
    hold on
    plot_mesh(Y, 2*ones(Y.n,1)); shading interp;
%     plot_cloud(Y, Y.fps, 'w.')
    drawnow
    
    
%     knn prende in input 2 insiemi di punti e dà in output gli indici dei più vicini e la loro distanza
%       il primo insieme è quello di partenza, il secondo quello di arrivo

    %in dist ho le distanze fps - nearest neighbour su X
    [idx, dist] = knnsearch(X.VERT, Y.fps);
    
    %definisco l'errore come somma delle distanze
    err = sum(dist);
    fprintf('%.4f\n', err)
    
    errs = [errs err];
    
    
    % costruisco i due insiemi di punti:
    
%     sulla mesh d'arrivo prendo i punti che sono "i più vicini" a ciascun
%       fps della mesh di partenza
%     sulla mesh di partenza considero gli fps
    
    rl = X.VERT(idx,:);
    rr = Y.fps;
    
    % calcolo i 2 centroidi per le 2 shapes:
    
    cl = mean(rl);  % centroide per "i più vicini"
    cr = mean(rr);  % centroide per gli fps
    
%     per curiosità plotto il centroide per gli fps e i punti
%     "corrispondenti" sulla seconda shape

      plot_cloud([],cr,20,'y');                 % centroide per gli fps
      plot_cloud(X, X.VERT(idx,:), 20, 'k');    % centroide per i punti "corrispondenti"

    
%      passo a coordinate baricentriche
    rl_ = rl - cl;
    rr_ = rr - cr;
    
   
    
%      calcolo la rotazione come un prodotto tra matrici: il risultato è
%      una matrice (k x k) , dove 'k' è il numero di dimensioni in cui sto
%      lavorando

    M = rr_'*rl_;
    
    
%     U = M*(M'*M)^(-0.5);  %è la rotazione
% per verificare che U sia una rotazione calcolo il suo determinante e
% verifico sia pari a 1
%       rot = det(U) 

% per fare il calcolo dell'inversa passo per la Trasformata: il calcolo
% numerico ...^(-0.5) ha una procedura instabile
    [u,s,v] = svd(M);
    R = u*v';   % è la Rotazione
    
%     calcolo la traslazione
%     t = (cr' - R*cl')'; % sa applico direttamente la trasposizione
%                            il primo termine torna cr, il secondo ha i
%                            termni invertiti e trasposti
    t = cr - cl*R';
    
%      applico la roto-traslazione
    X.VERT = (R*X.VERT' + t')';
    
end

figure, plot(errs)