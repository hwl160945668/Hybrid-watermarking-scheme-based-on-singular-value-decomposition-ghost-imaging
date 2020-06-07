%�Ӻ�����ˮӡǶ��
%�������XΪԭʼ����ͼ��IΪ����ˮӡͼ��a,b�ֱ�Ϊ��ͨ�͸�ͨС��ϵ����Ƕ��ǿ��
%r1,r2,r3,r4ΪǶ��λ�õ��������
%�������X_outΪ����ˮӡ��ͼ��
function X_out=LB_In(X,I,a,b,r1,r2,r3,r4)
%������ͼ��X����һ��С���ֽ�
[CA1,CH1,CV1,CD1]=dwt2(X,'haar');
%������ͼ��X���ж���С���ֽ�
[CA2,CH2,CV2,CD2]=dwt2(CA1,'haar');
%������ͼ��X��������С���ֽ�
[CA3,CH3,CV3,CD3]=dwt2(CA2,'haar');
%��ˮӡͼ��sy����һ��С���ֽ�
[ICA1,ICH1,ICV1,ICD1]=dwt2(I,'haar');
%��������ֽ��źŵĳߴ�p,q
[p,q]=size(CD3);

%ˮӡǶ�����
%��ˮӡһ���ֽ�ĸ�Ƶ����ϰ벿�����ѡ��Ƕ�뵽ԭͼ�Ķ����ֽ���
for i=1:round(p/2)
    for j=1:q
        CD2(r1(i),r2(j))=double(CD2(r1(i),r2(j)))+b*double(ICD1(i,j));
        CV2(r1(i),r2(j))=double(CV2(r1(i),r2(j)))+b*double(ICV1(i,j));
        CH2(r1(i),r2(j))=double(CH2(r1(i),r2(j)))+b*double(ICH1(i,j));
    end
end

%��ˮӡһ���ֽ�ĸ�Ƶ����°벿�����ѡ��Ƕ�뵽ԭͼ�������ֽ���
for i=round(p/2)+1:p
    for j=1:q
        CD3(r3(i),r4(j))=double(CD3(r3(i),r4(j)))+b*double(ICD1(i,j));
        CV3(r3(i),r4(j))=double(CV3(r3(i),r4(j)))+b*double(ICV1(i,j));
        CH3(r3(i),r4(j))=double(CH3(r3(i),r4(j)))+b*double(ICH1(i,j));
    end
end

CA3=double(CA3)+a*double(ICA1);  %��ˮӡһ���ֽ�ĵ�Ƶ�����ӦǶ�뵽ԭͼ�Ķ����ֽ���

%С����任���ˮӡǶ��ͼ��X_out
x3=idwt2(CA3,CH3,CV3,CD3,'haar');
x2=idwt2(x3,CH2,CV2,CD2,'haar');
X_out=idwt2(x2,CH1,CV1,CD1,'haar');