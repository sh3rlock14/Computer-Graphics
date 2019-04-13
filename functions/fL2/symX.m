%%
clear all
close all
clc


%{
    BANCO DI PROVA CON UN'IMMAGINE 4 X 4
        I = imread('./win.png');
        I = I(1:4,1:4,:);
%}
 

I = imread('./images/lena.png');
l = 16;     % lato dell'area

%{

[m,n,z] = size(I);  % la terza dimensione è quella del colore:
                    % se non la esplicito quando utilizzo size(I), questa viene moltiplicata ad "n", che risulterà
                    % dunque più grande rispetto all'originale.
                    % posso utilizzare m= size(I,1) per salvare solamente
                    % la prima dimensione, che in questo caso coincide
                    % anche con la seconda (l'immagine è quadrata)

%{
    l :: Dimensione dei lati dei quadrettoni con cui dividerò l'immagine.
    Più alto il numero, meno quadrettoni (pixeloni) avrò, più l'immagine
    sarà sgranata.
%} 



% Ho ritagliato l'immagine per comodità e poter controllare come i singoli
% pixel shiftssero di colore
%I = I(31:60,31:60,:);

%imshow(I)





% -- fliplr(arg) :: ribalta arg --%

%{
IR = fliplr(I);
figure,
subplot(2,2,1), imshow(I);
subplot(2,2,2), imshow(IR);
%}



%figure,
%{
     creo delle matrici (n x n) che elencano il valore
     ,pixel per pixel, di uno dei 3 canali RGB
%}


Red = I(:,:,1);     % considero i rossi, pixel per pixel
Green = I(:,:,2);   % considero i verdi
Blue = I(:,:,3);    % considero i blu

%{
subplot(2,3,1), imagesc(Red);
subplot(2,3,2), imagesc(Blue);
subplot(2,3,3), imagesc(Green);
%}

% creo dei "vettori colonna" dalle matrici Red/Green/Blue
vecRed = double(Red(:));
vecGreen = double(Green(:));
vecBlue = double(Blue(:));


%{
    Posso usare reshape per tornare dai vettori alle matrici e poi uso "cat" per fonderli assieme:
    cat(3,...) "incolla" sulla terza dimensione

    IM2 = cat(3,reshape(Red,n,n),reshape(Green,n,n),reshape(Blue,n,n));

    vd. sotto per un esempio concreto
%}


% voglio dividere l'immagine in quadrettoni che abbiano lunghezza (l) 16

%{
la nuova "matrice Base" che cerco ha dimensioni ( n^2 x (n/l)^2 ):
    ? n^2 è la dimensione di ogni vettore di Base
    ? (n/l)^2 è il numero di vettori di Base (sto riducendo il numero di vettori di un fattore l^2)

%}



Base = spalloc(n^2, (n/l)^2, n^2);
for i=1 : n/l
    for j=1 : n/l
        ind_x = l*(i-1);
        ind_y = l*(j-1);
        
        
        %{
            S = sparse(i,j,v,m,n) specifies the size of S as m-by-n.
        
            S = sparse(i,j,v) generates a sparse matrix S from the triplets i, j, and v 
            such that S(i(k),j(k)) = v(k). The max(i)-by-max(j) output matrix has space allotted for
            length(v) nonzero elements. sparse adds together elements in v that have
            duplicate subscripts in i and j.
        
            % in pratica sparse() elimina da una matrice gli zeri per liberare
            % memoria, tenendo da conto le coordinate punto punto per ogni
            % elemento diverso da 0 (zero)
        %}
        
        % con repmat sto creando dei vettori (l x 1), cioè colonne con 'l' elementi
        singleElement = sparse(repmat((ind_x+1):(ind_x+l),l,1),...     
           repmat((ind_y+1):(ind_y+l),l,1)',ones(l,l),n,n);    
            % dal momento in cui il secondo vettore (quello creato dal secondo "repmat") è trasposto, io piazzo gli "1" in un blocco,
            % e non sulla diagonale
       % sistemo su una colonna di Base la singleElement
       Base = Base + sparse(1:n^2,(i+(j-1)*(n/l)) * ones(1,n^2), singleElement(:), n^2, (n/l)^2);
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
Im_new = uint8(cat(3, reshape(vecRed_new,n,n),reshape(vecGreen_new,n,n),reshape(vecBlue_new,n,n)));



%}





% provo a invertire l'immagine - SUCCESSO!

%{
Prima spezzavo tutto, poi ho scritto una funzione (revIm) che prende in input
un'immagine e fa tutto da sola

----- INVERTIRE -----

RevRed = reverse(double(Red));
RevGreen = reverse(double(Green));
RevBlue = reverse(double(Blue));

Im_rev = uint8(cat(3,RevRed,RevGreen,RevBlue));

----- RIBALTARE -----

upSideRed = upsideDown(double(Red));
upSideGreen = upsideDown(double(Green));
upSideBlue = upsideDown(double(Blue));

Im_upDown = uint8(cat(3,upSideRed,upSideGreen,upSideBlue));

----- RIBALTARE e INVERTIRE -----

upSideRevRed = upDownRev(double(Red));
upSideRevGreen = upDownRev(double(Green));
upSideRevBlue = upDownRev(double(Blue));

Im_upDownRev = uint8(cat(3,upSideRevRed,upSideRevGreen,upSideRevBlue));
%}

% provo a sgranare l'immagine

Im_new = sgrana(I,16);

% provo a ribaltare l'immagine - SUCCESSO
Im_rev = revIm(I);

% provo a ribaltare  l'immagine - SUCCESSO
Im_upDown = upSideIm(I);

% provo a ribaltare e invertire l'immagine - SUCCESSO
Im_upDownRev = upDownRevIm(I);


%stampo a schermo
figure,
subplot(2,3,1), imagesc(I);
subplot(2,3,2), imagesc(Im_new);
subplot(2,3,3), imagesc(Im_rev);
subplot(2,3,4), imagesc(Im_upDown);
subplot(2,3,5), imagesc(Im_upDownRev);

%{

N = 3 * n^2;
coeff_original = cat(1,vecRed,vecGreen,vecBlue);
Base_original = sparse(1:N,1:N, ones(1,N),N,N); % è la matrice identità

% Per scambiare i colori devo scambiare la parte di Base relativa al colore
% x con quella relativa al colore y

r = 1:n^2;
g = n^2+1:2*n^2;
b = 2*n^2+1:N;
               
Base_new = cat(2, Base_original(:,b),...
    Base_original(:,r),...
    Base_original(:,g));

%{
    per normalizzare: (1/sqrt(2)*Base_original (ripetto davanti ad ogni Base_original)

    Base_new = cat(2, (1/sqrt(2))*Base_original(:,b),...
        (1/sqrt(2))*Base_original(:,r),...
        (1/sqrt(2))*Base_original(:,g));
%}



vec_new = Base_new * coeff_original;

% per tornare  all'immagine originale:
%   coeff_new = Base_new\
%   
vecRed2_new = vec_new(r);
vecGreen2_new = vec_new(g);
vecBlue2_new = vec_new(b);

Im_new = uint8(cat(3, reshape(vecRed_new,n,n),...
                      reshape(vecGreen_new,n,n),...
                      reshape(vecBlue_new,n,n)));

figure,
subplot(2,3,1), imagesc(I);
subplot(2,3,2), imagesc(Im_new);


%  voglio produrre del rumore nell'imamgine

w = 0.5;
shift = 0.75;

random_map = sparse(1:n^2,...
                rand(n^2,1)*w+shift, n^2, n^2);
            
vecRed_new = random_map * vecRed;
vecGreen_new = random_map * vecGreen;
vecBlue_new = random_map * vecBlue;

Im_new = uint8(cat(3, reshape(vecRed_new,n,n),...
                      reshape(vecGreen_new,n,n),...
                      reshape(vecBlue_new,n,n)));

                  
shift_map = sparse(mod((1:n^2)+200,n^2)+1,...
                rand(n^2,1)*w+shift, n^2, n^2);
            
vecRed_new = shift_map * vecRed;
vecGreen_new = shift_map * vecGreen;
vecBlue_new = shift_map * vecBlue;

Im_new = uint8(cat(3, reshape(vecRed_new,n,n),...
                      reshape(vecGreen_new,n,n),...
                      reshape(vecBlue_new,n,n)));

figure,
subplot(2,3,1), imagesc(I);
subplot(2,3,2), imagesc(Im_new);

%}
            