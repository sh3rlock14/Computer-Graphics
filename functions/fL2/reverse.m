function outputArg1 = reverse(A)
%{
REVERSE: la Matrice A viene invertita (ne viene calcolato lo speculare rispetto l'asse x)
  Detailed explanation goes here
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
reversed = A*Rev;
outputArg1 = reversed;

end

