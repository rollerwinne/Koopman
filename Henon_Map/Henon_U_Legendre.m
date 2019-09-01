function [F,D,x_function_length]=Henon_U_Legendre(x_k,x_l,power)
K=Legendre_basis_2d(x_k,power);
L=Legendre_basis_2d(x_l,power);
x_function_length=length(K(1,:));
%% Eigenvalues and Eigenfuncitons of Koopman Operator
iK=pinv(K);     %��K�Ĺ����棺iK
U=L*iK;
[F,D]=eig(U);   %%��U������ֵD����������F
D=diag(D);
end
% clear;
% [x,y]=meshgrid(-1.5:0.01:1.5);
% x=x(:);y=y(:);
% x=[x,y];
% G=Legendre_basis_2d(x,3);
% sum(1e-4*G(:,1).*G(:,1))