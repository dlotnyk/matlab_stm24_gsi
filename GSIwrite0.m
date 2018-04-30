function [fileSize] = GSIwrite0(path,path1)
%  function for exact binary copy from byte X to the byte Y
%  path1 - output file path
%  x - start copiing
%  y - end of copying. if y='eof' (end-of-file) copy performes to the end
%  of file
%path='d:\dis3\tsamuely\01\g8x8tv64v5_2.gsi'; % path to original file
%path1='c:\work\matlab\tsamuely\GSItest\02.gsi'; % path to the new file

%% compare if y=='eof'
fileInfo = dir(path);
fileSize = fileInfo.bytes
%% copy from file 'path' to the file 'path1' starting from x to the y
fid1=fopen(path1,'w','l');
for ii=0:fileSize-1        % exact copying byte per byte
    if mod(ii,100000)==0
        ii
    end
    fseek(fid1,ii,'bof');
    fwrite(fid1,0,'char');
end
fclose(fid1);