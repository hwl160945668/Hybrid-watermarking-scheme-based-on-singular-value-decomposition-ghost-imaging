%子函数：逆置乱解密水印
function D=LB_Nzhiluan(B,numy)
C=uint8(B);
[M,N]=size(C);
%把矩阵C变成行向量
C1=reshape(C,1,M*N);
%逆置乱
for t=1:M*N
    D1(numy(t))=C1(t);
end
%解密后的水印图像矩阵D
D=reshape(D1,M,N);