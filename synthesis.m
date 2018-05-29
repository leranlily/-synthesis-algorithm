function imgo = synthesis(img,w)
   
[m, n] = size(img);
size2 = min([m*3+2*w,256+2*w]);
label = zeros(size2);

if ndims(img) == 3
    img2 = im2double(zeros(size2,size2,3));   
    img2(1+w:m+w,1+w:n/3+w,:) = img;
    imgo = zeros(size2-w*2,size2-w*2,3);
    label(1+w:m+w,1+w:n/3+w)=ones(m,n/3);
elseif ndims(img) == 2
    img2 = im2double(zeros(size2,size2));   
    img2(1+w:m+w,1+w:n+w) = img;
    imgo = zeros(size2-w*2,size2-w*2);
    label(1+w:m+w,1+w:n+w)=ones(m,n);
end

sigma = w/2;
GW = ones(2*w+1,2*w+1);
I = ones(2*w+1,2*w+1);

for i = 1 : (2*w+1)
    for j = 1 : (2*w+1)
        GW(i,j) = exp(-((i-w-1).^2+(j-w-1).^2)/2/sigma^2);
    end
end
GW = I-GW;

while ~(all(all(label(w+1:size2-w,w+1:size2-w)))==1)
    count = zeros(size2);
    [fx,fy] = find(label==1);
    fxm = min([max(fx)+1,size2-w]);
    fym = min([max(fy)+1,size2-w]);
    for i = 1+w:fxm
        for j = 1+w:fym
            if label(i,j) == 0
                count(i,j) = sum(sum(label(i-w:i+w,j-w:j+w)));
            end
        end
    end
    
    [ix,iy] = find(count == max(max(count)));
    ix1 = ix(1);
    iy1 = iy(1);
    label(ix1,iy1) = 1;
    plabel = label(ix1-w:ix1+w,iy1-w:iy1+w);
    
    Dis = SSD(img,img2(ix1-w:ix1+w,iy1-w:iy1+w,:),GW,plabel);
    [x,y] = find(Dis == min(min(Dis)));
    x1 = x(1);
    y1 = y(1);
    img2(ix1,iy1,:)=img(x1+w,y1+w,:);
    %imshow(img2); 
end

imgo = img2(1+w:size2-w,1+w:size2-w,:);
end