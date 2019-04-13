%%
% devo scaricare lo zip file di bunny
%M = load_ply('./meshes/bunny/bun000.ply');
%N = load_ply('./meshes/bunny/bun0045.ply');



colors = [1 0 0 ; 0 0 1];
figure,colormap(colors);

for iter=1:20
    
    clf;
    
    plot_mesh(M,ones(M.n,1)); shading interp; light;
    hold on
    plot_Mesh(N,2*ones(N.n,1)); shading interp; light;

    %%
    %implemento qui l'algoritmo per trovare le corrispondenze

    % sulla superficie blu visualizzo i punti rappresentativi della superficie
    % sulla superficie rossa troverò i punti più vicini

    N.fps = fps(N.VERT, 500, 1);

    plot_cloud(N,N.fps, 'w.');
    drawnow

    % trovo i campioni più vicini sulla prima superficie, rispetto ai fps
    % calcolati sulla seconda
    [idx, dist] = knnsearch(M.VERT, N.fps);

    % posso calcolare l'errore
    err = sum(dist);
    fprintf('%.3f\n',err);

    % devo trovare la rotostraslazione per portare la "blu" sulla "rossa"
    % nb: r0 è la traslazione
    %     s è il fattore di scaling: le due meshes potrebbero non avere uguale
    %     scala

    % costruisco i due insiemi di punti
    rl = M.VERT(idx,:); 
    rr = M.fps;

    % trovo i centroidi

    cl = mean(rl);
    cr = mean(rr);

    % calcolo le nuove cordinate baricentriche
    rl_ = rl- cl;
    rr_ = rr-cr;

    % noto: mean(rl_) && mean(rr_) = 0, i.e: i centroidi sono 0;

    M1 = rr_'*rl_;

    % l'esponente = ^(-0.5) equivale a fare l'inversa sotto radice quadra, ma
    % NON VA BENE NUMERICAMENTE
        %U = M1*(M1'*M1)^(-0.5)

    % il procedimento seguente ha lo stesso scopo di quello sopra, ma è più
    % stabile
    [u,s,v] = svd(M1);
    R = u*v';

    % devo eseguire la traslazione

        %t = cr' - R*cl'; questa t viene 3 x 1, io la volevo 1 x 3
    t = cr - cl*R';

    % ora applico t alla superficie blu


    M.VERT = (R*M.VERT' + t')';


end
