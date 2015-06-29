function [A_10, A_20] = E_Segmentation( f )
%segmenting image using siging 10*10 and 20*20 blocks

% this function compute number of of 1 of 10*10 and 20*20 blocks and if
% that block has more zeros than ones, it put zero in all pixels of that
% block, else it put 1 in all of that pixels

% if more than 50% of pixels of distinct [10 10] blocks of image are 0, then put
% zero on all of them, else put 1
fun = @(block_struct) mean(block_struct.data(:));
A_10 = blockproc (f ,[10 10] , fun );
A_10 = (A_10<0.5);

% if more than 50% of pixels of distinct [20 20] blocks of image are 0, then put
% zero on all of them, else put 1
A_20 = blockproc (f ,[20 20] , fun );
A_20 = (A_20<0.5);


end



