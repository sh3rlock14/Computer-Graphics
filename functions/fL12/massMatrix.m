function M = massMatrix(X)



%numero di vertici nella mesh
n = size(X.VERT,1);


%sono le aree di tutti i triangoli
areeTriangoli = calc_Area_Triv3D(X);

%per ogni vertice, ho un "area elements" così definito:
%       a_i = 1/3 sum_Tj:vi\inTj_(A(Tj))

A = sparse(n,1);



for i=1:n
   %trovo in quali triangoli il vertice v_i
   %è presente
   idx = sum(i==X.TRIV,2);
   %vettore colonna con la dimensone maggiore pari
   %al numero dei triangoli
   idx(idx>1) = 1;
   %%%%% prova
   idx = sparse(idx');
   %%%%%
   A(i) = sum(idx*areeTriangoli)*(1/3);
end

M = sparse(diag(A));


end
    