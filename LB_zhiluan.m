%�Ӻ�����ˮӡ����
%��ˮӡA���л������ң��õ����ܵ�ˮӡB
%�������ΪA��ˮӡͼ���������ΪB�����Һ�ͼ��numyΪ���Һ�����
function [B,numy]=LB_zhiluan(A,key)
%���ˮӡͼ���С
[M,N]=size(A);
%��ͼ�������M*N��������A1
A1=reshape(A,1,M*N);
%��Կ������ֵ
y1(1)=key;
%������������
for n=1:N^2-1
    y1(n+1)=4*sin(y1(n)-2.5)*sin(y1(n)-2.5);
end
%����λ������
[y2,numy]=sort(y1);
%���ҹ��̣��õ����Һ������B1
for t=1:N^2
    B1(t)=A1(numy(t));
end
%��B1������Һ��ˮӡͼ�����B
B=reshape(B1,M,N);