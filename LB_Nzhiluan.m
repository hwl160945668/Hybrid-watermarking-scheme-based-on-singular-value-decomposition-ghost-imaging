%�Ӻ����������ҽ���ˮӡ
function D=LB_Nzhiluan(B,numy)
C=uint8(B);
[M,N]=size(C);
%�Ѿ���C���������
C1=reshape(C,1,M*N);
%������
for t=1:M*N
    D1(numy(t))=C1(t);
end
%���ܺ��ˮӡͼ�����D
D=reshape(D1,M,N);