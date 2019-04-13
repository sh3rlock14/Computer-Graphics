%%
clear all
close all
clc

v1 = vertex3D(0,0,1);
v2 = vertex3D(10,0,2);
v3 = vertex3D(0,6,3); 

tri = triangle(v1,v2,v3);

v4 = vertex3D(2,3,4);
v5 = vertex3D(6,4,6);
v6 = vertex3D(3,5,7);

tri2 = triangle(v4,v5,v6);

tri3 = triangle();

area1 = calcArea(tri);
area2 = calcArea(tri2);

%'shuffle' randomizza la creazione dei numeri ad OGNI run
%rng('shuffle');
%x = randi([0 100],1, 3);

row = 5;
column = 3;

% M è una matrice di vertici 1 x 3
M = [v4 v5 v6]; 

% V è una matrice in cui salvo oggetti di tipo triangolo: se non avessi
% specificato il tipo, nel for loop il compilatore NON sarebbe riuscito a
% castare gli oggetti "triangle" in double (tipo di default che si aspetta)

V = triangle;

for c = 1:column
    for r = 1:row
        V(r,c) = triangle();
        V(r,c).area = calcArea(V(r,c));
    end
end

%
% [x,y] = meshgrid(1:10,1:10);
% trig = delaunay(x,y);
% z = peaks(10);
% trisurf(trig,x,y,z);
%

v8 = vertex3D(-69.306118440027480,-85.373260740967110,-84.302077852078750);
v9 = vertex3D(-89.563599464001530,10.967809493983860,43.680146824673294);
v10 = vertex3D(-96.989844403591970,96.256544780547150,-10.746941653716790);

triTest = triangle(v8,v9,v10);
areaTest = calcArea(triTest);
