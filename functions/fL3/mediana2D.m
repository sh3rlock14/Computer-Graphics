function outputArg1 = mediana2D(v1,v2)
    xC = (v1.COORD(1) + v2.COORD(1))/2;
    yC = (v1.COORD(2) + v2.COORD(2))/2; 
    outputArg1 = [xC yC];
end
