function outputArg1 = upSideIm(I)


upSideRed = upsideDown(double(I(:,:,1)));
upSideGreen = upsideDown(double(I(:,:,2)));
upSideBlue = upsideDown(double(I(:,:,3)));

Im_upSide = uint8(cat(3,upSideRed,upSideGreen,upSideBlue));

outputArg1 = Im_upSide;

end