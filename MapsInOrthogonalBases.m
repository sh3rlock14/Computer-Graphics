%%
%B = [1/3 2/3 2/3; 2/3 1/3 -2/3; 2/3 -2/3 1/3];

%T � la matrice delle Permutazioni  
T = [0 0 1; 0 1 0; 1 0 0];

%A � una matrice ortogonale
A = [1/3 2/3 ; 2/3 1/3; -2/3 2/3];


f = [1 2 3];

% non posso togliere A*A' perch� questo prodotto ritorna l'Identit�
% solo quando A � proprio la matrice COMPLETA delle Autofunzioni  
B_g = B'*T*f'; 

%calcolo i coefficienti in base B
B_g2 = B'*T*A*A'*f';