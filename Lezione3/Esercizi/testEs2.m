%%
clear all
close all
clc

% è un tensore a 3 livelli che contiene matrici 1 x 3
vertici = zeros(1,2,3); % è uun tensore 1 x 2 x 3
for x=1:3
    fprintf('\nPunti mancanti: %d\nUtilizza le []\n',3-(x-1));
    prompt = input('Inserisci le coordinate di un punto2D: ');
    vertici(:,:,x) = prompt;
end


for x=1:3
    fprintf('\nColori mancanti: %d\n',3-(x-1));
    prompt = input('Inserisci un colore per il vertice indicandolo con la lettera identificativa tra '''' (singoli apici):\nScegli tra: red(r) blue(b) green(g) yellow(y) black(k) magenta(m) cyan(c):\n');
    colors{x} = prompt;
end

nearestNeighbor(vertici, colors);

