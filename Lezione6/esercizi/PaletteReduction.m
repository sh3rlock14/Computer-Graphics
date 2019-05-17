%%
% Voglio l'immagine come nuvola di punti di colore -> la nuvola esiste
% nelle 3 dimensoni (una per colore)
I = imread('./images/p5.png');

col = @(x) x(:);

r = col(I(:,:,1));

g = col(I(:,:,2));

b = col(I(:,:,3));


rgb = [r,g,b];

n = 20;

% provo con kmeans MATLAB --- SUCCESSO
%[~,c,s] = kmeans(double(rgb),n);

% provo con la mia --- SUCCESSO (lento, ma SUCCESSO)
c = myKmeans(double(rgb),n);
s = 10000;
%{
figure,
myScatter(c,s)

axis equal
xlabel('r')
ylabel('g')
zlabel('b')
%}

% per ogni canale inizializzo un nuovo vettore
r2 = zeros(size(r,1),1);
g2 = zeros(size(g,1),1);
b2 = zeros(size(b,1),1);

for i=1:size(r,1)
    r2(i,:) = c(vicino(r(i,:),c));
end

for i=1:size(g,1)
    g2(i,:) = c(vicino(g(i,:),c));
end

for i=1:size(b,1)
    b2(i,:) = c(vicino(b(i,:),c));
end

r2 = uint8(r2);
g2 = uint8(g2);
b2 = uint8(b2);

I2 = cat(3,reshape(r2,size(I,1),size(I,2)),reshape(g2,size(I,1),size(I,2)),reshape(b2,size(I,1),size(I,2)));

imshow(I2);
    
    