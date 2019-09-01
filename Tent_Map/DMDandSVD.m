close all
clearvars -except U
A=U;
[ed.V,ed.D]=eig(A);%����ֵ�ͱ�������
% subplot(3,1,1)
% plot(abs(ed.V(:,1)))

[svd.U,svd.S,svd.V]=svd(A);
N1=norm(A*ed.V-ed.V*ed.D)%�Ƚ�����ֵ�ֽ����
N2=norm(A-svd.U*svd.S*svd.V')%�Ƚ�����ֵ�ֽ����

num=85;
temp=inv(ed.V);
A2=ed.V(:,1:end-num)*ed.D(1:end-num,1:end-num)*temp(1:end-num,:); %����num���󣬱Ƚ�����ֵ�ֽ����
temp=svd.V';
A3=svd.U(:,1:end-num)*svd.S(1:end-num,1:end-num)*temp(1:end-num,:);%����num���󣬱Ƚ�����ֵ�ֽ����

N3=norm(A-A2)
N4=norm(A-A3)

FN_A2=null(A2);
n=100;nn=3;
A_temp=(A2)^(nn-1);%��������ֵ�ֽ���ƺ�Ĺ��屾��������ͼ��
% A_temp=(A2)^(nn-1);%��������ֵ�ֽ���ƺ�Ĺ��屾��������ͼ��
F_A2=null(A_temp);
% subplot(3,1,2)
% plot(abs(F_A2))

A_temp=(A3-ed.D(1)*eye(n))^(nn-1);%��������ֵ�ֽ���ƺ�Ĺ��屾��������ͼ��
F_A3=null(A_temp);
% subplot(3,1,3)
% plot(abs(F_A3))

N5=norm(abs(ed.V(:,1))-abs(F_A2))%�Ƚ�����ֵ�ֽ���ƺ�ͼ��Ĳ��
N6=norm(abs(ed.V(:,1))-abs(F_A3))%�Ƚ�����ֵ�ֽ���ƺ�ͼ��Ĳ��

figure
s=[1,2,5,10,20,50,70,88,89];
for i=1:length(s)
    subplot(3,3,i)
    plot(abs(FN_A2(:,s(i))))
    title(num2str(s(i)))
end
figure
for i=1:length(s)
    subplot(3,3,i)
    plot(abs(F_A2(:,s(i))))
    title(num2str(s(i)))
end