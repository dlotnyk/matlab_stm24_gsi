function [cutImage,xymax,smax,xymin,smin]=myimageanalysis(z)
%    function to analize and plt 2D STM data by finding Gaussian peaks
%    cutImage - filtered image
%    XMAX - maxima points in descending order
%    IMAX - indexes of the XMAX
%    XMIN - minima points in descending order
%    IMIN - indexes of the XMIN
%    z - initial square matrix
%    to use this function you are also required EXTREMA and EXTREMA2
%    functions
%    (c) Dmytro Lotnyk
%   Note: To change the linear index to (i,j) use IND2SUB. 
flag1=0;
%% preliminary filtering
[dim1,b2]=size(z);
z1 = medfilt2(z,[5 5]);
filter = fspecial('gaussian',[5 6],5); % used filter
filterImage = conv2(z1, filter);       % convolution
[c1,c2]=size(filterImage);
cutx=c1-dim1;
cuty=c2-dim1;
%% cutting edges
dimx=c1-2*cutx-2;
dimy=c2+1-2*cuty-2;
xx=1:dimx; yy=1:dimy;
cutImage=zeros(dimx,dimy);
for i1=1:dimx
    for i2=1:dimy
        cutImage(i1,i2)=filterImage(i1+6,i2+6);
    end
end
[xymax,smax,xymin,smin] = extrema2(cutImage);
if flag1==1
figure(1);
surf(xx,yy,cutImage),shading interp;
end