function [F,D,x_function_length]=Lorenz_Koopman_U_legendre(x_k,x_l,power)
K=Legendre_basis_3d(x_k,power);
L=Legendre_basis_3d(x_l,power);
x_function_length=length(K(1,:));
%% Eigenvalues and Eigenfuncitons of Koopman Operator
iK=pinv(K);     %��K�Ĺ����棺iK
U=L*iK;
[F,D]=eig(U);   %%��U������ֵD����������F
D=diag(D);
end