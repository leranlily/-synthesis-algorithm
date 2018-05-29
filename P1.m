clear;
file_path = 'texture\';
index = dir(strcat(file_path,'*.jpg'));
No = size(index,1);
w = 2;

for i =1 : No
    img = im2double(imread(strcat(file_path,index(i).name)));
    imgo = synthesis(img,w);
    if exist(['part1\resultw=',num2str(w)],'dir') == 0
        mkdir(['part1\resultw=',num2str(w)]);
    end
    imwrite (imgo,['part1\resultw=',num2str(w),'\',num2str(i),'.png']);
end