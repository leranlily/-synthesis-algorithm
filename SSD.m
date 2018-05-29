function Dis = SSD(img1,img2,GW,I)

for i = 1 : size(img1,3)
    i1 = img1(:,:,i);
    i2 = img2(:,:,i).*I;
    %SSD的计算就是(a-b)^2的累积和，展开为a^2 + b^2 - 2ab，
    %其中a为固定的图像，那么a^2则为一定值，b^2是不断变化的，
    %但是也可以用积分图之类的算法实现快速效果，唯一的耗时时2ab项，可以用卷积来实现。
    Dis11 = filter2(GW.*I,i1.^2,'valid');
    Dis22 = sum(sum(i2.^2.*GW));
    Dis12 = filter2(i2.*GW,i1,'valid').*2;
    
    if i == 1
        Dis = (Dis11 + Dis22 - Dis12);
    else
        Dis = Dis + (Dis11 + Dis22 - Dis12);
    end
end
end
    
% sum(sum((i1(1:size(img2,1),1:size(img2,2))-i2).^2));