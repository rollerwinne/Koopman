clear all
close all
clc
%%����a=1.4 b=0.3
a=1.4;
b=0.3;
[x,y]=meshgrid(linspace(-1,1,50));
%figure(1)
%plot(x,y,'b.')
f=@(x,y)y+1-a*x.*x;              
g=@(x,y)b.*x;
f1=@(x,y)b^(-1).*y;
g1=@(x,y)x-1+a*b^(-2).*y.*y;
iteration=17;
N=5000;
for i=1:iteration
x_evo=f(x,y);
y_evo=g(x,y);
x=x_evo;
y=y_evo;
end
%figure(1)
%plot(x,y,'b.')
%xlabel('x_n')
%ylabel('y_n')
%title{'H��non map'}
%ɾ�������е�inf
xx=reshape(x,1,2500);
yy=reshape(y,1,2500);
loc_inf=isinf(xx);
[row_inf,col_inf]=find(loc_inf==1);
xx(:,col_inf)=[];
yy(:,col_inf)=[];
data=[xx;yy];
Data=data';
%save('Data.mat','Data');
%figure(1)
%plot(data(1,:),data(2,:),'b.')
%����fix point���䱾������
x_fix=((b-1)+((b-1).^2+4*a).^(1/2))*((2*a).^-1);
y_fix=b*x_fix;
A=[-2*a*x_fix,1;b,0];
[V,D]=eig(A);                     %���㱾������
k=V(2,1)/V(1,1);
x_step=-0.02:0.0001:0.02;
x0=x_fix+x_step;
y0=k*(x0-x_fix)+y_fix;            %���㱾����������Ӧֱ�ߣ��õ��߶���һ���
figure(1)
plot(x,y,'b.')
hold on
plot(x_fix,y_fix,'r*')
hold on
plot(x0,y0,'r*')
%����fix point�����������õ��ݻ��켣
bag{1}=[x0;y0]
x_model{1}=x0;
y_model{1}=y0;
figure(2)
plot(x0,y0,'b-')
xlabel('x_n')
ylabel('y_n')
title('Original data')
axis([-1.5,1.5,-0.4,0.4]) 
for i=1:iteration
figure(3+i)
%plot(x0,y0,'b-')
%hold on
x0_evo=f(x0,y0);
y0_evo=g(x0,y0);
bag{i+1}=[x0_evo;y0_evo];
x0=x0_evo;
y0=y0_evo;
plot(x0,y0,'b-')
xlabel('x_n')
ylabel('y_n')
a=i;
title(['iteration=',num2str(a)])
axis([-1.5,1.5,-0.4,0.4]) 
end
%----------�鿴Henon map���ʱ仯���Ӷ�Ϊ��ά���ο�---------------------------
%figure(1)
%plot(bag{9}(1,:),bag{9}(2,:),'b-')
%l_boundary = length(bag{9});
%l_standard=40000;
%step=l_boundary/(l_standard-1);
%sp_interp = spline(1:l_boundary,[bag{9}(1,:);bag{9}(2,:)],1:step:l_boundary);
%x=sp_interp(1,:);
%y=sp_interp(2,:);
%Curve=curve(x,y);
%t_step=2/(length(Curve)-1);
%ti=-1:t_step:1;
%dcurve=gradient(Curve)/t_step;
%[~,n_max]=find(diff(sign(diff(Curve)))==-2);
%n_sym=n_max+1;
%figure(4)
%plot(ti(:,3000:end-3000),Curve(:,3000:end-3000),'b-')
%hold on
%plot(ti(:,n_sym),0,'r*')
%--------------------------------------------------------------------------
%save('x0');
%save('y0')
%figure(10)
%plot(bag{13}(1,:),bag{13}(2,:),'r-')
%ȡ���õ��Ĺ켣���ݵ���нṹ����
%�õ�����Χ�߽���
last_bag=bag{10};
symb1=last_bag(2,2:end)-last_bag(2,1:end-1);
symb2=symb1(:,1:end-1).*symb1(1,2:end);
[~,n_symb]=find(symb2<0);
n_symb=[1,n_symb,length(last_bag)];
for p=1:(length(n_symb)-1)
stru_bag{p}=last_bag(:,n_symb(:,p):n_symb(:,p+1));
end
%--------------------------------------------------------------------------
%����Χ�߽����ݻ�
%�ȶ���Χ�߽������ݽ��в�ֵ��Ȼ���ݻ������μ�С�ݻ���κ�Ĵֲڳ̶�
%���ǻ���˷�����Ȼ�������
min_ybag2=min(stru_bag{2}(2,:));      
max_ybag2=max(stru_bag{2}(2,:));
Y2=min_ybag2:(max_ybag2-min_ybag2)/N:max_ybag2; %��ֵ1001����
%figure(50)
%plot(stru_bag{2}(1,:),stru_bag{2}(2,:),'r.')
X2=interp1(stru_bag{2}(2,:),stru_bag{2}(1,:),Y2,'spline');
%plot(X2,Y2,'b.')
x_test=X2;
y_test=Y2;
h=4;
figure(40)
plot(x_test,y_test,'b-')
xlabel('x_n')
ylabel('y_n')
title('Boundary of H��non map')
axis([-1.5,1.5,-0.4,0.4])
data_map{1}=[x_test;y_test];
%��ֻѡȡһ�ν����ݻ����������
%[nnn,mmm]=find(data_map{1}(1,:)==max(data_map{1}(1,:)))
%clear x_test y_test;
%x_test=data_map{1}(1,1:2347);
%y_test=data_map{1}(2,1:2347);
%figure(100)
%plot(x_test,y_test,'b-')
%axis([-1.5,1.5,-0.4,0.4])
for i=1:h
    figure(40+i)
