function [F,D,U] = Henon_U(x_k,x_l,y_k,y_l,m,md)
%% ���U,��������ֵD����������F
%   ����x_k��x_p
%   ����x_l: x_p+1

tic
% global md;
dj=3/md;    
% global m;    %�������ĸ���

[xj,yj]=meshgrid(linspace(-1.5,1.5,m));%�õ�����m*m�ľ���
mxy=length(x_k);
xj=xj(:);
yj=yj(:);

%% ��˹��
% figure(100)
for j=1:m*m
    for i=1:mxy
        K(i,j)=exp(-(x_k(i)-xj(j))^2/(dj^2)-(y_k(i)-yj(j))^2/(dj^2));        
    end
%     hold on
%     surf(reshape(x_k,sqrt(mxy),sqrt(mxy)),reshape(y_k,sqrt(mxy),sqrt(mxy)),reshape(K(:,j),sqrt(mxy),sqrt(mxy)))
%     pause(0.2)
%     shading interp
%     drawnow
end
% figure(101)
% surf(reshape(x_k,sqrt(mxy),sqrt(mxy)),reshape(y_k,sqrt(mxy),sqrt(mxy)),reshape(sum(K,2),sqrt(mxy),sqrt(mxy)))
% shading interp

for i=1:mxy
    for j=1:m*m
        L(i,j)=exp(-(x_l(i)-xj(j))^2/(dj^2)-(y_l(i)-yj(j))^2/(dj^2));        
    end
end
t=toc;
%disp(['Matric has already been caculated and cost ' num2str(t) ' seconds.'])

tic
iK=pinv(K);     %��K�Ĺ����棺iK
U=L*iK;
[F,D]=eig(U);   %%��U������ֵD����������F
D=diag(D);
%save(['.\data\Henon_Matrix_data_FD_n100m50md45a1.4b0.3.mat'],'F','D');
t=toc;
%disp(['Eigenfunctions has already been caculated and cost ' num2str(t) ' seconds.'])
end