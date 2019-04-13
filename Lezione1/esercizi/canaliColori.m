%%
clear all
close all
clc

I = imread('./sthings.png');

% per ogni pixel voglio tirar fuori il canale di verde
% i : : (due punti) mi permettono di iterare per ogni riga, ogni colonna e prendere il
% secondo (2) canale: il canale verde

% l'operazione per glia ltri canali è analoga
figure
subplot(131), imshow(I(:,:,1));
subplot(132), imshow(I(:,:,2));
subplot(133), imshow(I(:,:,3));