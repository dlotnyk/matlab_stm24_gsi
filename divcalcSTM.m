function y=divcalcSTM(x,n1,n2,init)
%   function to calculate derivates of IV's
%   x - IV data
%   n1 - number of point near gap
%   n2 - span at edges
%   y - output matrix
[b1,b2,b3]=size(x);
flag1=1;
tic;
%% xlinespace
mid1=floor((init.ramp)/2);
nums=floor(n2*init.ramp/2);
divg1=linspace(nums,n1,mid1-1);
divg2=linspace(n1,nums,init.ramp-mid1+1);
divx=[divg1';divg2']; %spans
xx=1:init.ramp;
%% differing
y=zeros(init.nrow,init.ncol,init.ramp);
for jj=1:init.ncol
    for kk=1:init.nrow
        lev=5;
        x1=zeros(init.ramp,1);
        x1(:,1)=x(kk,jj,:);
        [cc,ll] = wavedec(x1,lev,'sym8'); %denoise
        xd = wden(cc,ll,'minimaxi','s','sln',lev,'sym8');
        for ii=1:init.ramp
            hal1=floor(divx(ii,1)/2);
%    for jj=1:init.ncol
%        for kk=1:init.nrow
            y(kk,jj,ii)=-(xd(min(init.ramp,ii+hal1),1)-xd(max(1,ii-hal1),1))/(xx(1,min(init.ramp,ii+hal1))-xx(1,max(1,ii-hal1)));
%        end
%    end
        end
    end
end
toc;
%% plotting
if flag1==1
y1=zeros(init.ramp,1);
y2=zeros(init.ramp,1);
y2(:,1)=x(2,2,:);
y1(:,1)=y(1,1,:);
figure(1);
clf;
plot(1:init.ramp,y1);
figure(2);
clf;
plot(1:init.ramp,y2);
end