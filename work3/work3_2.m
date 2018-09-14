hFig = figure(1);
set(hFig,'name','multi-class linear perceptrons to find the linear decision boundaries and regions。Activation functions 為 hardlimiter function。','Position', [300 0 500 400]);
Mean1 = [0;0]; 
Mean2=[1;0];
Mean3=[1;1];
Mean4=[0;1];
MySigma = [0.01 0; 0 0.01];
NormalPoint1 = mvnrnd(Mean1, MySigma, 100);
NormalPoint2 = mvnrnd(Mean2, MySigma, 100);
NormalPoint3 = mvnrnd(Mean3, MySigma, 100);
NormalPoint4 = mvnrnd(Mean4, MySigma, 100);
L=plot(NormalPoint1(:,1),NormalPoint1(:,2),'.','MarkerEdgeColor','r');
hold on;
M=plot(NormalPoint2(:,1),NormalPoint2(:,2),'x','MarkerEdgeColor','g');
N=plot(NormalPoint3(:,1),NormalPoint3(:,2),'o','MarkerEdgeColor','b');
O=plot(NormalPoint4(:,1),NormalPoint4(:,2),'*','MarkerEdgeColor','k');
axis([-1 2 -1 2]);
alpha=1;
A1=[0 0 0]';
A2=[0 0 0]';
A3=[0 0 0]';
A4=[0 0 0]';
it=0;
error=1000;
while(error>0)
    it=it+1;
    error=0;
for i=1:100    
   X=[NormalPoint1(i,1) NormalPoint1(i,2) 1]';
   D1=A1'*X;
   D2=A2'*X;
   D3=A3'*X;
   D4=A4'*X;
   %直接用正負號判斷相當於使用hardlimiter function
   if D1<=0
       error=error+1;
       A1=A1+alpha*X;
   end   
   if D2>=0
       error=error+1;
       A2=A2-alpha*X;
   end   
   if D3>=0
       error=error+1;
       A3=A3-alpha*X;
   end   
   if D4>=0
       error=error+1;
       A4=A4-alpha*X;
   end   
end

for i=1:100    
   X=[NormalPoint2(i,1) NormalPoint2(i,2) 1]';
   D1=A1'*X;
   D2=A2'*X;
   D3=A3'*X;
   D4=A4'*X;
   if D2<=0
       error=error+1;
       A2=A2+alpha*X;
   end   
   if D1>=0
       error=error+1;
       A1=A1-alpha*X;
   end   
   if D3>=0
       error=error+1;
       A3=A3-alpha*X;
   end   
   if D4>=0
       error=error+1;
       A4=A4-alpha*X;
   end   
end

for i=1:100    
   X=[NormalPoint3(i,1) NormalPoint3(i,2) 1]';
   D1=A1'*X;
   D2=A2'*X;
   D3=A3'*X;
   D4=A4'*X;
   if D3<=0
       error=error+1;
       A3=A3+alpha*X;
   end   
   if D2>=0
       error=error+1;
       A2=A2-alpha*X;
   end   
   if D1>=0
       error=error+1;
       A1=A1-alpha*X;
   end   
   if D4>=0
       error=error+1;
       A4=A4-alpha*X;
   end   
end
for i=1:100    
   X=[NormalPoint4(i,1) NormalPoint4(i,2) 1]';
   D1=A1'*X;
   D2=A2'*X;
   D3=A3'*X;
   D4=A4'*X;
   if D4<=0
       error=error+1;
       A4=A4+alpha*X;
   end   
   if D2>=0
       error=error+1;
       A2=A2-alpha*X;
   end   
   if D3>=0
       error=error+1;
       A3=A3-alpha*X;
   end   
   if D1>=0
       error=error+1;
       A1=A1-alpha*X;
   end   
end
EIT(1,it)=it;
EIT(2,it)=error;
end

x=linspace(-1,2);
y=(-A1(1)*x-A1(3))/A1(2);
L=plot(x,y);
set(L,'Color','red');

x=linspace(-1,2);
y=(-A2(1)*x-A2(3))/A2(2);
L=plot(x,y);
set(L,'Color','green');

x=linspace(-1,2);
y=(-A3(1)*x-A3(3))/A3(2);
L=plot(x,y);
set(L,'Color','blue');

x=linspace(-1,2);
y=(-A4(1)*x-A4(3))/A4(2);
L=plot(x,y);
set(L,'Color','black');

for i=1:50
    for j=1:50
        x=-1+3*i/50-0.03;
        y=-1+3*j/50-0.03;
        D1=x*A1(1)+y*A1(2)+A1(3);
        D2=x*A2(1)+y*A2(2)+A2(3);
        D3=x*A3(1)+y*A3(2)+A3(3);
        D4=x*A4(1)+y*A4(2)+A4(3);
    if D1>0 && D2<0 && D3<0 && D4<0
        plot(x,y,'r +');
    elseif D2>0 && D1<0 && D3<0 && D4<0
        plot(x,y,'g +');
    elseif D3>0 && D2<0 && D1<0 && D4<0
        plot(x,y,'b +');
    elseif D4>0 && D2<0 && D3<0 && D1<0
        plot(x,y,'k +');
    end
    
    end
end

hFig = figure(2);
set(hFig,'name','error','Position', [300 0 500 400]);
line(EIT(1,:),EIT(2,:));


axis([0 50 0 15]);