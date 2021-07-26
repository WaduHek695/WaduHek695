%数独机版本1.1，重写算法，增加无法求解时的中断输出
%计划下个版本增加数对求解
%%
clear;
shudu=textread('shudu.txt');%读取数独文件
zero=zeros(9,9);
num=cell(9,9);%求解9*9矩阵，每个元胞是对应处所有可能的值
shudu1=zeros(9,9);
while ismember(0,shudu)
for p=1:81
    if shudu(p)>0
        num{p}=shudu(p);
    else
        num{p}=[];
    end
end %确定求解矩阵中的待求解的位置
for i=1:9
    for j=1:9
        if size(num{i,j})~=1
            block=shudu(3*ceil(i/3)-2:3*ceil(i/3),3*ceil(j/3)-2:3*ceil(j/3)); 
           for n=1:9
            if sum(ismember(n,shudu(i,:)))+sum(ismember(n,shudu(:,j)))+sum(ismember(n,block))==0
                num{i,j}=[num{i,j},n];
            end
           end
        end
    end
end %分别判断某块是否可以填入某值，得到输出矩阵
%%
 for i=1:9
     for j=1:9
    if size(num{i,j})==1
     shudu(i,j)=num{i,j};
    else
        blockn=num(3*ceil(i/3)-2:3*ceil(i/3),3*ceil(j/3)-2:3*ceil(j/3)); 
     for n=1:size(num{i,j})
         k1=0;
         k2=0;
         k3=0;
         for m=1:9
                k1=sum(ismember(num{i,j}(n),num{i,m}))+k1;
                k2=sum(ismember(num{i,j}(n),num{m,j}))+k2;
                k3=sum(ismember(num{i,j}(n),blockn{m}))+k3;
         end
         if k1==1||k2==1||k3==1
             shudu(i,j)=num{i,j}(n);
         end
      end
     end 
    end
 end %根据求解矩阵确定可以填入的值
 if shudu1==shudu
     break
 end
 shudu1=shudu; %判断是否进入死循环
end
disp(shudu);