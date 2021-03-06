%% Initialization
clc;close all;clear
tic;timestart=char(datetime('now'));
%disp('The running program is from ZC. 么么哒')
%% Parameter settings
a=1.4;b=0.3;n=2000;m=2;
times=1;d=0;

Attr=load('./data/Henon_attractors_data_xy.mat'); % 吸引子数据载入
x_attr=Attr.x;y_attr=Attr.y;
Peri=load('./data/Henon_period_orbrits_P_1_0.3_-1_-0.3.mat');
P=Peri.P;
xy_bound=[1.272933828112852,-0.012403304471461];
f=@(x,y)y+1-a.*x.*x;
g=@(x,y)b*x;
x0=zeros(1,n);
y0=zeros(1,n);

idx=find(~isinf(x_attr));
index=floor(rand*length(idx));
x_iter=x_attr(idx(index));
y_iter=y_attr(idx(index));

K_x=[];L_x=[];K=zeros(2*n,m);L=K;
for i=1:m+n
    K_x=[K_x;x_iter;y_iter];
    x_temp=[];y_temp=[];
    for k=1:times %每个点演化迭代times次
        x_temp=[x_temp,f(x_iter,y_iter)];
        y_temp=[y_temp,g(x_iter,y_iter)];
    end
    x_iter=sum(x_temp)/times;%取平均
    y_iter=sum(y_temp)/times;%取平均
    L_x=[L_x;x_iter;y_iter];
end
for i=1:m
    K(:,i)=K_x(2*i-1:2*i-1+2*n-1);
    L(:,i)=L_x(2*i-1:2*i-1+2*n-1);
end


%% Caculate Eigenfunction
%[F,D,U] = Henon_U(x_k,x_l,y_k,y_l,m,md);
%save('.\data\Henon_Matrix_data_on_attractors_FD_n50m50.mat','F','D');
%load('.\data\Henon_Matrix_data_on_attractors_FD_n50m50.mat');
U=pinv(K)*L;
[F,D]=eig(U);
D=diag(D);
%h=1:length(D);
%h=find(abs(D)>0.01 & abs(D)<1.3 & imag(D)>-1e-6);


%% Data processing
choose='complex';
if strcmp(choose,'real')==1
    %h=find(abs(D)>0.9 & abs(D)<1.1 & imag(D)==0); % find real eigenvalues
    h=find(real(D)>0& abs(D)>0.0001 & abs(D)<1.2 & abs(imag(D))<1e-6);
elseif strcmp(choose,'complex')==1
    h=find(abs(D)>0.5 & abs(D)<1.05 & imag(D)>-1e-6 ); % find complex eigenvalues
end
if length(D)<=9
    h=1:length(D);
end
%% Draw Eigenfunctions
figure_num=10;
attachments=[];
for i=1:min(figure_num,length(h))
    figure(i)
    set(gcf,'outerposition',get(0,'screensize')-[0,0,1440*0.3,900*0.2]);
    
    for j=1:4
        subplot(2,2,j)
        X=K(1:2:end,1);
        Y=K(2:2:end,1);
        Z_temp=K*F(:,h(i));
        if j==1
            Z=real(Z_temp(1:2:end,1));
        elseif j==2
            Z=real(Z_temp(2:2:end,1));
        elseif j==3
            Z=real(Z_temp(1:2:end,1));
        elseif j==4
            Z=real(Z_temp(2:2:end,1));
        end
        scatter3(X(:),Y(:),Z(:),3,Z(:));
        hold on
        z_min=min(Z(:));z_max=max(Z(:));
        z_min1=z_min+0.01*(z_max-z_min);
        
        plot3([Attr.x1;Attr.x2],[Attr.y1;Attr.y2],z_min1*ones(2,1),'r*');
        
        %         load('boundary.mat','boundary')
        %         B=Henon_Boundary(boundary',3,3);
        %         plot3(B(:,1),B(:,2),z_min1*ones(length(B(:,1)),1),'ro');
        %
        %
        
        xlim([-1.5,1.5])
        ylim([-1.5,1.5])
        if j==1
            title('Aerial View: real(x)')
            scatter3(x_attr(:),y_attr(:),z_min*ones(length(x_attr(:)),1),3,min(Z(:))*ones(length(x_attr(:)),1));%画吸引子
            view(-15,60)
        elseif j==2
            title('Aerial View: real(y)')
            scatter3(x_attr(:),y_attr(:),z_min*ones(length(x_attr(:)),1),3,min(Z(:))*ones(length(x_attr(:)),1));%画吸引子
            view(-15,60)
        elseif j==3
            title('Top View: real(x)')
            view(0,90)
        elseif j==4
            title('Top View: real(y)')
            view(0,90)
        end
        shading interp
        colorbar
        colormap(jet)
    end
    maketitle(D(h(i)),a,b,m,n);
    str=['./temp/Henon_eigen_natural_n',num2str(n),'m',num2str(m),'_figure',num2str(i)];
    % saveas(hh,[str,'.fig']);
    %saveas(gcf,[str,'.png']);
    % attachments{i}=[str,'.png'];
end

function maketitle(d,~,b,m,n)
d_abs=abs(d);
d_angle=angle(d)/pi*180;
N=log(b)/log(d_abs);
A=d_angle/N;
T=round(360/A);
err=abs((A*T-360))/360*100;
str0=['n=',num2str(n),'; m=',num2str(m)];
str1=[num2str(d_abs) ' ∠' num2str(d_angle) '°'];
str2=['log' '_{' num2str(b) '}(' num2str(d_abs) ')=' num2str(N) '; ' num2str(d_angle) '°/' num2str(N) '=' num2str(A) '°'];
str3=['T=' num2str(360/A) '≈' num2str(T) '; err=' num2str(err) '%'];
%suptitle({str0;[str2,'; ',str3];str1})
str=['Eigenfunction of Henon Map with Natural Basis (n=',num2str(n),',m=',num2str(m),')'];
suptitle({str;str1})
end