x_tevo=f(x_test,y_test);
y_tevo=g(x_test,y_test);
x_test=x_tevo;
y_test=y_tevo;
data_map{i+1}=[x_test;y_test];    %�����ݻ��õ��߽���
plot(x_test,y_test,'b-')
xlabel('x_n')
ylabel('y_n')
aa=i;
title(['iteration=',num2str(aa)])
axis([-1.5,1.5,-0.4,0.4])
xlabel('x_n')
ylabel('y_n')
end
save('data_map')
%ȡ���õ��Ĺ켣���ݵ���нṹ����
%������ͨ��fixed points������ݻ���Ȼ��ṹ����һ��
%ȡ��ÿһ���ݻ����³��ֵĹ켣�������в�ֵ
%��������ںܴ�Ĵֲڶ�
clear last_bag symb1 symb2 m_symb n_symb stru_bag i;
part_bag{1}=data_map{1};
num_strubag=1;
for i=1:3  
last_bag=data_map{i+1};
symb1=last_bag(2,2:end)-last_bag(2,1:end-1);
symb2=symb1(:,1:end-1).*symb1(1,2:end);
[~,n_sym]=find(symb2<0);
%ghost_point(:,i)=data_map{3}(:,n_symb(:,1))
n_symb=[1,n_sym,length(last_bag)];
%c=2^i-2^(i-1);
for p=1:(length(n_symb)-1)
stru_bag{p}=last_bag(:,n_symb(:,p):n_symb(:,p+1));
end
l=length(part_bag);
num_strubag=length(stru_bag)-num_strubag  %����ÿ���³��ֵĽṹ����
for d=1:num_strubag
part_bag{l+d}=stru_bag{d};
end
num_strubag=length(stru_bag);
end
%��ֵ
clear i min_ybag2 max_ybag2 X2 Y2;
for i=1:length(part_bag)-1
min_ybag2=min(part_bag{i+1}(2,:));      
max_ybag2=max(part_bag{i+1}(2,:));
Y2=min_ybag2:(max_ybag2-min_ybag2)/N:max_ybag2;
X2=interp1(part_bag{i+1}(2,:),part_bag{i+1}(1,:),Y2,'spline'); 
clear part_bag{i+1};
part_bag{i+1}=[X2;Y2];   
%figure(i+1)
%plot(part_bag{i+1}(1,:),part_bag{i+1}(2,:),'b-')
%axis([-1.5 1.5 -0.4 0.4])
end
%---------
%���Ե��ṹȡ�ò�����ʱ���Ƿ������ṹ����Ӱ��
%x_test=part_bag{2}(1,1000:3000);
%y_test=part_bag{2}(2,1000:3000);
%figure(1)
%plot(part_bag{2}(1,:),part_bag{2}(2,:),'b-')
%hold on
%plot(x_test,y_test,'ro','MarkerSize',2.0)
%for i=1:1
%x_tevo=f(x_test,y_test);
%y_tevo=g(x_test,y_test);
%x_test=x_tevo;
%y_test=y_tevo;
%figure(2)
%plot(x_test,y_test,'ro','MarkerSize',2.0)
%hold on
%plot(part_bag{2}(1,:),part_bag{2}(2,:),'b-')
%axis([-1.5,1.5,-0.4,0.4])
%end
%-------------


