function distanceArray = H_DistanceComputation (input)
% computing distance between words
%   for computing distance between words, we walk o on the curve obtaining
%   from prevoius step. every where we have a change from 0 to 1 on 
%   morphological shape, we start counting the pixel to next morphological 
%   shape. these is the distance between the words.
inputB = input>0;
[M, N] = size (input);
no = 0;
distanceArray =0;
for i=1:N
    vector = inputB(:,i);
    temp = zeros(1,2);
    count = 0;
    if nnz (vector)==2
        for j=1:M
            if vector(j)==1
                count = count+1;
                temp(count) = j;
                if count ==2
                    no = no+1;
                    distanceArray(no) = (temp(2) - temp(1));
                    break;
                end
            end
        end
    end
end

end

