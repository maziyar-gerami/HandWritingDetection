function [ index , varThickness] = B_Finfing_thickness( f )
%this function can find size (thickness of hanwriting)
% in this function, we use nested 'for' for finding the most repetetive
% repetetive thicknesh of handwritiong.
[r , c] = size (f);
temp = zeros(1000,1);
count = 0;
% compute no of continus ones (thickness) vertical
for i=1: r
    for j=1:c
        if f(i,j)== false       %if it is an One, count++
            count = count +1;
        else
            if count ~= false   %and if it is 0, count=0, put number of continus 1 pixels (thickness) on temp(count)
                temp(count) = temp(count)+1;
                count = 0;
            end
        end
    end
end

% do the same thing for horizontal
count =0;
for i=1:c
    for j=1:r
        if f(j,i)==0
            count = count+1;
        else
            if count ~= 0
                temp(count) = temp(count)+1;
                count = 0;
            end
        end
    end
end

varThickness = var(temp); % finding variance of handwriting thickness
[M, index] = max(temp); % return maximum handwriting thickness as thickness
end

