%{
@param1: è il percorso di input della mesh .off
@param2: è dove voglio salvare la mesh per utilizzarla in POV_RAY
@param3: è la colormap che voglio utilizzare
@param4: sono il numero di punti colori che defiiscono la mia mappa
%}



function salvaMeshRT(pathIN,pathOUT,colormap,pc)

    M = load_off(pathIN)


    M.VERT = M.VERT - mean(M.VERT);
    f = M.VERT(:,1);
    f = mean(f(M.TRIV),2);

    % voglio colorare la mesh con jet 
    colors = colormap(pc);

    % riscalo i valori di f per farli andare da 0 a 1
    idx = (f-min(f))./range(f);

    % ora da 0 a 1 devo farli andare da 0 a 300
    idx = floor((pc-1)*(f-min(f))./range(f)) +1;



    save_mesh_povray(...
        pathOUT,...
        M,...
        colors(idx,:));
    
end


