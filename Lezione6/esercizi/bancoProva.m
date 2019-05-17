%%
clear all
close all
clc


A = [1 0 0 ; 0 1 1 ; 1 0 1 ];
nVettori = size(A,2);       % calcolo il numero di colonne (quindi il numero di vettori)

for j=1:nVettori
    matCopia = repelem(A(:,j),1,size(A,2));     % creo una copia 1 x size(A,2), ovvero tanti quanti sono i vettori
    matDiff =  sum(sqrt(sum((A - matCopia).^2)))/nVettori; % è la matrce che salverà le differenze tra i punti della shape con il punto su cui sto iterando
    vettDist(j) = matDiff;
end
