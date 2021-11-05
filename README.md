These are all the implementations for a master-level multimedia signal processing during Year 3 fall semester exchange.

# Half-toning

Halftone is the reprographic technique that simulates continuous tone imagery through the use of dots, varying either in size or in spacing, thus generating a gradient-like effect. This technique is usually used in printers to create an optical illusion of a smooth tone to a human eye.


# Linde, Buzo and Gray (1980) codebook generation

LBG codebook is a compression algorithm where the entire image is only represented by N sets of M*M pixel. The algorithm vector quantization uses K nearest neighbour clustering in order to find the N best representations. The picture is later on recovered based on the N sets representation. The higher the N, the higher quality the recovered image at the cost of computational power.


# Discrete cosine transform

DCT is widely used in JPEG algorithm due to its compression potential. DCT is able to transform signals (in this case an image) into frequency domain which will later on will be quantised with JPEG quantization matrix. The quantization matrix removes insignificant frequency that is insensitive to a human eye to create an optical illusion of an indifferent image with the high frequency component removed. This technique greatly compresses the image while retaining the image integrity.


# Block trauncation compression

Block Truncation Coding (BTC) is a type of lossy image compression technique for grey-scale images. It divides the original images into blocks and then uses a quantizer to reduce the number of grey levels in each block whilst maintaining the same mean and standard deviation.


# Error-diffused Block trauncation Compression

An algorithm derived by Prof Guo Jing Ming (who is also the professor for the module): Improved block truncation coding using modified error diffusion which combines the algorithm from BTC and error-diffusion method from half-toning in order to achieve high HPSNR.

![Alt text](https://github.com/Chen-XueWen/Image-Processing-Algorithm/blob/master/Comparison.PNG)
