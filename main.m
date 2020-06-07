%��������ˮӡ��ȡ��³���Թ�������
clear;
%��ˮӡA���л������ң��õ����ܵ�ˮӡB
%��������ͼ��X
X=imread('lena.tiff');
%����ˮӡͼ��I
%I=imread('Watermarking.bmp');
RGB=imread('leave.png');
I=rgb2gray(RGB);
%I=imread('logo.png');
%������Կ
%key=3.8;    %�ɸı���ֵ��
%key=0.35;
key=30;
[I_tran,num]=LB_zhiluan(I,key);
IT_out=LB_Nzhiluan(I_tran,num);

figure(1)
subplot(1,3,1),imshow(I),title('ԭʼˮӡ');
subplot(1,3,2),imshow(I_tran),title('���Һ��ˮӡ');
subplot(1,3,3),imshow(IT_out),title('���ܺ��ˮӡ');

imwrite(I_tran,'Fig8-14(b).bmp','bmp');
imwrite(IT_out,'Fig8-14(c).bmp','bmp');

%bΪ��ƵǶ��ǿ�ȣ�aΪ��ƵǶ��ǿ��
%a=0.2;b=0.08;   %����ͼ����������ȡ��ˮӡģ��
%a=1;b=0.68;     %����ͼ��ģ������ȡ��ˮӡҲģ��
%a=0.8;b=0.52;   %����ͼ��ģ������ȡ��ˮӡģ�����ܿ���������
%a=1.8;b=1.2;     %����ͼ��ģ������ȡ��ˮӡ��Ϊ����
%a=0.1;b=0.06;   %����ͼ����������ȡ��ˮӡģ��
%a=5.0;b=2.0;
%a=0.08;b=0.02;     %�ڸ�Ƶϵ���͵�Ƶϵ���ϴ�ʱ��>1����һ����ȡ���ˮӡ���Ƚ�����������Ƕ��ˮӡ�������ͼ��Ƚ�ģ��
%a=0.48;b=0.18;
%a=1.12;b=0.82;
a=1.02;b=0.78;
% a=1.58;b=0.58;

[IM,IN]=size(I);
[XM,XN]=size(X);

%���������������
r1=randperm(IM);
r2=randperm(IN);
r3=randperm(IM/2);
r4=randperm(IN/2);
%ˮӡǶ��
X_out=LB_In(X,I_tran,a,b,r1,r2,r3,r4);

%³���Թ���
%---------------��������--------------
%��������
noise=10*rand(size(X_out));
%��������
NX_out=X_out + noise;
%NX_out=imnoise(X_out,'gaussian',1,0);

%---------------�˲�����--------------
%����˲���
 h=fspecial('gaussian');
%�˲�
FX_out=imfilter(X_out,h);

%---------------ѹ������--------------
%����JPEGѹ��
imwrite(uint8(X_out),'PX.jpg','jpeg','Quality',75);
PX_out=imread('PX.jpg');

%��ʱ����ת30��
RX_out=imrotate(uint8(X_out),9,'bilinear','crop');

%���й���
%CXLU_out,CXLD_out,CXRU_out,CXRD_out�ֱ��Ӧ���Ͻǣ����½ǣ����Ͻǣ����½Ǳ�����
CXLU_out=X_out;
CXLD_out=X_out;
CXRU_out=X_out;
CXRD_out=X_out;
CXLU_out(1:round(XM/2),1:round(XN/2))=256;
CXLD_out(round(XM/2)+1:XM,1:round(XN/2))=256;
CXRU_out(1:round(XM/2),round(XN/2)+1:XN)=256;
CXRD_out(round(XM/2)+1:XM,round(XN/2)+1:XN)=256;

 %�޹�����ȡˮӡ
 I_tran=LB_Out(X,X_out,a,b,r1,r2,r3,r4);
 I_out=LB_Nzhiluan(I_tran,num);
 PI_inout=PSNR(I,I_out);
 NI_inout=NC(I,I_out);
 
%������������ȡˮӡ
 NI_tran=LB_Out(X,NX_out,a,b,r1,r2,r3,r4);
 NI_out=LB_Nzhiluan(NI_tran,num);
 PNI_inout=PSNR(I,NI_out);
 NNI_inout=NC(I,NI_out);

%�˲���������ȡˮӡ
FI_tran=LB_Out(X,FX_out,a,b,r1,r2,r3,r4);
FI_out=LB_Nzhiluan(I_tran,num);
PFI_inout=PSNR(I,FI_out);
NFI_inout=NC(I,FI_out);

%ѹ����������ȡˮӡ
PI_tran=LB_Out(X,PX_out,a,b,r1,r2,r3,r4);
PI_out=LB_Nzhiluan(PI_tran,num);
PPI_inout=PSNR(I,PI_out);
NPI_inout=NC(I,PI_out);

