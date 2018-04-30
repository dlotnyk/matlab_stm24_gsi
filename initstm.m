function [init,dmat,top]=initstm(p1,p2)
%   initializing function. should be start first!!!
%   p1 - path of original gsi
%   p2 - path of changed
%   init - initial structure
%   dmat - matrix with ALL IVs
%   top - topography
%   D.L.

tic;
global path1 path2;
path1=[pwd,'\',p1,'.gsi'];
path2=[pwd,'\',p2,'.gsi'];
%path1='c:\work\matlab\tsamuely\GSItest\01.gsi'; % path to original file
%path2='c:\work\matlab\tsamuely\GSItest\l03.gsi'; % path to the new file
init=gsiread(path1);
copyfile(path1,path2,'f');
m=memmapfile(path2,'Offset',init.begbytes,'Format',{'int16',[init.ncol init.nrow init.ramp+1],'mj'}, 'Writable', true);
dmat=double(m.data.mj);
top=dmat(:,:,1); % topography
dmat(:,:,1)=[]; % All IV's and maps not transformed into nA
clearvars -except init dmat top
toc;