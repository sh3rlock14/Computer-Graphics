%%


%dimensioni della matrice delle coordinate
row = 6;
column = 3;

%dimensioni della matrice dei triangoli
triRow = 2;
%column = 3 (rimane la stessa)

V = zeros(6,3);

for c = 1:column
    for r = 1:row
        V(r,c) = (2*rand()-1)*100;      % creo randomicamente dei valori per le coordinate
    end
end

%Ho 30 vertici -> 30/3 (vertici per triangolo) = 10 triangoli

% "prealloco"
T = [[],[],[]];

rigaVertex=1;
for r = 1:triRow
    for c = 1:column
        T{r,c} = V(rigaVertex,:);
        rigaVertex = rigaVertex+1;      % devo scendere per tutte le righe della matrice dei vertici, mentre mi muovo sulle 
                                        % colonne della matrice dei
                                        % triangoli
    end
end



% ---- Accedo agli Elementi di un Array Multidimensionale e Annidato ----- %

% in questo modo accedo al primo elemento della prima cella della matrie 2 x
% 3 dei triangoli , ovvero: alla coordinata x del primo dei 3 vertici del
% primo triangolo

% il valore tra le {} seleziona la riga e la colonna della matrice T
% il valore tra le () seleziona quale dei 3 valori prendere (x,y o z) (posso accedere a più elementi - coordinate -
% contemporaneamente: basta usare  ,: (virgola,due punti))

elT = T{2,2}(1); % accedo alla seconda colonna (vertice) della seconda riga (triangolo) e prendo la prima coordinata (x)
elT2 = T{1}(1,:); % accedo alla prima colonna (vertice) della prima riga (triangolo) e prendo tutte le coordinate (x,y e z)


% ------ Calcolo le aree dei Triangoli ------- %
% mentre scorro la matrice dei triangoli, arrivato su una riga sto
% scorrendo i vari vertci: qui devo costruire al volo 3 "istanze" v1 v2 v3
% e applicarci la funzioe calcola area
A = zeros(2);

Aree = zeros(1);
index = 1;

for r = 1:triRow
    vertex = zeros(3);
    vertey = zeros(3);
    %vertez = zeros(3);
    for c = 1:column
        vertex(c) = T{r,c}(1);
        vertey(c) = T{r,c}(2);
        %vertez(c) = T{r,c}(3);
        
        if c>=3
            Aree(index) = calcolaArea(vertex(1),vertex(2),vertex(3),vertey(1),vertey(2),vertey(3));
            index = index +1;
        end
        
    end
end

function outputArg = calcolaArea(v1x,v2x,v3x,v1y,v2y,v3y)
             M = [v1x v1y 1;...
                 v2x v2y 1;...
                 v3x v3y 1];
             
             areaTriangolo = abs(det(M))*0.5;
            outputArg = areaTriangolo;
         end


