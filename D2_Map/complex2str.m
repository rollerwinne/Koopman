function str=complex2str(x)
    x_abs=abs(x);
    x_angle=angle(x)*180/pi;
    str=[num2str(x_abs),'��',num2str(x_angle),'��'];
end