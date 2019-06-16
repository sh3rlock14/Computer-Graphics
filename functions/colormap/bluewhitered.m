function cmapnew = bluewhitered
%return my custom colormap


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

cmapnew = [r,g,b];


end