%ȡÿ��ṹ�ϵ����ݵ�����ݻ�һ�Σ�����turning points
%�������������ȡ��Ļ����޷����ֵ����ĸ��ṹ����turning point
for w=1:length(stru_bag)
x_test=part_bag{w}(1,:);
y_test=part_bag{w}(2,:);
for i=1:1
x_tevo=f(x_test,y_test);
y_tevo=g(x_test,y_test);
x_test=x_tevo;
y_test=y_tevo;
%plot(x_test,y_test,'b-')
%axis([-1.5,1.5,-0.4,0.4])
end
tempor_data{w}=[x_test;y_test];
end
%����turning points�ٽ���
%�ų��ڽ�����û�з���ת�۵ĵ�
clear last_bag symb1 symb2 n_sym  i
%part_bag{1}=data_map{1};
lin=0;
for i=1:8                   %length(stru_bag)
   
last_bag=tempor_data{i};
symb1=last_bag(2,2:end)-last_bag(2,1:end-1);
symb2=symb1(:,1:end-1).*symb1(1,2:end);
[~,n_sym]=find(symb2<0);
[~,n_turning]=find(n_sym>20&n_sym<4960);     %ȥ�����˺ͽ�β����
if isempty(n_turning)==1
    ghost_point(:,i)=0;
else
    if lin==0
        ghost_point(:,1)=part_bag{i}(:,n_sym(:,n_turning))
    else
    for K=1:length(n_turning)
ghost_point(:,lin+K)=part_bag{i}(:,n_sym(:,n_turning(:,K)));
    end
    end
end
lin=length(ghost_point(1,:))
end
[~,n_t1]=find(ghost_point==zeros(2,1));    %ɾ��ȫ����
ghost_point(:,[n_t1])=[];
figure(1)
plot(data_map{4}(1,:),data_map{4}(2,:),'b-')
hold on
plot(ghost_point(1,:),ghost_point(2,:),'r*')


clear i n_critical j min_ybag2 max_ybag2 X2 Y2;
num_iterating=2
for i=1:4
    park_point=part_bag{i}-ghost_point(:,i);          %����ghost_point��park_bag����һһ��Ӧ��
    park=park_point(1,:).^2+park_point(2,:).^2;
[~,n_critical]=find(park==min(park));
point_iterating=part_bag{i}(:,n_critical-750:n_critical+750);  %N����仯��������Ҫ�ı�
%��Ϊ�ڶ��ѹ���۵��У����ݵ��ø�Ϊϡ�裬���Ի�����޷������Ų�������
%������Ҫ�ٴζ�ѡȡ��������ݵ���в�ֵ
min_ybag2=min(point_iterating(2,:));      
max_ybag2=max(point_iterating(2,:));
Y2=min_ybag2:(max_ybag2-min_ybag2)/N:max_ybag2;
X2=interp1(point_iterating(2,:),point_iterating(1,:),Y2,'spline'); 
clear point_interating;
point_iterating=[X2;Y2];
xx1=point_iterating(1,:);
yy1=point_iterating(2,:);

%xx1=data_new(1,300:301);
%yy1=data_new(2,300:301);
figure(i+10)  %i+10
plot(xx1,yy1,'r*')
hold on
plot(data_map{3}(1,:),data_map{3}(2,:),'b-')

%�������һ�����⣺�ݻ���������ѹ����һ�𣬶��ݻ����������ַֿ���
%�����Ƿ񻹿�����ԭ������
for j=1:num_iterating
    xx1_evo=f(xx1,yy1);
    yy1_evo=g(xx1,yy1);
    xx1=xx1_evo;
    yy1=yy1_evo;  
