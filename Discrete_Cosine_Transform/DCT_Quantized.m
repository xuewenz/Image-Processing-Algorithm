%DCT II by 1D DCT Method Block
%Tan Xue Wen(F10607004)
clc;clear all;close all;

Image = imread('lena.bmp');
[row, col] = size(Image);
x = Image;
x = double(x);
y_test = zeros(row,col);
N = 8;
y_DCTX = zeros(row,col);
y_DCTY =zeros(row,col);

%1D DCT for X axis
for p = 0 : N : row-1
    for q = 0 : N : col-1
        for a = 0 : 1 : N-1
            for b = 0 : 1 : N-1
                sum = 0;
                for j = 0 : 1 : N-1
                    sum = sum + x(p+a+1,q+j+1)*cos((2*j+1)*b*pi/(2*N));
                end
                if b == 0
                    y_DCTX(p+a+1,q+b+1) = sum*sqrt(1/N);
                else
                    y_DCTX(p+a+1,q+b+1) = sum*sqrt(2/N);
                end
            end
        end
    end
end

% 1D DCT for Y axis
for p = 0 : N : row-1
    for q = 0 : N : col-1
        for a = 0 : 1 : N-1
            for b = 0 : 1 : N-1
                sum = 0;
                for j = 0 : 1 : N-1
                    sum = sum + y_DCTX(q+j+1,p+a+1)*cos((2*j+1)*b*pi/(2*N));
                end
                if b == 0
                    y_DCTY(q+b+1,p+a+1) = sum*sqrt(1/N);
                else
                    y_DCTY(q+b+1,p+a+1) = sum*sqrt(2/N);
                end
            end
        end
    end
end

E1 = entropy(y_DCTY/255)
Quant_Mat = [16 11 10 16 24 40 51 61;
            12 12 14 19 26 58 60 55;
            14 13 16 24 40 57 69 56;
            14 17 22 29 51 87 80 62;
            18 22 37 56 68 109 103 77;
            24 35 55 64 81 104 113 92;
            49 64 78 87 103 121 120 101;
            72 92 95 98 112 100 103 99];
        
Quant_Mat_Rep = repmat(Quant_Mat,row/8);

y_DCTY = double(y_DCTY);
QuantizedY = y_DCTY./Quant_Mat_Rep;

y_DCTY = QuantizedY;
y_DCTY = round(y_DCTY);
y_DCTY = y_DCTY .*Quant_Mat_Rep;

E1 = entropy(y_DCTY/255)

y_IDCTY = zeros(row,col);
%1D IDCT for Y axis for 1 dimension array
for p = 0 : N : row-1
    for q = 0 : N : col-1
        for a = 0 : 1 : N-1
            for b = 0 : 1 : N-1
                sum = 0;
                for j = 0 : 1 : N-1
                    if j == 0
                        sum = sum + sqrt(1/N) * y_DCTY(q+j+1,p+a+1)*cos((2*b+1)*j*pi/(2*N));
                    else
                        sum = sum + sqrt(2/N) * y_DCTY(q+j+1,p+a+1)*cos((2*b+1)*j*pi/(2*N));
                    end
                end
                y_IDCTY(q+b+1,p+a+1) = sum;
            end
        end
    end
end

y_IDCTX = zeros(row,col);
%1D IDCT for X axis for 1 dimension array
for p = 0 : N : row-1
    for q = 0 : N : col-1
        for a = 0 : 1 : N-1
            for b = 0 : 1 : N-1
                sum = 0;
                for j = 0 : 1 : N-1
                    
                    if j == 0
                        sum = sum + sqrt(1/N) * y_IDCTY(p+a+1,q+j+1)*cos((2*b+1)*j*pi/(2*N));
                    else
                        sum = sum + sqrt(2/N) * y_IDCTY(p+a+1,q+j+1)*cos((2*b+1)*j*pi/(2*N));
                    end
                end
                y_IDCTX(p+a+1,q+b+1) = sum;
            end
        end
    end
end

y_DCTY_Spartial = uint8(y_IDCTX);
figure;
imshow(y_DCTY_Spartial); title('Recovered Image');
psnr(y_DCTY_Spartial,Image,255)
