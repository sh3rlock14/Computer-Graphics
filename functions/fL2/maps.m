%%
clear all
close all
clc


I = imread('./win.png');
I = double(I(1:5,1:5,:));

Red = I(:,:,1);
Green = I(:,:,2);
Blue = I(:,:,3);

RevRed = reverse(Red);
RevGreen = reverse(Green);
RevBlue = reverse(Blue);

revI = uint8(cat(3,RevRed,RevGreen,RevBlue));

I = uint8(I);
figure,
subplot(1,2,1), imshow(I);
subplot(1,2,2), imshow(revI);