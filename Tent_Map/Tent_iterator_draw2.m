clear;close all
n=1000;%粒子个数
m=20;%基函数个数 6 100;100 10
times=1;%一次演化波包数
D=0.00;%噪声强度,信噪比的倒数

x0=linspace(0,1,n);
% f=@(x)awgn(1-2*abs(x-1/2),10*log10(1/D)); %Tent map with noise
% g=@(x)1-2*abs(x-1/2); %Tent map
% f=@(x)awgn(g(g(x)),10*log10(1/D)); % Tent map*2
f=@(x)awgn(4.*x.*(1-x),10*log10(1/D)); %Logistic map with noise
% f=@(x)4.*x.*(1-x);%Logistic map
% f=@(x)awgn(2.5980762113533159402911695122588.*x.*(1-x).*(2-x),10*log10(1/D)); %偏移至0.41左右 with noise
% f=@(x)2.5980762113533159402911695122588.*x.*(1-x).*(2-x); %偏移至0.41左右
% figure(3);plot(x0,f(x0))
X=zeros(n,times);

x_iter=rand;
K_x=[];L_x=[];
for i=1:m+n
    K_x=[K_x;x_iter];
    x_temp=[];
    for k=1:times %每个点演化迭代times次
        x_temp=[x_temp,f(x_iter)];
    end
    x_iter=sum(x_temp)/times;%取平均
    if (x_iter>1)%处理周期性边界条件
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

U=pinv(K)*L;
[F,D]=eig(U);
D=diag(D);
%h=1:length(D);
h=find(abs(D)>0.01 & abs(D)<1.3 & imag(D)>-1e-6);
if length(D)<=9
    h=1:length(D);
end
for i=1:min(length(h),9)
    A=real(K*F(:,h(i)));
    figure(1);
    subplot(3,3,i)
    %set(gcf,'outerposition',get(0,'screensize'));
    hh=plot(1:n,A);
    d_abs=abs(D(h(i)));
    d_angle=angle(D(h(i)))/pi*180;
    str1=['n=',num2str(n),'; m=',num2str(m)];
    str2=[num2str(d_abs) ' ∠' num2str(d_angle) '°'];
    title({str1;str2});
end
suptitle('随着迭代的方向')
for i=1:min(length(h),9)
    A=real(K*F(:,h(i)));
    figure(2);
    subplot(3,3,i)
    %set(gcf,'outerposition',get(0,'screensize'));
    [x_initial_sort,index]=sort(x_initial);
    A_sort=A(index);
    hh=plot(x_initial_sort,A_sort);
    d_abs=abs(D(h(i)));
    d_angle=angle(D(h(i)))/pi*180;
    str1=['n=',num2str(n),'; m=',num2str(m)];
    str2=[num2str(d_abs) ' ∠' num2str(d_angle) '°'];
    title({str1;str2});
end
suptitle('相空间位置')
%figure(2);
%SVG_draw(U,K,n,m,0,0.1,1)
% figure(3);
% subplot(131);spyl(U);colorbar;title('U')
% subplot(132);spyl(K);colorbar;title('K')
% subplot(133);spyl(L);colorbar;title('L')%K与L的矩阵形式

%
% for i=1:length(x0)
%     g_temp=Tent_Rect_fun(i,m);
%     for j=1:times
%         X(i,j)=f(x0(i));
%     end
% end
% X=X(:);
% X=X(X<=1 & X>=0);
% rou=zeros(1,n);
% roux=0:1/n:1-1/n;
% for i=1:n
%     rou(i)=sum((X>=roux(i))&(X<roux(i)+1/n));
% end
% rou(n)=rou(n)+sum(X==1);
% % rou=rou/times;
% end

function g = Rect_fun(i,m)
% x is a number
if(i==m)
    g=@(x,i,m)(x>=(i-1)/m & x<=i/m)*sqrt(m); %x坐标，第i个基函数
else
    g=@(x,i,m)(x>=(i-1)/m & x<i/m)*sqrt(m);
end
end

function g= Gauss_fun(m)
dj=1/m/2;
xj=linspace(1/2/m,1-1/2/m,m);
g=@(x,i,m)exp(-(x-xj(i)).^2./(2.*dj.^2));
end