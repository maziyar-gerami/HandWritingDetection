function out = I_VerticalComponents( IM, LL , thickness )
%extracting vertical compnents of image

IM = logical(IM);
IM = imcomplement (IM);
st = strel('arbitrary', ones(5,2)); %create ones(5,2) matrix as a structure
out = imerode (IM , st);    % remove every thing except them
out = bwareaopen (out , thickness);
se = strel ('rectangle' , [4 , 3]); %create rectangle (4,3) matrix as a structure
out = imdilate (out , se);  %replace the pixels with se struct to connect some components
out = imcomplement (out);
                        
                                
end

