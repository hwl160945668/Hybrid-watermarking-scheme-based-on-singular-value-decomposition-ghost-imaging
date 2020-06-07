%�Ӻ�����ˮӡ��ȡ
%���������XΪԭʼͼ��X_outΪˮӡǶ��ͼ��a,b�ֱ�Ϊ��ͨ��ͨС��ϵ����Ƕ��ǿ��
%r1,r2,r3,r4ΪǶ��λ�õ��������
%�������I_outΪ��ȡ��ˮӡͼ��
function I_out=LB_Out(X,X_out,a,b,r1,r2,r3,r4)
%������ͼ��X����һ��С���ֽ�
[CA1,CH1,CV1,CD1]=dwt2(X,'haar');
%������ͼ��X���ж���С���ֽ�
[CA2,CH2,CV2,CD2]=dwt2(CA1,'haar');
%������ͼ��X��������С���ֽ�
[CA3,CH3,CV3,CD3]=dwt2(CA2,'haar');
%�Ժ�ˮӡͼ��X_out����һ��С���ֽ�
[CCA1,CCH1,CCV1,CCD1]=dwt2(X_out,'haar');
%�Ժ�ˮӡͼ��X_out���ж���С���ֽ�
[CCA2,CCH2,CCV2,CCD2]=dwt2(CCA1,'haar');
%�Ժ�ˮӡͼ��X_out����һ��С���ֽ�
[CCA3,CCH3,CCV3,CCD3]=dwt2(CCA2,'haar');

%��������ֽ��źŵĳߴ�p,q
[p,q]=size(CCD3);

%��������������洢����
watermark1=zeros(p,q);
watermark2=zeros(p,q);
watermark3=zeros(p,q);
watermark4=zeros(p,q);
watermark5=zeros(p,q);
watermark6=zeros(p,q);
ICA1=zeros(p,q);

%�ڶ����ϣ���Ӧ�ĵ�������õ�֮ǰˮӡ��Ƶ���ֵ��ϰ벿��
for i=1:round(p/2)
    for j=1:q
        watermark1(i,j)=(double(CCD2(r1(i),r2(j))))-double(CD2(r1(i),r2(j)))/b;
        watermark2(i,j)=(double(CCV2(r1(i),r2(j))))-double(CV2(r1(i),r2(j)))/b;
        watermark3(i,j)=(double(CCH2(r1(i),r2(j))))-double(CH2(r1(i),r2(j)))/b;
    end
end

%�������ϣ���Ӧ�ĵ�������õ�֮ǰˮӡ��Ƶ���ֵ��°벿��
for i=round(p/2)+1:q
    for j=1:q
        watermark4(i,j)=(double(CCD3(r3(i),r4(j))))-double(CD3(r3(i),r4(j)))/b;
        watermark5(i,j)=(double(CCV3(r3(i),r4(j))))-double(CV3(r3(i),r4(j)))/b;
        watermark6(i,j)=(double(CCH3(r3(i),r4(j))))-double(CH3(r3(i),r4(j)))/b;
    end
end
%���°벿�ֺϳ�������Ƶ����
ICD1=watermark1+watermark4;
ICV1=watermark2+watermark5;
ICH1=watermark3+watermark6;
%�������ϣ���Ӧ�ĵ�������õ�֮ǰˮӡ�ĵ�Ƶ����
for i=1:p
    for j=1:q
        ICA1(i,j)=(double(CCA3(i,j))-double(CA3(i,j)))/a;
    end
end
%С����任�õ���ȡˮӡ
I_out=idwt2(ICA1,ICH1,ICV1,ICD1,'haar');