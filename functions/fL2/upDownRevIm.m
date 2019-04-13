function outputArg1 = upDownRevIm(I)

upSideRevRed = upDownRev(double(I(:,:,1)));
upSideRevGreen = upDownRev(double(I(:,:,2)));
upSideRevBlue = upDownRev(double(I(:,:,3)));


Im_upSideRev = uint8(cat(3,upSideRevRed,upSideRevGreen,upSideRevBlue));

outputArg1 = Im_upSideRev;

end