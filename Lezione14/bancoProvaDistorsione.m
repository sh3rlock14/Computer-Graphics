%%
% ho verificato che i gatti avessero lo stesso numero di vertici: OK
% da questa informazine ho assunto che ci sia corrispondenza
% Vertice-Vertice (può essere sbagliata)
% la prima shape che viene caricata è "alien"
% io voglio usare il gatto, le cui shapes vanno dalla 2 alla 12 (inclusa)

clear all
close all
clc

dataset = './meshes';

shapes = dir(sprintf('%s/*.off', dataset));

originalCat = load_off(sprintf('%s/%s', dataset, shapes(2).name));



for i=3:12
    fprintf('Shape %d/%d\n', i, length(shapes))
    
    try
        copyCat = load_off(sprintf('%s/%s', dataset, shapes(i).name));
        dist = calc_distorsion(originalCat,copyCat);
        
        %in posizione "i" del vettore ranking ho il VALORE della distorsione
        % da copyCat ripetto a originalCat
        distorsioni(i) = dist;
    catch
        fprintf('Error with shape %s\n', shapes(i).name)
    end
end

[distorsioni_sorted, ranking] = sort(distorsioni);

%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% stampo prima la figura di riferimento
% poi stampo le figure riordinate con distorsione crescente


figure
subplot(2,5,1), plot_mesh(originalCat); axis equal; shading interp; axis off;
title('original cat');

for i=1:5
    X = load_off(sprintf('%s/%s', dataset, shapes(ranking(i+2)).name));
    subplot(2,5,5+i), plot_mesh(X); axis equal; shading interp; axis off;
    title(sprintf('%d\nVal. dist.: %f', i, distorsioni_sorted(i+2)))
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%stampo le shape così come sono ordinate all'interno della cartella

%NOTA: sembra funzionare bene!

figure
for i=1:5
    X = load_off(sprintf('%s/%s', dataset, shapes(i+1).name));
    subplot(1,5,i), plot_mesh(X); axis equal; shading interp; axis off;
    title(sprintf('%d',i))
end