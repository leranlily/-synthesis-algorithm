function Dis = SSD(img1,img2,GW,I)

for i = 1 : size(img1,3)
    i1 = img1(:,:,i);
    i2 = img2(:,:,i).*I;
    %SSD�ļ������(a-b)^2���ۻ��ͣ�չ��Ϊa^2 + b^2 - 2ab��
    %����aΪ�̶���ͼ����ôa^2��Ϊһ��ֵ��b^2�ǲ��ϱ仯�ģ�
    %����Ҳ�����û���ͼ֮����㷨ʵ�ֿ���Ч����Ψһ�ĺ�ʱʱ2ab������þ����ʵ�֡�
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