function y=crosscorr2(x1,x2)
%   function for cross correlation
[b1,b2]=size(x1);
[b3,b4]=size(x2);
nn=4;
x11=x1(nn+1:b1-nn-1,:);
x12=x11(:,nn+1:b2-nn-1);
x12=x12/x12(10,10);
x21=x2(nn+1:b3-nn-1,:);
x22=x21(:,nn+1:b4-nn-1);
x22=x22/x22(10,10);
x23=x22';
y = normxcorr2(x12, x22);
figure(8);
surf(y);
shading flat