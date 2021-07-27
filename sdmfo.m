%整合了1.2和1.0b，结合唯一余数和暴力求解算法，能求解困难难度数独，所需时间不等
%计划下一步继续优化算法
%%
clear;
shudu=textread('shudu2.txt');%读取数独文件
zero=zeros(9,9);
A=0:9;
cishu=0;
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
%%
if sum(ismember(0,shudu))==0
    disp(shudu);
else
    Pblock=cell(3,3);
    for p=1:3
        for q=1:3
            Pnum=[];
            num1=num(3*p-2:3*p,3*q-2:3*q);
            shudu1=shudu(3*p-2:3*p,3*q-2:3*q);
            n=1;
            un=setdiff(A,shudu1);
            Perl=perms(un);
            Fix=repmat(reshape(shudu1,1,9),size(Perl,1),1);
for i=1:9
    if Fix(1,i)==0
        Pnum(:,i)=Perl(:,n);
        n=n+1;
    else
        Pnum(:,i)=Fix(:,i);
    end
end
for i=1:size(Perl,1)
    for j=1:9
       if sum(ismember(Pnum(i,j),num1{j}))==0
           Pnum(i,:)=0;
       end
    end
end
Pnum(all(Pnum==0,2),:)=[];
Pblock{p,q}=Pnum;
        end
    end
%%
Lb1={};
Lb2={};
Lb3={};
for i=1:3
    k=1;
    for a1=1:size(Pblock{3*i-2},1)
       for a2=1:size(Pblock{3*i-1},1)
           for a3=1:size(Pblock{3*i},1)
               b1=reshape(Pblock{3*i-2}(a1,:),[3 3]);
               b2=reshape(Pblock{3*i-1}(a2,:),[3 3]);
               b3=reshape(Pblock{3*i}(a3,:),[3 3]);
               Line=[b1;b2;b3];
               if ltest(Line)==1
                   switch(i)
                       case 1
                           Lb1=[Lb1,Line];
                       case 2
                           Lb2=[Lb2,Line];
                       case 3
                           Lb3=[Lb3,Line];
                   end
                   k=k+1;
               end
           end
       end
    end
end
for a1=1:size(Lb1,2)
    for a2=1:size(Lb2,2)
        for a3=1:size(Lb3,2)
            mat=cell2mat([Lb1(a1),Lb2(a2),Lb3(a3)]);
            if htest(mat)
                shudu=mat;
                break
            end
        end
    end
end
end
%%
function out=ltest(B)
C=[1 2 3 4 5 6 7 8 9];
out=1;
 for i=1:size(B,2)
     if isempty(setdiff(C,B(:,i)))==0
         out=0;
     end
 end
end
function out=htest(B)
C=[1 2 3 4 5 6 7 8 9];
out=1;
 for i=1:size(B,2)
     if isempty(setdiff(C,B(i,:)))==0
         out=0;
     end
 end
end