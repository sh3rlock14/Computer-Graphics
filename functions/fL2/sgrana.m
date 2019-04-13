function outputArg1 = sgrana(I,l)
%{
    @param: I è l'immagine presa in input
    @param: l è il lato dei singoli QUADRATONI con cui divido l'immagine originale 
%}



[m,n,z] = size(I);

Red = I(:,:,1);     % considero i rossi, pixel per pixel
Green = I(:,:,2);   % considero i verdi
Blue = I(:,:,3);    % considero i blu

% casto a double i canali: vengono trasposti come vettori-colonna di
% dimensoini pari a ( n^2 x 1 )

vecRed = double(Red(:));
vecGreen = double(Green(:));
vecBlue = double(Blue(:));

%
%{
    "Base" è la nuova base che definira' i punti attivi all'interno
    dell'immagine;
    "Base" ha dimensioni ( n^2 x (n/l)^2 ):
    - n^2     :  dimensione di ogni vettore di Base
    - (n/l)^2 :  numero di vettori in Base (sto riducendo il numero di vettori di un fattore l^2)

%}

Base = spalloc(n^2, (n/l)^2, n^2);
for i=1 : n/l
    for j=1 : n/l
        ind_x = l*(i-1);
        ind_y = l*(j-1);
        
        %{
            S = sparse(i,j,v,m,n) specifies the size of S as m-by-n.
        
            S = sparse(i,j,v) generates a sparse matrix S from the triplets i, j, and v such that 
                S(i(k),j(k)) = v(k). The max(i)-by-max(j) output matrix has space allotted for
                    length(v) nonzero elements.
            sparse adds together elements in v that have duplicate subscripts in i and j.
        
            in pratica sparse() elimina da una matrice gli zeri per liberare
                memoria, tenendo da conto le coordinate punto punto per ogni
                    elemento diverso da 0 (zero)
        %}
        
        % con repmat sto creando dei vettori (l x 1), cioè colonne con 'l' elementi
        
        
        singleElement = sparse(repmat((ind_x+1):(ind_x+l),l,1),...     
           repmat((ind_y+1):(ind_y+l),l,1)',ones(l,l),n,n);
       % dal momento in cui il secondo vettore (quello creato dal secondo "repmat") è trasposto, io piazzo gli "1" in un blocco,
            % e non sulla diagonale
       % sistemo su una colonna di Base la singleElement
        Base = Base + sparse(1:n^2,(i+(j-1)*(n/l)) * ones(1,n^2), singleElement(:), n^2, (n/l)^2);
       
       %     ----- alternativa all'istruzione precedente ----- DA TESTARE
       %Base(:, i+j*n/l) = singleBase(:);
    end
end

%{
    1) Calcolo i coefficienti nella nouva base per ciascun colore:
           Coeff = Base\vecColor_old  (sto risolvendo Base\vecColor per Coeff ->
                ottengo una matrice di dimensioni pari a ( (n/l)^2 x 1 ), cioé:
                pari al numero di vettori contenuti in Base

    2) Calcolo il nuovo vettore del colore R/G/B (un vettore per ogni canale)
           colorVector_new = Base * Coeff ->
                ottengo dei vettori con tanti elementi quanti sono i pixel
                dell'immagine originaria, ma i cui colori sono ormai stati
                modificati in modo tale che, prendendo un blocchetto di
                lato "l", siano più "vicini tra loro": come effetto ottengo
                una sorta di sgranatura dell'immagine originale
 
    3) I singoli vettori vengono poi riscritti in matrici (n x n) e
        sovrapposti l'uno sull'altro, per ottenere l'immagine nuova   
%}

cr = Base\vecRed;
vecRed_new = Base * cr;

cg = Base\vecGreen;
vecGreen_new = Base * cg;

cb = Base\vecBlue;
vecBlue_new = Base * cb;


% creo una "nuova immagine" unendo i vettori dei 3 canali (rgb) in un'unica immagine
Im_sgr = uint8(cat(3, reshape(vecRed_new,n,n),reshape(vecGreen_new,n,n),reshape(vecBlue_new,n,n)));

outputArg1 = Im_sgr;
end