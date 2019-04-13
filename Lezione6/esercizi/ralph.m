% viene caricata in uint di default
% nel ciclo for converto in double per effettuare la norma
I = imread('./ralph.png');

% scelgo un punto
% di default è double
p = [0 0 255];


% voglio calcolare la distanza da p a tutti gli altri

D = zeros(size(I,1),size(I,2));

for x=1:size(I,1)
    for y=1:size(I,2)
        D(x,y) = norm( p(:) - double(squeeze(I(x,y,:))) );    % matlab crea un vettore 1 x 1 x 3 -> devo squeezarlo
    end
end

% D contiene una nuova immagine ricavata da quella originale
D = (D - min(D(:))) ./  (max(D(:)) - min(D(:)));

% queste sono le distanze dal colore "p"  a tutto il resto
%imshow(D)


% Definisco l'adiacenza per il punto p

A = D;
t = 0.2;
A(D<=t) = 1;
A(D>t) = 0;

% i pixel bianchi sono i pixel vicini a p
% quelli neri sono lontani

figure, imshow(A)



