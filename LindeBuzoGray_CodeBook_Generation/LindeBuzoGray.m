%LBG_Algorithm  %Debugged
%Tan Xue Wen(F10607004)
clc;clear all;close all;

%Part 1 Initialization

Image = imread('lena.bmp');
x = Image;
[row, col] = size(Image);

%Number of pixels
TotalPixels = row*col;

%8*8 Pixels per set
Pixels = 32;
SetPixels = Pixels*Pixels;

%Number of Set
Num_Set = TotalPixels/SetPixels;

%CodeBook Size
Codebook_Size = 64;

%Array of Sets
Total_Sets = zeros(Num_Set,SetPixels);
value_index = 1;
set_index = 1;

%Allocating Sets Value
for i = 1 : Pixels : row %outer
    for j = 1 : Pixels : col
        for a = i : 1 : i + Pixels - 1 %Subset
            for b = j : 1 : j + Pixels - 1
                
                Total_Sets(set_index,value_index) = Image(a,b);
                value_index = value_index + 1;
                
            end
        end
        value_index = 1;
        set_index = set_index + 1;
    end
end

RandomNums = randi(Num_Set,1,Codebook_Size);
Codebook = zeros(Codebook_Size,SetPixels);

%Initial Codebook
for i = 1 : 1 : Codebook_Size
    for j = 1 : 1 : SetPixels
        
        Codebook(i,j) = Total_Sets(RandomNums(1,i),j);
        
    end
end

%Part 2 Processes


y = 1;
dist = 1;
dist_prev = 1;
error = 1;
iterations = 0;

%Training Samples 
T_Size = Num_Set;
Training = zeros(T_Size,SetPixels);
Training = Total_Sets;

while error > 0.0005


dist_prev = dist;

%Training vs CodeBook
Valuediff = zeros(T_Size,Codebook_Size);
for i = 1 : 1 : T_Size
    for a = 1 : 1 : Codebook_Size
        for b = 1 : 1 : SetPixels
            Valuediff(i,a) = Valuediff(i,a)+((Training(i,b) - Codebook(a,b))^2); %Sum of Distance for 64 codebook
        end
    end
end

ClosestDistV = zeros(T_Size,1); %ClosestValue for each Training Sets

for i = 1 : 1 : T_Size
    ClosestDistV(i,1) = min(Valuediff(i,:));
end


%Getting The Codebook_Index of the closest Match (checked)
ClosestMatch_Index = zeros(T_Size,1);

for i = 1 : 1 : T_Size
    for j = 1 : 1 : Codebook_Size
        
        if(Valuediff(i,j) == ClosestDistV(i,1))
            ClosestMatch_Index(i,1) = ClosestMatch_Index(i,1) + 1;
            break;
        else
            ClosestMatch_Index(i,1) = ClosestMatch_Index(i,1) + 1;
        end
        
    end
end


%Length For Averaging (checked)
ClosestMatch_Length = zeros(Codebook_Size,1);
Counter = 0;
for i = 1 : 1 : Codebook_Size
    Counter = Counter + 1;
    for j = 1 : 1 : T_Size
        if Counter == ClosestMatch_Index(j,1)
            ClosestMatch_Length(i,1) = ClosestMatch_Length(i,1) + 1;
        end
    end
end

%Generating New CodeBook
CodebookNew_Sum = zeros(Codebook_Size,SetPixels);
for i = 1 : 1 : Codebook_Size
    for a = 1 : 1 : T_Size
        if ClosestMatch_Index(a,1) == i
            for j = 1 : 1 : SetPixels
                CodebookNew_Sum(i,j) = CodebookNew_Sum(i,j) + Training(a,j);
            end
        end
    end
end

CodebookNew = zeros(Codebook_Size,SetPixels);
for i = 1 : 1 : Codebook_Size
    for j = 1 : 1 : SetPixels
        if ClosestMatch_Length(i,1) == 0
            CodebookNew(i,j) = Codebook(i,j);
        else
        CodebookNew(i,j) = CodebookNew_Sum(i,j)/ClosestMatch_Length(i,1);
        end
    end
end
%Correct
Codebook = CodebookNew; 


%Part 4 Calculating Distortion
dist = sum(sum(Valuediff))/(Codebook_Size*SetPixels);
error = abs(dist_prev - dist);
error = error/dist_prev

iterations = iterations + 1

end
%CodeBook Generation Checked (No Error)

% Part 5 Output
IndexCounter=1;
Output = zeros (row,col) ;

for i=1 : Pixels : row
    for j=1 : Pixels :col    
        index=ClosestMatch_Index(IndexCounter,1);        
        l=1;       
        for a=0:Pixels-1        
            for b=0:Pixels-1          
                Output(i+a,j+b)=Codebook(index,l);           
                l = l + 1;          
            end                    
        end        
        IndexCounter=IndexCounter+1;
    end
end

Output=uint8(Output);
imshow(Output);
imwrite(Output,'Lena_VQ_N32_C64.bmp');
y = Output;
Gauss_img = imgaussfilt(y,1.3); %GaussianFilter
HPSNR = psnr(Gauss_img,x,255)

