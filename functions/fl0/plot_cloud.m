%{
utilizzo questa funzione per plottare su una mesh dei punti
"notevoli", come i furtest points sampling
%}

function plot_cloud(M,samples,color)
%PLOT_CLOUD Summary of this function goes here
%   Detailed explanation goes here
figure,
plot_mesh(M);
axis equal;
hold on
scatter3(samples(:,1),samples(:,2),samples(:,3),color)
end

