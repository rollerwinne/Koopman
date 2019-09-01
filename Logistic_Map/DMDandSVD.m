close all
clearvars -except U
A=U;
[ed.V,ed.D]=eig(A);%����ֵ�ͱ�������
subplot(3,1,1)
plot(abs(ed.V(:,1)))

[svd.U,svd.S,svd.V]=svd(A);
norm(A*ed.V-ed.V*ed.D)%�Ƚ�����ֵ�ֽ����
norm(A-svd.U*svd.S*svd.V')%�Ƚ�����ֵ�ֽ����

num=85;
temp=inv(ed.V);
A2=ed.V(:,1:end-num)*ed.D(1:end-num,1:end-num)*temp(1:end-num,:);norm(A-A2) %����num���󣬱Ƚ�����ֵ�ֽ����
temp=svd.V';
A3=svd.U(:,1:end-num)*svd.S(1:end-num,1:end-num)*temp(1:end-num,:);%����num���󣬱Ƚ�����ֵ�ֽ����

norm(A-A2)
norm(A-A3)

n=1000;nn=6;
% A_temp=inv((U-h(I)*eye(n))^(nn-1));
% A=abs(A_temp*F(:,h(I)));
A_temp=(A2-ed.D(1)*eye(n))^(nn-1);%��������ֵ�ֽ���ƺ�Ĺ��屾��������ͼ��
F_A2=null(A_temp);
subplot(3,1,2)
plot(abs(F_A2))

A_temp=(A3-ed.D(1)*eye(n))^(nn-1);%��������ֵ�ֽ���ƺ�Ĺ��屾��������ͼ��
F_A3=null(A_temp);
subplot(3,1,3)
plot(abs(F_A3))

norm(abs(ed.V(:,1))-abs(F_A2))%�Ƚ�����ֵ�ֽ���ƺ�ͼ��Ĳ��
norm(abs(ed.V(:,1))-abs(F_A3))%�Ƚ�����ֵ�ֽ���ƺ�ͼ��Ĳ��