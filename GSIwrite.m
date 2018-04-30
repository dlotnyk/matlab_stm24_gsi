function [r] = GSIwrite(x,y,path,path1,gl)
%  function for exact binary copy from byte X to the byte Y
%  path1 - output file path
%  x - start copiing
%  y - end of copying. if y='eof' (end-of-file) copy performes to the end
%  of file
%path='d:\dis3\tsamuely\01\g8x8tv64v5_2.gsi'; % path to original file
%path1='c:\work\matlab\tsamuely\GSItest\02.gsi'; % path to the new file

fid1=fopen(path1,gl,'l');
%% compare if y=='eof'
if strcmp(y,'eof')
    fid2=fopen(path,'r','l'); % some magic
    jj=0;
    fseek(fid2,x,'bof');
    while ~feof(fid2)
        jj=jj+1;
        fseek(fid2,jj+x,'bof');
        t=fread(fid2,1,'char');
    end
    y=jj;
    fclose(fid2);
end
%% copy from file 'path' to the file 'path1' starting from x to the y
fid=fopen(path,'r','l');
for ii=x:y-1                % exact copying byte per byte
    fseek(fid,ii,'bof');
    r=fread(fid,1,'char');
    fseek(fid1,ii,'bof');
    fwrite(fid1,r,'char');
end
fclose(fid1);
fclose(fid);