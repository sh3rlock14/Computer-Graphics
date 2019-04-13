%%
clear all
close all
clc


M = load_off('./meshes/tr_reg_000.off');

% --- distEuclid è lento, uso QuickDstEu
%f1 = distEuclid(M);
f = QuickDistEu(M);

% --- f2 è equivalente a f      (NON NE SONO SICURO AL 100%)
%f2 = sum(pdist2(M.VERT, M.VERT),2);
% 

% --- f3 è equivalente a f
%f3 = zeros(M.n,1);
%for i=1:M.n
%    f3(i) = sum(pdist2(M.VERT(i,:),M.VERT));
%end

% Colormap Blue White Red --- Successo

n = 500;

r1 = linspace(0,1,n/2)';
r2 = linspace(1,1,n/2)';

g1 = linspace(0,1,n/2)' ;
g2 = linspace(1,0, n/2)';

b1 = linspace(1,1,n/2)';
b2 = linspace(1,0,n/2)';


r = [r1;r2];
g = [g1;g2];
b = [b1;b2];

bluewhitered = [r,g,b];

%plot(1:10), colorbar

h = plot_mesh(M,f);
colormap(bluewhitered)
shading interp;
%{
FaceColor interp;
FaceAlpha 1;
EdgeColor 'none';
LineStyle '-';
%}