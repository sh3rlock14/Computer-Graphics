%%

%matrice identità
I = eye(3);

%matrice di una Permutazione
P = [0 1 0; 0 0 1; 1 0 0];

%vettore generico
v = [1 2 3];

%permutazioni
vPerm = P*v';
vNotPerm = I*v';

%vettore indicatore
vIndicatore = [0 0 1];

%permutazione
vIndPerm = P*vIndicatore';