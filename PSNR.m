%计算两个信号的峰值信噪比PSNR
function t=PSNR(f,g)
[m,n]=size(f);
[m1,n1]=size(g);
if(m1~=m||n1~=n)
    error('Signals are not the same size.',msg)
end
t=10*log(255^2/(1/(m*n)*(sum(sum((f-g).^2)))+1e-5));