function outputArg1 = revIm(I)

%Red = I(:,:,1);     % considero i rossi, pixel per pixel
%Green = I(:,:,2);   % considero i verdi
%Blue = I(:,:,3);    % considero i blu

RevRed = reverse(double(I(:,:,1)));
RevGreen = reverse(double(I(:,:,2)));
RevBlue = reverse(double(I(:,:,3)));

Im_rev = uint8(cat(3,RevRed,RevGreen,RevBlue));

outputArg1 = Im_rev;

end