%计算两个信号的NC值
function y=NC(I,J)
I1=double(I);
J1=double(J);
MA=I1.*J1;
NA=I1.^2;
LA=J1.^2;
y=sum(sum(MA))/sqrt(sum(sum(NA))*sum(sum(LA)));