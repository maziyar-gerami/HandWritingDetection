function  g  = C_NoiseReduction(thickness , f )
%this function, reduces the image noise

% this function reduces the image noise, using remove the components that
% they are smaller than thickness*thickness and larger than 
% 5*thickness*thickness 
f = imcomplement (f);
open = bwareaopen(f , 5*thickness*thickness);
g = imcomplement (open);
end

