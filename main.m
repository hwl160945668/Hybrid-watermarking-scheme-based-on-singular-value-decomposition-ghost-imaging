%主函数：水印提取和鲁棒性攻击过程
clear;
%对水印A进行混沌置乱，得到加密的水印B
%读入载体图像X
X=imread('lena.tiff');
%读入水印图像I
%I=imread('Watermarking.bmp');
RGB=imread('leave.png');
I=rgb2gray(RGB);
%I=imread('logo.png');
%置乱密钥
%key=3.8;    %可改变其值？
%key=0.35;
key=30;
[I_tran,num]=LB_zhiluan(I,key);
IT_out=LB_Nzhiluan(I_tran,num);

figure(1)
subplot(1,3,1),imshow(I),title('原始水印');
subplot(1,3,2),imshow(I_tran),title('置乱后的水印');
subplot(1,3,3),imshow(IT_out),title('解密后的水印');

imwrite(I_tran,'Fig8-14(b).bmp','bmp');
imwrite(IT_out,'Fig8-14(c).bmp','bmp');

%b为高频嵌入强度，a为低频嵌入强度
%a=0.2;b=0.08;   %载体图像清晰，提取的水印模糊
%a=1;b=0.68;     %载体图像模糊，提取的水印也模糊
%a=0.8;b=0.52;   %载体图像模糊，提取的水印模糊但能看见其轮廓
%a=1.8;b=1.2;     %载体图像模糊，提取的水印较为清晰
%a=0.1;b=0.06;   %载体图像清晰，提取的水印模糊
%a=5.0;b=2.0;
%a=0.08;b=0.02;     %在高频系数和低频系数较大时（>1），一般提取后的水印都比较清晰，但是嵌入水印后的载体图像比较模糊
%a=0.48;b=0.18;
%a=1.12;b=0.82;
a=1.02;b=0.78;
% a=1.58;b=0.58;

[IM,IN]=size(I);
[XM,XN]=size(X);

%生成整数随机序列
r1=randperm(IM);
r2=randperm(IN);
r3=randperm(IM/2);
r4=randperm(IN/2);
%水印嵌入
X_out=LB_In(X,I_tran,a,b,r1,r2,r3,r4);

%鲁棒性攻击
%---------------噪声攻击--------------
%产生噪声
noise=10*rand(size(X_out));
%加入噪声
NX_out=X_out + noise;
%NX_out=imnoise(X_out,'gaussian',1,0);

%---------------滤波攻击--------------
%获得滤波器
 h=fspecial('gaussian');
%滤波
FX_out=imfilter(X_out,h);

%---------------压缩攻击--------------
%进行JPEG压缩
imwrite(uint8(X_out),'PX.jpg','jpeg','Quality',75);
PX_out=imread('PX.jpg');

%逆时针旋转30度
RX_out=imrotate(uint8(X_out),9,'bilinear','crop');

%剪切攻击
%CXLU_out,CXLD_out,CXRU_out,CXRD_out分别对应左上角，左下角，右上角，右下角被剪裁
CXLU_out=X_out;
CXLD_out=X_out;
CXRU_out=X_out;
CXRD_out=X_out;
CXLU_out(1:round(XM/2),1:round(XN/2))=256;
CXLD_out(round(XM/2)+1:XM,1:round(XN/2))=256;
CXRU_out(1:round(XM/2),round(XN/2)+1:XN)=256;
CXRD_out(round(XM/2)+1:XM,round(XN/2)+1:XN)=256;

 %无攻击提取水印
 I_tran=LB_Out(X,X_out,a,b,r1,r2,r3,r4);
 I_out=LB_Nzhiluan(I_tran,num);
 PI_inout=PSNR(I,I_out);
 NI_inout=NC(I,I_out);
 
%噪声攻击后提取水印
 NI_tran=LB_Out(X,NX_out,a,b,r1,r2,r3,r4);
 NI_out=LB_Nzhiluan(NI_tran,num);
 PNI_inout=PSNR(I,NI_out);
 NNI_inout=NC(I,NI_out);

