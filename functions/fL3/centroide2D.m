function outputArg1 = centroide2D(v1,v2,v3)
    xC = (v1.COORD(1) + v2.COORD(1) + v3.COORD(1))/3;
    yC = (v1.COORD(2) + v2.COORD(2) + v3.COORD(2))/3; 
    outputArg1 = [xC yC];
end

