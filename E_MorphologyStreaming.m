function  [MO , ST] =  E_MorphologySreaming( thickness , f )
%this function draw morphological and streaming form of handwriting


% 1) fill holes less than 50
f = imcomplement (f);
open = bwareaopen(f , 65);
% 2) rectangural morphology
se = strel ('rectangle' , [3*thickness , 4*thickness]);
MO = imdilate (open , se);
% 3) streaming
sd = strel ('line', 50, 0);
ST = imclose(MO,sd);
%closeBW = imcomplement(closeBW);

end


