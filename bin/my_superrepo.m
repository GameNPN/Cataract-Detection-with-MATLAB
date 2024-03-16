clc
clear all
close all
I1 = imread('Exam01.jpg');
I2 = imread('Exam02.jpg');

I1_G = rgb2gray(I1);
I2_G = rgb2gray(I2);

[m, n ,p] = size(I1_G);
figure(1), imshow(I1_G);
figure(2), imshow(I2_G);

X = zeros(m,n);
for i = 1:m
    for j = 1:n
        X(i,j) = I1_G(i,j);
        if X(i,j) <= I2_G(i,j)
            X(i,j) = I2_G(i,j);
        end
    end
end
T = mat2gray(X);
figure(3),imshow(T);