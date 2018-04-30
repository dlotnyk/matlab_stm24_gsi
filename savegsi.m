function y=savegsi(x,top,factor,init)
%   function to save IVs or DIV into gsi file
%   y - non important
%   x - data to save
%   top - topography
%   factor - value all vulues should be multiped on (for normalized data factor = 1000 - 10000)
%   init - structure
%   D.L.

tic;
global path2;
%path2='d:\dis3\tsamuely\01\l03.gsi'; % path to the new file
%path2='c:\work\matlab\tsamuely\GSItest\l03.gsi';
m=memmapfile(path2,'Offset',init.begbytes,'Format',{'int16',[init.ncol init.nrow init.ramp+1],'mj'}, 'Writable', true);
y=int16(x*factor);
z=cat(3,top,y);
m.data.mj=z;
clear m;
toc;