%BTC_ED Reference from Prof Guo Journal
%Tan Xue Wen(F10607004)
%Final

clc;clear all;close all;

Image = imread('lena.bmp');
[row, col] = size(Image);
x = Image;
input = Image;
x = double(x);
N = 8;
Area = N*N;
y = zeros(row,col);

for p = 0 : N : row - 1
    for q = 0 : N : col- 1
        sum_x = 0;
        sum_x_sq = 0;
        Max = 0;
        Min = 255;
        
        for a = 1 : 1 : N
            for b = 1 : 1 : N
                if Max < x(p+a,q+b)
                    Max = x(p+a,q+b);
                end
                if Min > x(p+a,q+b)
                    Min = x(p+a,q+b);
                end
                sum_x = sum_x + x(p+a,q+b);
                sum_x_sq = sum_x_sq + (x(p+a,q+b))^2;
            end
        end
        
        Mean = sum_x / Area;
        
        for a = 1 : 1 : N
            for b = 1 : 1 : N
                
                if x(p+a,q+b) > Mean
                    error = x(p+a,q+b) - Max;
                    x(p+a,q+b) = Max;
                else
                    error = x(p+a,q+b) - Min;
                    x(p+a,q+b) = Min;
                end
                
                if q == 0 && b == 1 && (p+a) < row %Left Boundary
                    x(p+a,q+b+1) = x(p+a,q+b+1)+error*(7/16);
                    x(p+a+1,q+b) = x(p+a+1,q+b)+error*(5/16);
                    x(p+a+1,q+b+1) = x(p+a+1,q+b+1)+error*(1/16);
                elseif q == (col-N) && b == N && (p+a) < row %Right Boundary
                    x(p+a+1,q+b-1) = x(p+a+1,q+b-1)+error*(3/16);
                    x(p+a+1,q+b) = x(p+a+1,q+b)+error*(5/16);
                elseif p == (row-N) && a == N && q+b < col %Last Row Boundary
                    x(p+a,q+b+1) = x(p+a,q+b+1)+error*(7/16);
                elseif p == (row-N) && a == (N) && q == (col-N) && b == N %BottomLeft
                    
                else
                    x(p+a,q+b+1) = x(p+a,q+b+1)+error*(7/16);
                    x(p+a+1,q+b) = x(p+a+1,q+b)+error*(5/16);
                    x(p+a+1,q+b-1) = x(p+a+1,q+b-1)+error*(3/16);
                    x(p+a+1,q+b+1) = x(p+a+1,q+b+1)+error*(1/16);
                end
            end
            
        end
    end
end

y = uint8(x);
imshow(y);
Gauss_img = imgaussfilt(y,1.3); %GaussianFilter
HPSNR = psnr(Gauss_img,imgaussfilt(Image,1.3),255)
