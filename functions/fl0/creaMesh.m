%%
close all
clear all
clc


% funzione giocattolo per convertire "al volo" file .mat in .off
% per una conversione più veloce uso mat2off
path1 = './meshes/';
path2 = './tosca/';
mat = '.mat';
off = '.off';

animale = 'gorilla';

vettore = {'1','5','8','14'};


for i=1:length(vettore)
    save_as_off(strcat(path1,animale,vettore{i},off),load_mat(strcat(path2,animale,vettore{i},mat)));
end

