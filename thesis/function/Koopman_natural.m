function [K,L]=Koopman_natural(fun,param,opt)
x0=param.x0;
n=param.n;
m=param.m;
times=param.times;
% f:函数
% x0:初始点
% n:演化格点维度
% m:函数格点维度
% times：噪声平均次数
dim=length(x0);
x_iter=x0;
K_x=zeros(dim*(m+n),1);L_x=K_x;K=zeros(dim*n,m);L=K;
for i=1:m+n
    K_x((i-1)*dim+1:i*dim)=x_iter';
    x_temp=zeros(times,dim);
    for k=1:times %每个点演化迭代times次
        x_temp(k,:)=fun(x_iter);
    end
    x_iter=sum(x_temp,1)/times;%取平均
    L_x((i-1)*dim+1:i*dim)=x_iter';
end
for i=1:m
    K(:,i)=K_x( dim*(i-1)+1 : dim*(i-1)+1 + dim*n-1 );
    L(:,i)=L_x( dim*(i-1)+1 : dim*(i-1)+1 + dim*n-1 );
end
x_initial=K(:,1);

U=pinv(K)*L;
[F,D]=eig(U);
D=diag(D);
%h=1:length(D);
h=find(abs(D)>0.01 & abs(D)<1.3 & imag(D)>-1e-6);
if length(D)<=9
    h=1:length(D);
end

param.h=h;
param.D=D;
for i=1:min(length(h),9)
    param.figure_num=i;
    param.x0=x_initial;
    param.A=K*F(:,h(i));
    param.dim=dim;
    plotDim(param,opt);
end

end

function h=plotDim(param,opt)
x0=param.x0;
A=param.A;
dim=param.dim;
h=param.h;
D=param.D;
n=param.n;
m=param.m;
times=param.times;
figure_num=param.figure_num;

figure;
set(gcf,'outerposition',get(0,'screensize')-[0,0,1440*0.3,900*0.2]);

A_real=real(A);
A_abs=abs(A);

switch dim
    case 1
        [~,idx]=sort(x0);
        subplot(dim,2,1)
        plot(x0(idx),A_real(idx),'LineWidth',2);
        sciformat
        xlabel('x-real');
        subplot(dim,2,2)
        plot(x0(idx),A_abs(idx),'LineWidth',2);
        xlabel('x-abs');
        sciformat
    case 2
        x_str=['x','y'];
        % scatter3(X(:),Y(:),Z(:),3,Z(:));
        for i=1:dim
            subplot(dim,2,i*2-1)
            scatter3(x0(1:dim:end),x0(2:dim:end),A_real(i:dim:end),3,A_real(i:dim:end));
            if param.findpeak.enabled
                param.R=Henon_findpeaks_draw(x0(1:dim:end),x0(2:dim:end),A_real(i:dim:end),param.findpeak.color,param.findpeak.nearby);
            end
            xlabel([x_str(i),'-real']);
            graph_control_2D(opt);
            subplot(dim,2,i*2)
            scatter3(x0(1:dim:end),x0(2:dim:end),A_abs(i:dim:end),3,A_abs(i:dim:end));
            xlabel([x_str(i),'-abs']);
            graph_control_2D(opt);
        end
    case 3
        x_str=['x','y','z'];
        for i=1:dim
            subplot(2,dim,i)
            scatter3(x0(1:dim:end),x0(2:dim:end),x0(3:dim:end),3,A_real(i:dim:end));
            xlabel('x');ylabel('y');zlabel('z');
            title([x_str(i),'-real']);
            %Henon_cms_draw('black');
            graph_control_3D(opt);
            subplot(2,dim,i+dim)
            scatter3(x0(1:dim:end),x0(2:dim:end),x0(3:dim:end),3,A_abs(i:dim:end));
            xlabel('x');ylabel('y');zlabel('z');
            title([x_str(i),'-abs']);
            %Henon_cms_draw('black');
            graph_control_3D(opt);
        end
    otherwise
        for i=1:dim
            subplot(2,dim,i)
            plot(x0(i:dim:end),A_real(i:dim:end));
            xlabel(['x_',num2str(i),'-real']);
            subplot(2,dim,i+dim)
            plot(x0(i:dim:end),A_real(i:dim:end));
            xlabel(['x_',num2str(i),'-abs']);
        end
end

d_abs=abs(D(h(figure_num)));
d_angle=angle(D(h(figure_num)))/pi*180;
str1=['n=',num2str(n),'; m=',num2str(m),'; times=',num2str(times)];
str2=[num2str(d_abs) ' ∠' num2str(d_angle) '°'];
suptitle({str1;str2});

saveit(param,opt);
end

function saveit(param,opt)
h=gcf;
if opt.save.enabled
    str=[opt.save.path,'/',opt.save.pre,param_str(param),'figure',num2str(param.figure_num),opt.save.suffix];
    disp(str);
    saveas(h,str);
end
end

function str=param_str(param)
str=['_n',num2str(param.n),'m',num2str(param.m),'_'];
end

function graph_control_2D(opt)
view(opt.view)
%view(options.view)
shading interp
colorbar
colormap(opt.map)
sciformat
end

function graph_control_3D(opt)
view(opt.view)
colorbar
colormap(opt.map)
sciformat
end