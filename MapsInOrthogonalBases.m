%%
%B = [1/3 2/3 2/3; 2/3 1/3 -2/3; 2/3 -2/3 1/3];

%T è la matrice delle Permutazioni  
T = [0 0 1; 0 1 0; 1 0 0];

%A è una matrice ortogonale
A = [1/3 2/3 ; 2/3 1/3; -2/3 2/3];


f = [1 2 3];

% non posso togliere A*A' perchè questo prodotto ritorna l'Identità
% solo quando A è proprio la matrice COMPLETA delle Autofunzioni  
B_g = B'*T*f'; 

%calcolo i coefficienti in base B
B_g2 = B'*T*A*A'*f';