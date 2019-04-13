function shape = load_off(filename)

shape = [];

f = fopen(filename, 'rt');

n = '';
while isempty(n)
    fgetl(f);       % legge riga dopo riga il file, troncando il carattere \n
    n = sscanf(fgetl(f), '%d %d %d');
end

nv = n(1);      % si salva il numero di vertici, indicato come primo valore all'interno del file .off
nt = n(2);      % si salva il numero di triangoli, indicato come secondo valore all'interno del file .off
data = fscanf(f, '%f');     % inizia a leggere il resto del file, ovvero le coordinate dei vertici, riga per riga
                            % i vertici sono floating point
if length(data) == nv*3+nt*4
    %{
    A(n,m) = zeros() crea una matrice A  n (righe) x m (colonne)
    
    A(rs:re, cs:ce) = [val1...valN; ... ; Val1...ValN]      dalla riga "rs"
    alla "re", dalla colonna "cs" alla "ce" setta le celle di A con i
    valori espressi tra le [].
    
    A(x:y, w:z) = val;  setto a val le celle dalla riga "x" a "y" dalla colonna "w" alla colonna "z"
    
    A(1:end) = val;     setto a val tutte le celle della matrice
    
    A(1:x:end) = val;   setto a val tutte le celle della matrice (a partire dalla cella in alto a sx, fino in basso
                        a dx, modificando la matrice colonna per colonna con "passo" x, cioè: setto la cella a val
                        ogni x celle)
    %}
    data(3*nv+1:4:end)=[];    % a partire dalla riga 3*nv+1 fino alla fine, con passo 4 setto la cella a []      
elseif length(data) ~= nv*3+nt*3    % returns a logical array with elements set to logical 1 (true) where arrays A and B are not equal; 
                                    % otherwise, the element is logical 0 (false).
                                    % in THIS CASE, tests for inequality
    fclose(f);
    error('load_off(): The mesh seems to be composed of non-triangular faces.');
end

shape.TRIV = reshape(data(end-3*nt+1:end), [3 nt])';
data = data(1:end-3*nt);
data = reshape(data, [length(data)/nv nv]);
shape.VERT = data'; % computes the complex conjugate transpose of data.

fclose(f);

if min(min(shape.TRIV))==0
    shape.TRIV = 1+shape.TRIV;
end

shape.n = size(shape.VERT,1);
shape.m = size(shape.TRIV,1);

end