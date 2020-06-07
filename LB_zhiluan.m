%子函数：水印置乱
%对水印A进行混沌置乱，得到加密的水印B
%输入变量为A的水印图像，输出变量为B的置乱后图像，numy为置乱后的序号
function [B,numy]=LB_zhiluan(A,key)
%获得水印图像大小
[M,N]=size(A);
%把图像矩阵变成M*N的行向量A1
A1=reshape(A,1,M*N);
%密钥赋给初值
y1(1)=key;
%产生混沌序列
for n=1:N^2-1
    y1(n+1)=4*sin(y1(n)-2.5)*sin(y1(n)-2.5);
end
%产生位置向量
[y2,numy]=sort(y1);
%置乱过程，得到置乱后的序列B1
for t=1:N^2
    B1(t)=A1(numy(t));
end
%把B1变成置乱后的水印图像矩阵B
B=reshape(B1,M,N);