%��ת��������ȡˮӡ
RI_tran=LB_Out(X,RX_out,a,b,r1,r2,r3,r4);
RI_out=LB_Nzhiluan(RI_tran,num);
PRI_inout=PSNR(I,RI_out);
NRI_inout=NC(I,RI_out);

%1/4���й�������ȡˮӡ
CILU_tran=LB_Out(X,CXLU_out,a,b,r1,r2,r3,r4);
CILD_tran=LB_Out(X,CXLD_out,a,b,r1,r2,r3,r4);
CIRU_tran=LB_Out(X,CXRU_out,a,b,r1,r2,r3,r4);
CIRD_tran=LB_Out(X,CXRD_out,a,b,r1,r2,r3,r4);
CILU_out=LB_Nzhiluan(CILU_tran,num);
CILD_out=LB_Nzhiluan(CILD_tran,num);
CIRU_out=LB_Nzhiluan(CIRU_tran,num);
CIRD_out=LB_Nzhiluan(CIRD_tran,num);
PI_inout1=PSNR(I,CILU_out);
PI_inout2=PSNR(I,CILD_out);
PI_inout3=PSNR(I,CIRU_out);
PI_inout4=PSNR(I,CIRD_out);
NI_inout1=NC(I,CILU_out);
NI_inout2=NC(I,CILD_out);
NI_inout3=NC(I,CIRU_out);
NI_inout4=NC(I,CIRD_out);

%ԭʼˮӡǶ���δ������ˮӡͼ��
figure(2)
subplot(2,2,1),imshow(X),title('ԭʼ����ͼ��');
%%subplot(2,2,2),imshow(I),title('ԭʼˮӡͼ��');
subplot(2,2,2),imshow(uint8(X_out)),title('Ƕ��ˮӡͼ��');
% subplot(2,2,4),imshow(uint8(I_out)),title('��ȡ��ˮӡ');

%�����������˲��������ˮӡ��ȡ
% figure(3)
subplot(2,2,3),imshow(uint8(NX_out)),title('������Ⱦˮӡͼ��');
% subplot(2,2,2),imshow(NI_out,[]),title('������Ⱦ����ȡ��ˮӡ');
subplot(2,2,4),imshow(uint8(FX_out)),title('�˲�����ˮӡͼ��');
% subplot(2,2,4),imshow(FI_out,[]),title('�˲���������ȡ��ˮӡ');

%ѹ����������ת�������ˮӡ��ȡ
figure(3)
subplot(2,2,1),imshow(uint8(PX_out)),title('ѹ������ˮӡͼ��');
% subplot(2,2,2),imshow(PI_out,[]),title('ѹ����������ȡ��ˮӡ');
subplot(2,2,2),imshow(uint8(RX_out)),title('��ת����ˮӡͼ��');
% subplot(2,2,4),imshow(RI_out,[]),title('��ת��������ȡ��ˮӡ');

%���й�������ȡˮӡ
% figure(5)
subplot(2,2,3),imshow(uint8(CXLU_out)),title('���ϽǼ��й���ˮӡͼ��');
% subplot(2,2,2),imshow(CILU_out,[]),title('���ϽǼ��й�������ȡ��ˮӡ');
subplot(2,2,4),imshow(uint8(CXLD_out)),title('���½Ǽ��й���ˮӡͼ��');
% subplot(2,2,4),imshow(CILD_out,[]),title('���½Ǽ��й�������ȡ��ˮӡ');
figure(4)
subplot(2,2,1),imshow(uint8(CXRU_out)),title('���ϽǼ��й���ˮӡͼ��');
% subplot(2,2,2),imshow(CIRU_out,[]),title('���ϽǼ��й�������ȡ��ˮӡ');
subplot(2,2,2),imshow(uint8(CXRD_out)),title('���½Ǽ��й���ˮӡͼ��');
% subplot(2,2,4),imshow(CIRD_out,[]),title('���½Ǽ��й�������ȡ��ˮӡ');

figure(5)
subplot(5,2,1),imshow(I),title('ԭʼˮӡͼ��');
subplot(5,2,2),imshow(uint8(I_out)),title('��ȡ��ˮӡ');
subplot(5,2,3),imshow(NI_out,[]),title('������Ⱦ����ȡ��ˮӡ');
subplot(5,2,4),imshow(FI_out,[]),title('�˲���������ȡ��ˮӡ');
subplot(5,2,5),imshow(PI_out,[]),title('ѹ����������ȡ��ˮӡ');
subplot(5,2,6),imshow(RI_out,[]),title('��ת��������ȡ��ˮӡ');
subplot(5,2,7),imshow(CILU_out,[]),title('���ϽǼ��й�������ȡ��ˮӡ');
subplot(5,2,8),imshow(CILD_out,[]),title('���½Ǽ��й�������ȡ��ˮӡ');
subplot(5,2,9),imshow(CIRU_out,[]),title('���ϽǼ��й�������ȡ��ˮӡ');
subplot(5,2,10),imshow(CIRD_out,[]),title('���½Ǽ��й�������ȡ��ˮӡ');