end
figure(16)
plot(xx1,yy1,'k*')
hold on
plot(data_map{4}(1,:),data_map{4}(2,:),'b-')
hold on
plot(xx1(:,end),yy1(:,end),'r*')
hold on
plot(xx1(:,1),yy1(:,1),'r*')
%�����ݽ������飬�Ӷ������ݻ�
gather_data=[xx1;yy1];
[~,n_arrangement]=sort(gather_data(2,:));
data_new=gather_data(:,n_arrangement);
%ѡȡ�ݻ�����
x_reverse=data_new(1,1:1000) %N����仯��������Ҫ�ı�
y_reverse=data_new(2,1:1000) %N����仯��������Ҫ�ı�
for k=1:2
    figure(2*i+k)
    plot(x_reverse,y_reverse,'r*')
    hold on
for r=1:num_iterating
   xx1_reverse=f1(x_reverse,y_reverse);
   yy1_reverse=g1(x_reverse,y_reverse);
   x_reverse=xx1_reverse;
   y_reverse=yy1_reverse;
end
plot(x_reverse,y_reverse,'k*')
hold on
plot(data_map{3}(1,:),data_map{3}(2,:),'b-')
%����distance���������⣡����
[~,n_boundary1]=find(y_reverse==max(y_reverse))
[~,n_boundary2]=find(y_reverse==min(y_reverse))
distance(i,k)=norm([x_reverse(:,n_boundary1);y_reverse(:,n_boundary1)]-[x_reverse(:,n_boundary2);y_reverse(:,n_boundary2)])
x_reverse=data_new(1,end-2000:end-1000);   %N����仯��������Ҫ�ı�
y_reverse=data_new(2,end-2000:end-1000);   %N����仯��������Ҫ�ı�
end
if (distance(i,1)-distance(i,2))<0
    c1_point(:,i)=data_new(:,1)
else
    c1_point(:,i)=data_new(:,end)
    
end
figure(30+i)
plot(data_map{3}(1,:),data_map{3}(2,:),'b-')
hold on
plot(c1_point(1,i),c1_point(2,i),'r*')
end
xx1=point_iterating(1,:);
yy1=point_iterating(2,:);
figure(4)
plot(xx1,yy1,'ko','MarkerSize',2.0)
hold on
plot(data_map{3}(1,:),data_map{3}(2,:),'b-')


xx1_evo=f(xx1,yy1);
yy1_evo=g(xx1,yy1);
xx1=xx1_evo;
yy1=yy1_evo; 


%���õ����ݵ㷴���ݻ�2�εõ�critical point
clear i j;
for j=1:4
    x_reverse=c1_point(1,j);
    y_reverse=c1_point(2,j);
for i=1:num_iterating
   xx1_reverse=f1(x_reverse,y_reverse);
   yy1_reverse=g1(x_reverse,y_reverse);
   x_reverse=xx1_reverse;
   y_reverse=yy1_reverse; 
end
c0_point(:,j)=[x_reverse;y_reverse];

end
[~,n_c0]=sort(c0_point(1,:))
C0=c0_point(:,n_c0)
figure(50)
plot(data_map{3}(1,:),data_map{3}(2,:),'b-')
hold on
plot(C0(1,:),C0(2,:),'k.','MarkerSize',10)
hold on
plot(C0(1,:),C0(2,:),'r-')
%֮����Ҫ���ݸ���turning pointsλ�ôӶ����ڵ���ȷλ��
%------------------------���-----------------------------


%��ͼ�ӵ�һ��turning point������ת�۵�����
figure(51)
plot(ghost_point(1,1),ghost_point(2,1),'r*')
hold on 
plot(data_map{4}(1,:),data_map{4}(2,:),'b-')
xx1=ghost_point(1,1);
yy1=ghost_point(2,1);
for i=1:7
figure(i+51)  %i+10
plot(xx1,yy1,'r*')
hold on
%�������һ�����⣺�ݻ���������ѹ����һ�𣬶��ݻ����������ַֿ���
%�����Ƿ񻹿�����ԭ������
for j=1:1
    xx1_evo=f(xx1,yy1);
    yy1_evo=g(xx1,yy1);
    xx1=xx1_evo;
    yy1=yy1_evo;  
