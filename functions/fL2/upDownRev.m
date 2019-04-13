function outputArg1 = upDownRev(A)

%{
UPSIDEDOWNREV: la Matrice A viene capovolta
  Detailed explanation goes here:
  - chiamo le funzioni upsideDown(A) e reverse(A) in sequenza per ottenere
  un'immagine ribaltata e specchiata
%}

upDown = upsideDown(A);
upDownrev = reverse(upDown);
outputArg1 = upDownrev;

end