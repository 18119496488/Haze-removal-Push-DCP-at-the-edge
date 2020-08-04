clear
close all

f= imread('F:\Á·Ï°\Push DCP at the edge\test_image\0002.jpg');
f=double(f)./255;
gray=rgb2gray(f);%RGB-->GRAY
figure,imshow(f),title('hazy image');

[darkmap,trans,v]=piecewise(f);
figure,imshow(darkmap),title('refined dark channel map');

% imwrite(darkmap,'F:/È¥Îí½á¹û/letter/Our darkmap2.png')

figure,imshow(trans),title('refined transmission');
t0=0.01;
J(:,:,1)=(f(:,:,1) - v)./max(trans,t0);
J(:,:,2)=(f(:,:,2) - v)./max(trans,t0);
J(:,:,3)=(f(:,:,3) - v)./max(trans,t0);


subplot(1,2,1),imshow(f),title('hazy image');
subplot(1,2,2),imshow(J),title('result');
% figure,imshow(J),title('result');
imwrite(J,'F:\Á·Ï°\Push DCP at the edge\results\0002.jpg');