end
plot(xx1,yy1,'k*')
hold on
plot(data_map{4}(1,:),data_map{4}(2,:),'b-')
end






%�������������ݵ����ݻ�����֮�󶼻ᱻѹ����һ�������������ҷ���������Ҫ��ת�۵㸽��ȡ��
%������ܲ�ȷ���ڶ��������ȡ�㣿���ڲ�ͬmap�Ƿ�һ����
q=2
[~,a_test]=find(data_map{1}(1,:)==max(data_map{1}(1,:)))
x0=data_map{1}(1,a_test-50);
y0=data_map{1}(2,a_test-50);
for i=1:q
figure(3+i)
plot(x0,y0,'r*')
hold on
plot(data_map{3}(1,:),data_map{3}(2,:),'b-')
hold on
x0_evo=f(x0,y0);
y0_evo=g(x0,y0);
x0=x0_evo;
y0=y0_evo;
plot(x0,y0,'r*')
axis([-1.5,1.5,-0.4,0.4])
end

%ѡȡ���ݵ�����ݻ�����
p_test0=min(stru_bag{1}(1,:));
[~,n_test]=find(max(stru_bag{1}(1,:)));
stru_bag{1}(:,n_test);
p_test2=find((p_test0+p_test1)*0.5);





%ѡȡ���ݵ����ν��з���
min_xbag1=min(stru_bag{1}(1,:));
max_xbag1=max(stru_bag{1}(1,:));
X1=min_xbag1:0.001:max_xbag1;
%figure(50)
%plot(stru_bag{1}(1,:),stru_bag{1}(2,:),'r.')
Y1=interp1(stru_bag{1}(1,:),stru_bag{1}(2,:),X1,'spline');
%plot(X,Y,'b.')
min_ybag2=min(stru_bag{2}(2,:));
max_ybag2=max(stru_bag{2}(2,:));
Y2=min_ybag2:0.001:max_ybag2;
%figure(50)
%plot(stru_bag{2}(1,:),stru_bag{2}(2,:),'r.')
X2=interp1(stru_bag{2}(2,:),stru_bag{2}(1,:),Y2,'spline');
%plot(X2,Y2,'b.')
alpha=0.05
num=fix((max_xbag1-min_xbag1)/alpha);
for i=1:28
[m_X1,n_X1]=find(X1<0.5-alpha*i&X1>0.45-alpha*i);
xx1=X1(:,n_X1);
yy1=Y1(:,n_X1);
[m_X2,n_X2]=find(X2<0.5-alpha*i&X2>0.45-alpha*i&Y2<0);
xx2=X2(:,n_X2);
yy2=Y2(:,n_X2);
test=[xx1,xx2;yy1,yy2];
%test=[stru_bag{1}(:,26:33),stru_bag{2}(:,45:49)];
%stru_bag{2}(:,45:49)
x1=test(1,:);
y1=test(2,:);
f1=@(x,y)b^(-1).*y;
g1=@(x,y)x-1+a*b^(-2).*y.*y;
q=2;
 figure(30+i)
   plot(x1,y1,'r*')
   hold on
   plot(bag{10}(1,:),bag{10}(2,:),'b.')
   hold on
for j=1:q
   x1_evo=f1(x1,y1);
   y1_evo=g1(x1,y1);
   x1=x1_evo;
   y1=y1_evo;
end
find(stru_bag{2})
  plot(x1,y1,'r*')
end


%ѡȡһ�����ݵ㷴���ݻ�������
%��ѡȡ���ݵ���з��ݹ����У������ݵ�����˲�ֵ����Ϊ���Ĳ�ֵ�����ݶԷ��ݲ���Ӱ�죬����ѡȡһ����з���
%���Ǿ�Ŀǰ����������������ݵ㿿���ж�����ڷ��ݹ����гɹ��ķֲ���������֧��
test=[X1(:,500:523);Y1(:,500:523)];
%test=[stru_bag{1}(:,26:33),stru_bag{2}(:,45:49)];
%stru_bag{2}(:,45:49)
x1=test(1,:);
y1=test(2,:);
f1=@(x,y)b^(-1).*y;
g1=@(x,y)x-1+a*b^(-2).*y.*y;
q=1;
for j=1:q
    figure(30+j)
   plot(x1,y1,'r*')
   hold on
   plot(bag{10}(1,:),bag{10}(2,:),'b.')
   hold on
   x1_evo=f1(x1,y1);
   y1_evo=g1(x1,y1);
   x1=x1_evo;
   y1=y1_evo;
   plot(x1,y1,'r*')
