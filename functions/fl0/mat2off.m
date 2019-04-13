%%
clc
clear all


%dalla cartella tosca prendo tutti i file .mat
files = dir('./tosca/*.mat');
for file = files'
    % copio il nome in una vaiabile
    [~,name,~] =fileparts(strcat('./',file.name));
    fn = name;
    % se l'oggottp che sto prendendo in considerazione è un file
    if isfile(strcat('./',fn,'.mat'))
        % creo una struttura per il file .off e la impiego all'interno di
        % "save_as_off".
        % nota: Il file .off ha lo stesso nome del file .mat
        save_as_off(strcat('./meshes/',fn,'.off'),load_mat(strcat('./tosca/',fn,'.mat')))
    end
end