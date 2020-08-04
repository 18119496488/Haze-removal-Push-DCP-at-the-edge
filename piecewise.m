% Author: Wangzhiwe
% date:2020.7.30
function [ Darkmap,Transmission,V ] = piecewise( HazeImg )

%% researvh inital drak channel map 
r=HazeImg(:,:,1);
g=HazeImg(:,:,2);
b=HazeImg(:,:,3);
gray=rgb2gray(HazeImg);
[m,n]=size(gray);
N=m*n;
a=zeros(m,n);
for i=1:m
    for j=1:n
        a(i,j)=min(r(i,j),g(i,j));
        a(i,j)=min(a(i,j),b(i,j));
    end;
end;
dark = a;
%% parameters: avr(mean value) ,sigama(standard deviation),p(skewness)
avr=sum(sum(gray))./N;
sigama=sqrt((sum(sum((gray-avr).^2)))./(N)); 
p=abs(sum(sum((gray-avr).^3))./(N*sigama.^3));
p=abs(p);

if dark < avr
    Darkmap=dark.^(1+avr);

else
    Darkmap=(1-sigama).*(dark)-p*sigama;
end
G=fspecial('gaussian', [15, 15]);
Darkmap= imfilter(Darkmap,G);
%% atmospheric light value
A=LAtm1(HazeImg);
%% dark channel map of haze-free image
h=avr+(1-avr)./2;
r=10*(p+h);
minJ=log(1+Darkmap).^r;
Transmission=((A-0.98.*Darkmap)./(A-minJ));
Transmission=minfilt2(Transmission,[5,5]);
%% refined transmission
eps = 10^-6;
r=7;
Transmission=guidedfilter(gray, Transmission, r, eps);
%% set V=(1-Transmission).*A
V=(1-Transmission).*A;
end

