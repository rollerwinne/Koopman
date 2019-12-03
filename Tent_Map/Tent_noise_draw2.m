clear;close all
n=1000;%���Ӹ���
times=10;%һ���ݻ�������
D=0.000;%����ǿ��,����ȵĵ���

x0=linspace(0,1,n);
%[f,seq,sx]=Tents_function(7,D);           % Tents map
[f,seq,sx]=Tents_function(5,D);           % Tents map low()
% f=@(x)awgn(1-2*abs(x-1/2),10*log10(1/D)); % Tent map with noise
% f=@(x)1-2*abs(x-1/2);                     % Tent map
% f=@(x)awgn(g(g(x)),10*log10(1/D));        % Tent map*2
% f=@(x)awgn(3.90.*x.*(1-x),10*log10(1/D)); % Logistic map with noise
% f=@(x)4.*x.*(1-x);                        % Logistic map
% f=@(x)awgn(2.5980762113533159402911695122588.*x.*(1-x).*(2-x),10*log10(1/D)); %ƫ����0.41���� with noise
% f=@(x)2.5980762113533159402911695122588.*x.*(1-x).*(2-x); %ƫ����0.41����
s=jet(n);
flag=0;
for m=[8,16,32]%[4,6,8,10,12,14,16,20,28,32,38,44,50,60,64,72,80,90,100]
    K=zeros(n,m);
    L=zeros(n,m);
    for j=1:m %����ÿ��������
        % g_temp=Rect_fun(j,m);%rect������
        g_temp=Gauss_fun(m);%Gauss������
        for i=1:length(x0) %����ÿ����ռ�ĵ�
            K(i,j)=g_temp(x0(i),j,m);
            x_temp=[];
            for k=1:times %ÿ�����ݻ�����times��
                x_temp=[x_temp,g_temp(f(x0(i)),j,m)];
            end
            %x_temp=x_temp(x_temp<=1 & x_temp>=0);
            L(i,j)=sum(x_temp)/times;
        end
    end
    if flag==0
        flag=1;
    else
        Tent_eigen_corr(K_pre,K,L_pre,L,n,m_pre,m);
    end
    m_pre=m;
    K_pre=K;
    L_pre=L;
end

function draw_boundary(min,max,sx)
l=length(sx(:,1));
s=cool(l);
for i=1:l
    plot(sx(i,:),(max-min)/l*i+min,'*','color',s(i,:));
end
end

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