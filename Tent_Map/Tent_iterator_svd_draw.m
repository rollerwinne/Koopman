clear;close all
n=1000;%���Ӹ���
m=20;%���������� 6 100;100 10
r=5;
times=1;%һ���ݻ�������
D=0.00;%����ǿ��,����ȵĵ���

x0=linspace(0,1,n);
% f=@(x)awgn(1-2*abs(x-1/2),10*log10(1/D)); %Tent map with noise
% g=@(x)1-2*abs(x-1/2); %Tent map
% f=@(x)awgn(g(g(x)),10*log10(1/D)); % Tent map*2
f=@(x)awgn(4.*x.*(1-x),10*log10(1/D)); %Logistic map with noise
% f=@(x)4.*x.*(1-x);%Logistic map
% f=@(x)awgn(2.5980762113533159402911695122588.*x.*(1-x).*(2-x),10*log10(1/D)); %ƫ����0.41���� with noise
% f=@(x)2.5980762113533159402911695122588.*x.*(1-x).*(2-x); %ƫ����0.41����
% figure(3);plot(x0,f(x0))
X=zeros(n,times);

x_iter=rand;
K_x=[];L_x=[];
for i=1:m+n
    K_x=[K_x;x_iter];
    x_temp=[];
    for k=1:times %ÿ�����ݻ�����times��
        x_temp=[x_temp,f(x_iter)];
    end
    x_iter=sum(x_temp)/times;%ȡƽ��
    if (x_iter>1)%���������Ա߽�����
        x_iter=x_iter-1;
    end
    if (x_iter<0)
        x_iter=x_iter+1;
    end
    L_x=[L_x;x_iter];
end
for i=1:m
    K(:,i)=K_x(i:i+n-1);
    L(:,i)=L_x(i:i+n-1);
end
x_initial=K_x(1:n);
[F,D,R]=Koopman_svd_draw(K,L,r);
% U=pinv(K)*L;
% [F,D]=eig(U);
D=diag(D);
%h=1:length(D);
h=find(abs(D)>0.01 & abs(D)<1.3);
if length(D)<=9
    h=1:length(D);
end
for i=1:min(length(h),9)
    A=real(F(:,h(i)));
    figure(1);
    set(gcf,'outerposition',get(0,'screensize')-[0,0,1440*0.3,900*0.2]);
    subplot(3,3,i)
    %set(gcf,'outerposition',get(0,'screensize'));
    hh1=plot(1:n,A);
    d_abs=abs(D(h(i)));
    d_angle=angle(D(h(i)))/pi*180;
    str1=['n=',num2str(n),'; m=',num2str(m)];
    str2=[num2str(d_abs) ' ��' num2str(d_angle) '��'];
    title({str1;str2});
end
suptitle('���ŵ����ķ���')
for i=1:min(length(h),9)
    A=real(F(:,h(i)));
    figure(2);
    set(gcf,'outerposition',get(0,'screensize')-[0,0,1440*0.3,900*0.2]);
    subplot(3,3,i)
    %set(gcf,'outerposition',get(0,'screensize'));
    [x_initial_sort,index]=sort(x_initial);
    A_sort=A(index);
    hh2=plot(x_initial_sort,A_sort);
    d_abs=abs(D(h(i)));
    d_angle=angle(D(h(i)))/pi*180;
    str1=['n=',num2str(n),'; m=',num2str(m)];
    str2=[num2str(d_abs) ' ��' num2str(d_angle) '��'];
    title({str1;str2});
end
suptitle('��ռ�λ��')
saveas(hh1,['temp4/Tent_iteri_svd_m',num2str(m),'r',num2str(r),'.png'])
saveas(hh2,['temp4/Tent_iterp_svd_m',num2str(m),'r',num2str(r),'.png'])
%figure(2);
%SVG_draw(U,K,n,m,0,0.1,1)
% figure(3);
% subplot(131);spyl(U);colorbar;title('U')
% subplot(132);spyl(K);colorbar;title('K')
% subplot(133);spyl(L);colorbar;title('L')%K��L�ľ�����ʽ

function g = Rect_fun(i,m)
% x is a number
if(i==m)
    g=@(x,i,m)(x>=(i-1)/m & x<=i/m)*sqrt(m); %x���꣬��i��������
else
    g=@(x,i,m)(x>=(i-1)/m & x<i/m)*sqrt(m);
end
end

function g= Gauss_fun(m)
dj=1/m/2;
xj=linspace(1/2/m,1-1/2/m,m);
g=@(x,i,m)exp(-(x-xj(i)).^2./(2.*dj.^2));
end