%子函数：水印嵌入
%输入变量X为原始载入图像，I为置乱水印图像，a,b分别为低通和高通小波系数的嵌入强度
%r1,r2,r3,r4为嵌入位置的随机序列
%输出变量X_out为加入水印的图像
function X_out=LB_In(X,I,a,b,r1,r2,r3,r4)
%对载体图像X进行一级小波分解
[CA1,CH1,CV1,CD1]=dwt2(X,'haar');
%对载体图像X进行二级小波分解
[CA2,CH2,CV2,CD2]=dwt2(CA1,'haar');
%对载体图像X进行三级小波分解
[CA3,CH3,CV3,CD3]=dwt2(CA2,'haar');
%对水印图像sy进行一级小波分解
[ICA1,ICH1,ICV1,ICD1]=dwt2(I,'haar');
%获得三级分解信号的尺寸p,q
[p,q]=size(CD3);

%水印嵌入过程
%把水印一级分解的高频结果上半部分随机选点嵌入到原图的二级分解结果
for i=1:round(p/2)
    for j=1:q
        CD2(r1(i),r2(j))=double(CD2(r1(i),r2(j)))+b*double(ICD1(i,j));
        CV2(r1(i),r2(j))=double(CV2(r1(i),r2(j)))+b*double(ICV1(i,j));
        CH2(r1(i),r2(j))=double(CH2(r1(i),r2(j)))+b*double(ICH1(i,j));
    end
end

%把水印一级分解的高频结果下半部分随机选点嵌入到原图的三级分解结果
for i=round(p/2)+1:p
    for j=1:q
        CD3(r3(i),r4(j))=double(CD3(r3(i),r4(j)))+b*double(ICD1(i,j));
        CV3(r3(i),r4(j))=double(CV3(r3(i),r4(j)))+b*double(ICV1(i,j));
        CH3(r3(i),r4(j))=double(CH3(r3(i),r4(j)))+b*double(ICH1(i,j));
    end
end

CA3=double(CA3)+a*double(ICA1);  %把水印一级分解的低频结果对应嵌入到原图的二级分解结果

%小波逆变换获得水印嵌入图像X_out
x3=idwt2(CA3,CH3,CV3,CD3,'haar');
x2=idwt2(x3,CH2,CV2,CD2,'haar');
X_out=idwt2(x2,CH1,CV1,CD1,'haar');