function [totalAngleFactor, varCurve, varDistanceBetweenWords, ...
    varAngleMozoon,VarAreaChar,VarHeight, varAngleNamosaviH,...
    varThickness, varDist, AngleFactor, VarAreaWords] = Compute( NR_input, ...
    MO_input, ST_input, LL_input, posArray, VC_input, varThick)
% 1) extracting features of khod be khod handwriting
totalAngleFactor = KhodBeKhodi (VC_input);
% 2) extracting features of yeknavakht handwriting   
varCurve = Yeknavakht (LL_input);
%3)  extracting features of Monazam handwriting
varDistanceBetweenWords = Monazam (NR_input,  posArray);
% 4) extracting features of Mozoon handwriting
[varAngleMozoon, VarAreaChar] = Mozoon (VC_input, NR_input);
% 5) extracting features of Namosavi handwriting
VarHeight = Namosavi (VC_input);
% 6) extracting features of nNamosavi horoof handwriting
varAngleNamosaviH = NamosaviHoroof (VC_input);
% 7) insert variance of thickness in varThickness variable
 varThickness = varThick;
% 8) extracting features of Namonazam handwriting
varDist = DBW (MO_input,ST_input);

% 9)  extracting features of tondoTiz handwriting
AngleFactor = TondoTiz (VC_input);

% 10)  extracting features of Nahamahang handwriting
VarAreaWords = Nahamahang (MO_input);

end

% 1) khod b khodi
% (no of 90+-5 degree angles) / (all angles of vertical components)
function totalAngleFactor = KhodBeKhodi (VC_input)
    straight=0;
    VC_C = imcomplement(VC_input);
    BB = regionprops (VC_C, 'Orientation');
    for i=1: length(BB)
        if abs(BB(i).Orientation)>= 85 && abs(BB(i).Orientation)<=90
            straight = straight+1;
        end
    end
    totalAngleFactor = straight/length(BB);
end
    

% 2) yeknavakht
% computing variance of curve
function totalVar = Yeknavakht (LL_input)
countc=0;
[M, N] = size (LL_input);
    for j=1:N
        for i=1:M
            if LL_input(i,j) == 1
                countc = countc+1;
                varArray(countc) = i;
            end
        end
    end

totalVar = var(varArray);
end 


% 3) Monazam
% computing variance of distance between words
function varDistanceBetweenWords = Monazam (MO_input, posArray)

c=0;
countc =0;
for i=1: length(posArray)-1
    if (MO_input(posArray(i,1),posArray(i,2)) ==0) ...
            && (MO_input(posArray(i+1,1), posArray(i+1,2)) ==1)
        c= c+1;
        countc(c) = 0;
        i=i+1;
         while MO_input(posArray(i,1),posArray(i,2)) ==1 && (i< length(posArray))
            countc(c) = countc(c)+1;
            i= i+1;
         end
    end

end
varDistanceBetweenWords = var(countc);
end

% 4) Mozoon, Hamgen, Ekhtelaf Jozee

% compute angle of each vertical part
function [varAngle, totalVarArea] = Mozoon (VC_input, NR_input)
VC_C = imcomplement(VC_input);
    BB = regionprops (VC_C, 'Orientation');
temp = zeros (1,length(BB));
for i=1: length(BB)
            temp(i) = abs(BB(i).Orientation);
end
varAngle = var(temp);

% computing variance of  of areas

NR_C = imcomplement(NR_input);
BB = regionprops (NR_C, 'Area');

for i=1: length (BB)
    temp(i) = BB(i).Area;
    
end
totalVarArea = var (temp);

end


% 5) Namosavi 
% computing variance of words' height using bounding box and morpholigical
% form of words
function totalVarHeight = Namosavi (VC_input)
VC_C = imcomplement (VC_input);
height=0;
BB = regionprops (VC_C, 'BoundingBox');
for i=1: length (BB)
    temp = BB(i).BoundingBox;
    height(i) = temp(4);
end
totalVarHeight = var (height);
end

% 6) Kham shodan namosavi horoof
% computing variance of angles of vertical components
function varAngle = NamosaviHoroof (VC_input);
VC_C = imcomplement(VC_input);
    BB = regionprops (VC_C, 'Orientation');
temp = zeros (1,length(BB));
for i=1: length(BB)
            temp(i) = abs(BB(i).Orientation);
end
varAngle = var(temp);
end

% 7) variance of thickness that cumputed in B_finding_thickness as
% varThickness;

% 8) Distance between Words
% computing distance between bounding box of morphological form of words
% using bounding box an compute variance of them
function varDist = DBW (MO_input, ST_input)
varDist=0;
BB = regionprops(ST_input, 'BoundingBox')
MO_C_C = imcrop(MO_input,BB(1).BoundingBox );

BBN = regionprops(MO_C_C, 'BoundingBox');
for i=1 : length(BBN)
    St = BBN(i).BoundingBox;
    currentObjectVEdge(i) = St(1)+St(3);
    if i>1
        distArray(i-1) = abs (currentObjectVEdge(i-1) - St(1));
        varDist = var (distArray);
    end
end
  
end

        

% 9) Tond o tiz
function AngleFactor = TondoTiz (VC_input)
straight =0;
    VC_C = imcomplement(VC_input);
    BB = regionprops (VC_C, 'Orientation');
    for i=1: length(BB)
        if abs(BB(i).Orientation)>= 0 && abs(BB(i).Orientation)<=70
            straight = straight+1;
        end
    end
    AngleFactor = straight/length(BB);
end


% 10) Nahamahang
% computing area of morphological form of words and computing variance of
% them
function totalVarArea = Nahamahang (MO_input)
%MO_C = imcomplement(MO_input);
st = regionprops(MO_input, 'Area');
for i=1: length(st)
    areaVar(i) = st(i).Area;
end
totalVarArea = var (areaVar);
end






