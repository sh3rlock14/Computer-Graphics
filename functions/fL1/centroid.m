function outputArg1 = centroid(M,v1,v2,v3)
    v1 = M.VERT(v1,:);  % ho un array contenente le coordinate x y z del primo vertice 
    v2 = M.VERT(v2,:);  % ho un array contenente le coordinate x y z del primo vertice
    v3 = M.VERT(v3,:);  % ho un array contenente le coordinate x y z del primo vertice
    xC = (v1(1) + v2(1) + v3(1))/3;
    yC = (v1(2) + v2(2) + v3(2))/3; 
    zC = (v1(3) + v2(3) + v3(3))/3; 
    outputArg1 = [xC yC zC];
end