%滤波攻击后提取水印
FI_tran=LB_Out(X,FX_out,a,b,r1,r2,r3,r4);
FI_out=LB_Nzhiluan(I_tran,num);
PFI_inout=PSNR(I,FI_out);
NFI_inout=NC(I,FI_out);

%压缩攻击后提取水印
PI_tran=LB_Out(X,PX_out,a,b,r1,r2,r3,r4);
PI_out=LB_Nzhiluan(PI_tran,num);
PPI_inout=PSNR(I,PI_out);
NPI_inout=NC(I,PI_out);

%旋转攻击后提取水印
RI_tran=LB_Out(X,RX_out,a,b,r1,r2,r3,r4);
RI_out=LB_Nzhiluan(RI_tran,num);
PRI_inout=PSNR(I,RI_out);
NRI_inout=NC(I,RI_out);

%1/4剪切攻击后提取水印
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

%原始水印嵌入和未攻击的水印图像
figure(2)
subplot(2,2,1),imshow(X),title('原始载体图像');
%%subplot(2,2,2),imshow(I),title('原始水印图像');
subplot(2,2,2),imshow(uint8(X_out)),title('嵌入水印图像');
% subplot(2,2,4),imshow(uint8(I_out)),title('提取的水印');

%噪声攻击和滤波攻击后的水印提取
% figure(3)
subplot(2,2,3),imshow(uint8(NX_out)),title('噪声污染水印图像');
% subplot(2,2,2),imshow(NI_out,[]),title('噪声污染后提取的水印');
subplot(2,2,4),imshow(uint8(FX_out)),title('滤波攻击水印图像');
% subplot(2,2,4),imshow(FI_out,[]),title('滤波攻击后提取的水印');

%压缩攻击和旋转攻击后的水印提取
figure(3)
subplot(2,2,1),imshow(uint8(PX_out)),title('压缩攻击水印图像');
% subplot(2,2,2),imshow(PI_out,[]),title('压缩攻击后提取的水印');
subplot(2,2,2),imshow(uint8(RX_out)),title('旋转攻击水印图像');
% subplot(2,2,4),imshow(RI_out,[]),title('旋转攻击后提取的水印');

%剪切攻击后提取水印
% figure(5)
subplot(2,2,3),imshow(uint8(CXLU_out)),title('左上角剪切攻击水印图像');
% subplot(2,2,2),imshow(CILU_out,[]),title('左上角剪切攻击后提取的水印');
subplot(2,2,4),imshow(uint8(CXLD_out)),title('左下角剪切攻击水印图像');
% subplot(2,2,4),imshow(CILD_out,[]),title('左下角剪切攻击后提取的水印');
figure(4)
subplot(2,2,1),imshow(uint8(CXRU_out)),title('右上角剪切攻击水印图像');
% subplot(2,2,2),imshow(CIRU_out,[]),title('右上角剪切攻击后提取的水印');
subplot(2,2,2),imshow(uint8(CXRD_out)),title('右下角剪切攻击水印图像');
% subplot(2,2,4),imshow(CIRD_out,[]),title('右下角剪切攻击后提取的水印');

figure(5)
subplot(5,2,1),imshow(I),title('原始水印图像');
subplot(5,2,2),imshow(uint8(I_out)),title('提取的水印');
subplot(5,2,3),imshow(NI_out,[]),title('噪声污染后提取的水印');
subplot(5,2,4),imshow(FI_out,[]),title('滤波攻击后提取的水印');
subplot(5,2,5),imshow(PI_out,[]),title('压缩攻击后提取的水印');
subplot(5,2,6),imshow(RI_out,[]),title('旋转攻击后提取的水印');
subplot(5,2,7),imshow(CILU_out,[]),title('左上角剪切攻击后提取的水印');
subplot(5,2,8),imshow(CILD_out,[]),title('左下角剪切攻击后提取的水印');
subplot(5,2,9),imshow(CIRU_out,[]),title('右上角剪切攻击后提取的水印');
subplot(5,2,10),imshow(CIRD_out,[]),title('右下角剪切攻击后提取的水印');