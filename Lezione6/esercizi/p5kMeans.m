%%
% Voglio l'immagine come nuvola di punti di colore -> la nuvola esiste
% nelle 3 dimensoni (una per colore)
I = imread('./images/p5.png');

%è una funzione anonima: mi permette di scrivere come vettore colonna un vettore riga
col = @(x) x(:);

r = col(I(:,:,1));

g = col(I(:,:,2));

b = col(I(:,:,3));


rgb = [r,g,b];


%%
%provo a riorindare terne di colori

T = [255 255 255;0 0 0;10 20 30; 10 21 30; 11 20 30; 11 20 29];

Ts = sort(T, 'ascend');

%%
%{
% Visualizzo come una nuvola di punti di colore rosso
figure, plot3(r,g,b,'r.')
axis equal
%}

%%
%{
figure
scatter3(r,g,b,40,double(rgb)./255,'fill')
axis equal
xlabel('r')
ylabel('g')
zlabel('b')
%}
%%
% Produco l'istogramma 3d
n = 20;
%[~,c,s] = kmeans(double(rgb),n);
s = 100000;
myC = myKmeans(double(rgb),n);

% Visualizzo l'istogramma
figure
% myScatter richiama scatter3, gli passo semplicemente meno valori
%h = myScatter(c,s);

h = myScatter(myC,s)
% --- se chiudo l'immagine che riproduce l'istogramma, non posso più
% accedere ai suoi valori (come CData)
%h = scatter3(c(:,1),c(:,2),c(:,3),s*1e-2,c./255,'fill')
axis equal
xlabel('r')
ylabel('g')
zlabel('b')

% qui dentro salvo i punti colore dell'immagine (nb: qui i punti colore sono già clusterizzati)
data = h.CData;
dataX = h.XData;
dataY = h.YData;
dataZ = h.ZData;