end










%%������룿��
for w=1:length(data)
for q=1:length(stru_bag{1}) 
   Distance(q,w)=norm(data(:,w)-stru_bag{1}(:,q));
    end
end


for q=1:length(stru_bag{1})
    dis(data,stru_bag{1}(:,1))
    [m_data,n_data]=find(norm(data-stru_bag{1}(:,q))<1);
    data_inverse{q}=data(:,n_data);
end


%figure(2+i)
%for k=1:i
%plot(bag{k}(1,:),bag{k}(2,:),'r.')
%hold on
%plot(bag{i+1}(1,:),bag{i+1}(2,:),'b.')
%end


%����
[m_test1,n_test1]=find(stru_bag{1}(1,:)>0.4&stru_bag{1}(1,:)<0.52&stru_bag{1}(2,:)<0);
[m_test2,n_test2]=find(stru_bag{2}(1,:)>0.4&stru_bag{2}(1,:)<0.52&stru_bag{2}(2,:)<0);
Data=[stru_bag{1}(:,n_test1),stru_bag{2}(:,n_test2)]
%x1=Data(1,:);
%y1=Data(2,:);
x1=[stru_bag{3}(1,10:13),stru_bag{2}(1,31:34)];
y1=[stru_bag{3}(2,10:13),stru_bag{2}(2,31:34)];


%����
f1=@(x,y)b^(-1).*y;
g1=@(x,y)x-1+a*b^(-2).*y.*y;
q=1;
for j=1:q
    figure(30+j)
   plot(x1,y1,'r*')
   hold on
   plot(bag{12}(1,:),bag{12}(2,:),'b.')
   hold on
   x1_evo=f(x1,y1);
   y1_evo=g(x1,y1);
   x1=x1_evo;
   y1=y1_evo;
   plot(x1,y1,'r*')
end


%
A=stru_bag{1};
B=stru_bag{2};
C=stru_bag{3};
figure(40)
plot(A(1,:),A(2,:),'b.')
hold on 
plot(B(1,:),B(2,:),'r.')
hold on
plot(C(1,:),C(2,:),'b.')


%�����������н�������ת�۵�
num=1:fix(length(bag{10})/7);
test=bag{10}(:,7*num);
vec_a=test(:,1:(end-2))-test(:,2:end-1);
vec_c=test(:,3:end)-test(:,2:end-1);
for p=1:length(vec_a)
alpha(:,p)=dot(vec_a(:,p),vec_c(:,p))/(norm(vec_a(:,p)).*norm(vec_c(:,p)));
end
%

dist_xy=bag{10}(:,2:end)-bag{10}(:,1:end-1);
grad=dist_xy(2,:)./dist_xy(1,:);



test_point=bag{12}(:,75);
test_a=stru_bag{1}-test_point;
test_b=(test_a(1,:).^2+test_a(2,:).^2).^(1/2);
[m_test,n_test]=find((test_b)<0.05);
A_test=stru_bag{1}(:,n_test);

%��x=0.5��x=-1�����ߣ����з��ݡ���bag{10}���ҳ���һ��critical point
[m_start,n_start]=find(stru_bag{1}(1,:)<0.51&stru_bag{1}(1,:)>0.48&stru_bag{1}(2,:)<-0.2);
start_point=stru_bag{1}(:,n_start);
[dx,dy]=gradient(stru_bag{1});
grad=dx(2,:)./dx(1,:);
x_value=start_point:-0.02:-1;
y_value(:,1)=start_point(2,:)
for q=1:length(x_value)
y_value(:,q+1)=grad.*(x_value(:,q+1)-x_value(:,q))+y_value(:,q)
end










