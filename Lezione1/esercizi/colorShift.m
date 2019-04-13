%%
clear all
close all
clc

I = imread('./sthings.png');

J = I;

J(:,:,2) = 0.7*I(:,:,2);
J(:,:,3) = 0.9*I(:,:,3);

figure
subplot(121), imshow(I);
subplot(122), imshow(J);