function [F,D,U] = Henon_U_Fourier(x_k,x_l,y_k,y_l,m)
%% ���U,��������ֵD����������F
mxy=length(x_k);

[mx,ny]=meshgrid(1:m);
mx=mx(:);
ny=ny(:);
%% ����Ҷ������
for i=1:mxy
    for j=1:m*m
        K_even(i,j)=cos(pi/1.5*(mx(j)*x_k(i)+ny(j)*y_k(i)));
        K_odd(i,j)=sin(pi/1.5*(mx(j)*x_k(i)+ny(j)*y_k(i)));
    end
end
K=ones(mxy,2*m*m+1);
K(:,2:2:2*m*m)=K_even;
K(:,3:2:2*m*m+1)=K_odd;

for i=1:mxy
    for j=1:m*m
        L_even(i,j)=cos(pi/1.5*(mx(j)*x_l(i)+ny(j)*y_l(i)));
        L_odd(i,j)=sin(pi/1.5*(mx(j)*x_l(i)+ny(j)*y_l(i)));
    end
end
L=ones(mxy,2*m*m+1);
L(:,2:2:2*m*m)=L_even;
L(:,3:2:2*m*m+1)=L_odd;

t=toc;
disp(['Matrix has already been caculated and cost ' num2str(t) ' seconds.'])

tic
iK=pinv(K);     %��K�Ĺ����棺iK
U=L*iK;
[F,D]=eig(U);   %%��U������ֵD����������F
D=diag(D);
save(['.\data\Henon_Matrix_data_Fourier_FD_n50m20a1.4b0.3.mat'],'F','D');
t=toc;
disp(['Eigenfunctions has already been caculated and cost ' num2str(t) ' seconds.'])
end