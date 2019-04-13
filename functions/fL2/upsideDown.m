
function outputArg1 = upsideDown(A)

%{
UPSIDEDOWN: la Matrice A viene capovolta
  Detailed explanation goes here:
  - la matrice Rev è la matrice diagonale secondaria
  - Rev * A restituisce la matrice capovolta
%}

[m,n] = size(A);
Rev = zeros(m,n);
% devo sempre inserire il valore 1: inizializzare una variabile a 1 è
% ridondante
%n = 1;
%c=1;
for r=m:-1:1
        Rev(r,(m-r+1)) = 1;
        %Rev(r,c) = n;
        %c = c+1;
end
upsideDown = Rev*A;

outputArg1 = upsideDown;

end