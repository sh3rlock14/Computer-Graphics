%{
    questa funzione mi permette di non perder tempo a richiamare trisurf e
    passare direttamente la matrice da cui prendo i triangoli e i vertici
    di riferimento per la mesh da plottare
%}

function obj = plot_mesh(varargin)
    % di default ho sempre la matrice di riferimento
    M = varargin{1};
    if nargin < 2
        obj = trisurf(M.TRIV, M.VERT(:,1), M.VERT(:,2), M.VERT(:,3));
        %axis equal
    % in più ho anche il parametro aggiuntivo che indica a quale asse (X,Y
    % o Z) debba essere proporzionale il colore
    else
        obj = trisurf(M.TRIV, M.VERT(:,1), M.VERT(:,2), M.VERT(:,3),varargin{2});
        %axis equal
    end
end
        