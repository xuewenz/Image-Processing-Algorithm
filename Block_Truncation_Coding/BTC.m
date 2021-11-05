%BTC Improved Code
%Tan Xue Wen(F10607004)

clc;clear all;close all;

Image = imread('lena.bmp');
[row, col] = size(Image);
x = Image;
x = double(x);
N = 16;
Area = N*N;
y = zeros(row,col);

for p = 0 : N : row-1
    for q = 0 : N : col-1
        sum_x = 0;
        sum_x_sq = 0;
        for a = 0 : 1 : N-1
            for b = 0 : 1 : N-1
                sum_x = sum_x + x(p+a+1,q+b+1);
                sum_x_sq = sum_x_sq + (x(p+a+1,q+b+1))^2;
            end
        end
        mean = sum_x / Area;
        mean_sq = sum_x_sq / Area;
        Var = mean_sq - (mean^2);
        Std_Dev = sqrt(Var);
        Bitmap = zeros(N,N);
        q_num = 0;
        
        for a = 0 : 1 : N-1
            for b = 0 : 1 : N-1
                if x(p+a+1,q+b+1) > mean
                    Bitmap(a+1,b+1) = 1;
                    q_num = q_num + 1;
                else
                    Bitmap(a+1,b+1) = 0;
                end
            end
        end
        
        Lower_Limit = mean - Std_Dev*(sqrt(q_num/(Area-q_num)));
        Upper_Limit = mean + Std_Dev*(sqrt((Area-q_num)/q_num));
        
        Lower_Limit = round(Lower_Limit);
        Upper_Limit = round(Upper_Limit);
        
        for a = 0 : 1 : N-1
            for b = 0 : 1 : N-1
                if Bitmap(a+1,b+1) == 1
                    y(p+a+1,q+b+1) = Upper_Limit;
                else
                    y(p+a+1,q+b+1) = Lower_Limit;
                end
            end
        end
    end
end


y = uint8(y);
imshow(y)
        
psnr(y,Image,255)
