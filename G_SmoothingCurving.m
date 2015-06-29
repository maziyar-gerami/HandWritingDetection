function [temp,posArray] = G_SmoothingCurving( LL )
%drawing a curve for background of handwriting 

%   here the curve of handwriting will be draw. the straming form of
%   handwriting that obtained from previous step has a  continus form. if
%   we compute the middle pixel of that object for each column, we will
%   have a curve. the output of this function is the object that it create
%   and an array containing position of each pixel
[M, N] = size (LL);
temp = zeros(M,N);
count = 1;
%for each column, find the first and last pixel that containing label for
%that line and then compute mean of the. actually i find middle pixel for
%each column
maxim = max (LL(:));
 for i=1 :maxim
     for j=1:N
         first = 0;
         last =0;
         for k=1:M-1
             if (LL (k,j) == 0) && (LL(k+1,j)== i)
                 first = k;
             end
             if (LL (k,j) == i) && (LL(k+1,j)== 0)
                 last = k;
             end
             if first ~=0 && last ~=0
                 temp(round ((first+last)/2),j) = i;
                 posArray(count,1) = round ((first+last)/2);
                 posArray(count,2) = j;
                 count = count+1;
                 break;
             end
         end
     end
 end

end

