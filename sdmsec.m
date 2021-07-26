%数独机版本1.0b，重写解法，暴力强算
%然而并没有跑出来我艹(～￣▽￣)～哪位家里有神威太湖之光的可以试一下
%进一步开发的话要用到更多数独知识，所以就先到这里吧
%%
clc;clear all;
shudu=textread('shudu.txt');
sodu=shudu;
cishu=0;
block=mat2cell(shudu.',[3 3 3],[3 3 3]);
for i=1:9
 block{i}=reshape(block{i},1,9);
end
A=(1:9);
Psq=cell(3,3);
Pbl=cell(3,3);
for i=1:9
 Psq{i}=perms(setdiff(A,block{i}));
 Pbnum(i)=size(Psq{i},1);
 Pbl{i}=repmat(block{i}(1,:),Pbnum(i),1);
 n=1;
 tsodu=shudu;
  for j=1:9
     if block{i}(j)==0
         Pbl{i}(:,j)=Psq{i}(:,n);
         n=n+1;
     end
  end
  for q=1:Pbnum(i)
      m=3*(ceil(i/3)-1);
      n=3*(i-3*(ceil(i/3)-1)-1);
      tsodu(m+1:m+3,n+1:n+3)=reshape(Pbl{i}(q,:),[3 3]).';
      for z=1:3
          for x=1:3
          if (sum(tsodu(m+z,:)==tsodu(m+z,n+x))-1)*(sum(tsodu(:,n+x)==tsodu(m+z,n+x))-1)>0
               Pbl{i}(q,:)=0;
          end
          end
      end
  end  
  Pbl{i}(all(Pbl{i}==0,2),:)=[];
end
for i=1:9
    Pbnum(i)=size(Pbl{i},1);
end
%%
for a=1:Pbnum(1)
    for b=1:Pbnum(2)
        for c=1:Pbnum(3)
            for d=1:Pbnum(4)
                for e=1:Pbnum(5)
                    for f=1:Pbnum(6)
                        for g=1:Pbnum(7)
                            for h=1:Pbnum(8)
                                for i=1:Pbnum(9)
                                    b1=reshape(Pbl{1}(a,:),[3 3]).';
                                    b2=reshape(Pbl{2}(b,:),[3 3]).';
                                    b3=reshape(Pbl{3}(c,:),[3 3]).';
                                    b4=reshape(Pbl{4}(d,:),[3 3]).';
                                    b5=reshape(Pbl{5}(e,:),[3 3]).';
                                    b6=reshape(Pbl{6}(f,:),[3 3]).';
                                    b7=reshape(Pbl{7}(g,:),[3 3]).';
                                    b8=reshape(Pbl{8}(h,:),[3 3]).';
                                    b9=reshape(Pbl{9}(c,:),[3 3]).';
                                    sodu=[b1,b2,b3;b4,b5,b6;b7,b8,b9];
                                    cishu=cishu+1;
                                    if rctest(sodu)==1
                                        break
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
disp(sodu);
%%
function out=rctest(B)
out=1;
 for i=1:9
     if (isequal(length(unique(B(:,i))),9)&&isequal(length(unique(B(i,:))),9))==0
         out=0;
     end
 end
end

     
         
