%{
utilizzo questa funzione per plottare su una mesh dei punti
"notevoli", come i furtest points sampling
%}

function plot_cloud(M,samples,size,color)
%PLOT_CLOUD Summary of this function goes here
%   Detailed explanation goes here

%togliendo la "figure", posso definire da fuori la 
%colormap da attribuire alla shape che sto stampando

%figure,
%plot_mesh(M);
%axis equal;
%hold on

if nargin == 3
    scatter3(samples(:,1),samples(:,2),samples(:,3),size,'filled')
elseif nargin == 4
    scatter3(samples(:,1),samples(:,2),samples(:,3),size,color,'filled')
else 
    scatter3(samples(:,1),samples(:,2),samples(:,3),size,color,'filled')
    
end

end

