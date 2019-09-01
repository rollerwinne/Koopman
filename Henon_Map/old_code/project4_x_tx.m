% function [X,Y]=project4_x(n,k,q)
%% project1�� 2-d map
tic
% global n;       % n:�ݻ������
% global q;       % q:�ݻ�����
% global k;       % k:��������
n=800;
k=0.75;
q=1000;  %��������
[x0,y0]=meshgrid(linspace(0,1,n));
x=x0(:)';  
y=y0(:)';

f=@(x,y)mod((x+y+k/(2*pi)*sin(2*pi*x)),1);
g=@(x,y)mod((y+k/(2*pi)*sin(2*pi*x)),1);
% f=@(x,y)[x+y+k*sin(2*pi*x),y+k*sin(2*pi*x)];
X=[x];
Y=[y];
%% ��ȡq�ε���
for i=1:q 
%      y=mod(g(x,y),1);
%      x=mod(f(x,y),1);

     xx=f(x,y);
     yy=g(x,y); 
     x=xx;
     y=yy;
     X=[X;x]; 
     Y=[Y;y];      
end

%%  ���ݻ�����ͼ
% for i=size(X,1):-1:1
%      figure
%      plot(X(i,:),Y(i,:),'.b')
%      xlim([0,1]);
%      ylim([0,1]);
%      title(i);
% end
save('XY.mat','X','Y');
%% ��������Ϊ��гʱ��ƽ��ֵ���� ������ֵΪ1��
F=0;
for i=1:q
   h=cos(2*pi.*X(i,:)).*cos(2*pi.*Y(i,:));
    F=F+h;
end
    F=F/q;
%% ��ͼ
    figure('NumberTitle','off','Name',['q=' num2str(q) 'k=' num2str(k) 'n=' num2str(n)]);
    for i=1:q
    hh=scatter3(X(i,:)',Y(i,:)',F',3,F');
    colorbar
    colormap(jet)
    view(0,90)
    axis equal
    end
    str=['n' num2str(n) 'q' num2str(q)  'k' num2str(k) '.fig'];
    saveas(hh,str);
    
    toc
% end
