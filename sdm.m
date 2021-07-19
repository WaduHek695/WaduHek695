%数独机版本1.0，能解简单数独
%后续添加显示，数对求解，暴力求解，无法求解时停止运算功能
%%
clear;
shudu=textread('shudu7.txt');
zero=zeros(9,9);
%%
while ismember(0,shudu)
for p=1:81
    if shudu(p)==0
        zero(p)=1;
    else
        zero(p)=0;
    end
end
num=cell(1,9);
for a=1:9
    num{a}=zero;
end
for n=1:9
 for i=1:9
    for j=1:9
        if zero(i,j)==1
            block=shudu(3*ceil(i/3)-2:3*ceil(i/3),3*ceil(j/3)-2:3*ceil(j/3)); 
            for q=1:9
            if shudu(i,q)==n||shudu(q,j)==n||block(q)==n
                num{n}(i,j)=0;
            end
            end
        end
    end
 end
end
%%
for i=1:81
    if zero(i)==1
    k=zeros(1,9);
    for n=1:9
        k(n)=num{n}(i);
    end
    if sum(k(:)==1)==1
        [x,y]=find(k==1);
        shudu(i)=y;
    end
    end
end
end  
