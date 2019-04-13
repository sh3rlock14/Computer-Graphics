function nearestNeighbor(Tensore, colors)
    v1.COORD = Tensore(:,:,1);
    v2.COORD = Tensore(:,:,2);
    v3.COORD = Tensore(:,:,3);

    x = [v1.COORD(1) v2.COORD(1) v3.COORD(1)];
    y = [v1.COORD(2) v2.COORD(2) v3.COORD(2)];

    c = centroide2D(v1,v2,v3);
    medL = mediana2D(v1,v2);
    medR = mediana2D(v2, v3);
    medD = mediana2D(v1,v3);
    
  
    xUP = [x(2) medL(1) c(1) medR(1)];
    yUP = [y(2) medL(2) c(2) medR(2)];

    xLE = [x(1) medL(1) c(1) medD(1)];
    yLE = [y(1) medL(2) c(2) medD(2)];

    xRI = [x(3) medR(1) c(1) medD(1)];
    yRI = [y(3) medR(2) c(2) medD(2)];
    
    hold on
    fill(xUP,yUP,colors{1});
    fill(xLE,yLE,colors{2});
    fill(xRI,yRI,colors{3});
    
end


