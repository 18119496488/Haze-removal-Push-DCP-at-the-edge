function [ A ] = LAtm1( HazeImg )

sz = size(HazeImg);
w = sz(1);
h = sz(2);
Amc = max(HazeImg,[],3);
r1= ceil(min(h,w)/5);
se1 = strel('square',r1);
Amc_c1 = imclose(Amc,se1);
r2= ceil(min(h,w)/40);
se2 = strel('square',r2);
Amc_c2 = imclose(Amc,se2);
Amc_c=(Amc_c1+Amc_c2)./2;
A = bilateralFilter2( Amc_c, Amc);
end