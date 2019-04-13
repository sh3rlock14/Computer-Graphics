%%
%provo a ruotare l'istogramma dei colori di un'immagine

I = imread('./images/ralph.png');

col = @(x) x(:);


r = col(I(:,:,1));
g = col(I(:,:,2));
b = col(I(:,:,3));


rgb = [r,g,b];

figure('Name', 'Ralph''sColours')
%subplot(1,2,2), imshow(I);  %immagine originale
h = scatter3(r, g, b, 20, double(rgb)./255,'fill')  % dimensione, colore, opzioni % matlab vuole i colori in 0 e 1 
xlabel('red')
ylabel('green')
zlabel('blue')
title('Punti Colore')
%set(gca, 'XDir', 'reverse','YDir', 'reverse','ZDir', 'reverse');




rgb2 = double([r g b]);
rotateX = [1 0 0;0 0 -1;0 1 0];
rotateY = [0 0 1;0 1 0;-1 0 0];
rotateZ = [0 -1 0;1 0 0;0 0 1];


rotateAll = rotateX+rotateY+rotateZ;

%rgb2 = rgb2 * rotateX;
%rgb2 = rgb2 * rotateY;
%rgb2 = rgb2 * rotateZ;

% sembra essere il risultato corretto
rgb2 = rgb2 * rotateAll;

r2 = uint8(col(rgb2(:,1)));
g2 = uint8(col(rgb2(:,2)));
b2 = uint8(col(rgb2(:,3)));

I2 = cat(3,reshape(r2,size(I,1),size(I,2)),reshape(g2,size(I,1),size(I,2)),reshape(b2,size(I,1),size(I,2)));

figure,
subplot(2,1,1), imshow(I2)
subplot(2,1,2), scatter3(r2,g2,b2,20,double(rgb2)./255,'fill');




