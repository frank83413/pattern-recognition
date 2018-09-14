%-----------------3---------------------
hFig = figure(6);
set(hFig,'name','1 hidden layers , 3 hidden nodes,learning rate=0.1, error>0.01 && iteration<10000','Position', [300 0 500 400]);
Mean1 = [0;0]; 
Mean2=[14;0];
Mean3=[7;14];
Mean4=[7;7];
Sigma1 = [1 0; 0 1];
Sigma2 = [1 0; 0 4];
Sigma3 = [4 0; 0 1];
Sigma4 = [1 0; 0 1];
NormalPoint1 = mvnrnd(Mean1, Sigma1, 100);
NormalPoint2 = mvnrnd(Mean2, Sigma2, 100);
NormalPoint3 = mvnrnd(Mean3, Sigma3, 100);
NormalPoint4 = mvnrnd(Mean4, Sigma4, 100);
L=plot(NormalPoint1(:,1),NormalPoint1(:,2),'.','MarkerEdgeColor','r');
hold on;
M=plot(NormalPoint2(:,1),NormalPoint2(:,2),'x','MarkerEdgeColor','g');
N=plot(NormalPoint3(:,1),NormalPoint3(:,2),'o','MarkerEdgeColor','b');
O=plot(NormalPoint4(:,1),NormalPoint4(:,2),'*','MarkerEdgeColor','k');
axis([-5 20 -5 20]);

alpha=0.1;
W1=[0.1 0.2 0.3]';
W2=[0.1 0.1 0.2]';
W3=[0.2 0.1 0.1]';

W21=[0.1 0.1 0.1 0.1]';
W22=[0.1 0.3 0.2 0.1]';
W23=[0.5 0.3 0.1 0.2]';
W24=[0.1 0.3 0.1 0.1]';

it=0;
error=10;
while(error>0.01 && it<10000)
    it=it+1;
    error=0;
for i=1:400    
     
        
    if i<101
        X=[NormalPoint1(i,1) NormalPoint1(i,2) 1]';  
        d=[1 0 0 0];        
    elseif i<201
        X=[NormalPoint2(i-100,1) NormalPoint2(i-100,2) 1]';  
        d=[0 1 0 0];
    elseif i<301
        X=[NormalPoint3(i-200,1) NormalPoint3(i-200,2) 1]';  
        d=[0 0 1 0];
    elseif i<401
        X=[NormalPoint4(i-300,1) NormalPoint4(i-300,2) 1]';
        d=[0 0 0 1];        
    end
   
   
   S1=W1'*X;
   S2=W2'*X;
   S3=W3'*X;
   o1=1.0/(1.0+exp(-S1));
   o2=1.0/(1.0+exp(-S2));
   o3=1.0/(1.0+exp(-S3));
   
   S21=o1*W21(1)+o2*W21(2)+o3*W21(3)+W21(4);
   S22=o1*W22(1)+o2*W22(2)+o3*W22(3)+W22(4);
   S23=o1*W23(1)+o2*W23(2)+o3*W23(3)+W23(4);
   S24=o1*W24(1)+o2*W24(2)+o3*W24(3)+W24(4);
   
   o21=1.0/(1.0+exp(-S21));
   o22=1.0/(1.0+exp(-S22));
   o23=1.0/(1.0+exp(-S23));
   o24=1.0/(1.0+exp(-S24));
   
   error=error+sqrt((d(1)-o21)*(d(1)-o21))+sqrt((d(2)-o22)*(d(2)-o22))+sqrt((d(3)-o23)*(d(3)-o23))+sqrt((d(4)-o24)*(d(4)-o24));
   W212=W21;
   W222=W22;
   W232=W23;
   W242=W24;
   
   W21(1)=W21(1)+alpha*(d(1)-o21)*o21*(1-o21)*(o1);
   W21(2)=W21(2)+alpha*(d(1)-o21)*o21*(1-o21)*(o2);
   W21(3)=W21(3)+alpha*(d(1)-o21)*o21*(1-o21)*(o3);
   W21(4)=W21(4)+alpha*(d(1)-o21)*o21*(1-o21)*(1);
   
   W22(1)=W22(1)+alpha*(d(2)-o22)*o22*(1-o22)*(o1);
   W22(2)=W22(2)+alpha*(d(2)-o22)*o22*(1-o22)*(o2);
   W22(3)=W22(3)+alpha*(d(2)-o22)*o22*(1-o22)*(o3);
   W22(4)=W22(4)+alpha*(d(2)-o22)*o22*(1-o22)*(1);
   
   W23(1)=W23(1)+alpha*(d(3)-o23)*o23*(1-o23)*(o1);
   W23(2)=W23(2)+alpha*(d(3)-o23)*o23*(1-o23)*(o2);
   W23(3)=W23(3)+alpha*(d(3)-o23)*o23*(1-o23)*(o3);
   W23(4)=W23(4)+alpha*(d(3)-o23)*o23*(1-o23)*(1);
   
   W24(1)=W24(1)+alpha*(d(4)-o24)*o24*(1-o24)*(o1);
   W24(2)=W24(2)+alpha*(d(4)-o24)*o24*(1-o24)*(o2);
   W24(3)=W24(3)+alpha*(d(4)-o24)*o24*(1-o24)*(o3);
   W24(4)=W24(4)+alpha*(d(4)-o24)*o24*(1-o24)*(1);
   
   %W1---------------------------------------------
   a=(d(1)-o21)*o21*(1-o21)*W212(1);
   b=(d(2)-o22)*o22*(1-o22)*W222(1);
   c=(d(3)-o23)*o23*(1-o23)*W232(1);
   e=(d(4)-o24)*o24*(1-o24)*W242(1);
   
   W1(1)=W1(1)+alpha*(a+b+c+e)*(o1)*(1-o1)*(X(1));
   
   a=(d(1)-o21)*o21*(1-o21)*W212(1);
   b=(d(2)-o22)*o22*(1-o22)*W222(1);
   c=(d(3)-o23)*o23*(1-o23)*W232(1);
   e=(d(4)-o24)*o24*(1-o24)*W242(1);
   
   W1(2)=W1(2)+alpha*(a+b+c+e)*(o1)*(1-o1)*(X(2));
   
   a=(d(1)-o21)*o21*(1-o21)*W212(1);
   b=(d(2)-o22)*o22*(1-o22)*W222(1);
   c=(d(3)-o23)*o23*(1-o23)*W232(1);
   e=(d(4)-o24)*o24*(1-o24)*W242(1);
   
   W1(3)=W1(3)+alpha*(a+b+c+e)*(o1)*(1-o1)*(X(3));
   
   %W2--------------------------------------------   
   a=(d(1)-o21)*o21*(1-o21)*W212(2);
   b=(d(2)-o22)*o22*(1-o22)*W222(2);
   c=(d(3)-o23)*o23*(1-o23)*W232(2);
   e=(d(4)-o24)*o24*(1-o24)*W242(2);
   
   W2(1)=W2(1)+alpha*(a+b+c+e)*(o2)*(1-o2)*(X(1));
   
   a=(d(1)-o21)*o21*(1-o21)*W212(2);
   b=(d(2)-o22)*o22*(1-o22)*W222(2);
   c=(d(3)-o23)*o23*(1-o23)*W232(2);
   e=(d(4)-o24)*o24*(1-o24)*W242(2);
   
   W2(2)=W2(2)+alpha*(a+b+c+e)*(o2)*(1-o2)*(X(2));
   
   a=(d(1)-o21)*o21*(1-o21)*W212(2);
   b=(d(2)-o22)*o22*(1-o22)*W222(2);
   c=(d(3)-o23)*o23*(1-o23)*W232(2);
   e=(d(4)-o24)*o24*(1-o24)*W242(2);
   
   W2(3)=W2(3)+alpha*(a+b+c+e)*(o2)*(1-o2)*(X(3));
   
    %W3--------------------------------------------   
   a=(d(1)-o21)*o21*(1-o21)*W212(3);
   b=(d(2)-o22)*o22*(1-o22)*W222(3);
   c=(d(3)-o23)*o23*(1-o23)*W232(3);
   e=(d(4)-o24)*o24*(1-o24)*W242(3);
   
   W3(1)=W3(1)+alpha*(a+b+c+e)*(o3)*(1-o3)*(X(1));
   
   a=(d(1)-o21)*o21*(1-o21)*W212(3);
   b=(d(2)-o22)*o22*(1-o22)*W222(3);
   c=(d(3)-o23)*o23*(1-o23)*W232(3);
   e=(d(4)-o24)*o24*(1-o24)*W242(3);
   
   W3(2)=W3(2)+alpha*(a+b+c+e)*(o3)*(1-o3)*(X(2));
   
   a=(d(1)-o21)*o21*(1-o21)*W212(3);
   b=(d(2)-o22)*o22*(1-o22)*W222(3);
   c=(d(3)-o23)*o23*(1-o23)*W232(3);
   e=(d(4)-o24)*o24*(1-o24)*W242(3);
   
   W3(3)=W3(3)+alpha*(a+b+c+e)*(o3)*(1-o3)*(X(3));
   
   
end


error=error/400;
EIT(1,it)=it;
EIT(2,it)=error;
end

x=linspace(-5,20);
y=(-W1(1)*x-W1(3))/W1(2);
L=plot(x,y);
set(L,'Color','blue');

x=linspace(-5,20);
y=(-W2(1)*x-W2(3))/W2(2);
L=plot(x,y);
set(L,'Color','red');

x=linspace(-5,20);
y=(-W3(1)*x-W3(3))/W3(2);
L=plot(x,y);
set(L,'Color','green');

for i=1:50
    for j=1:50
        x=-5+i*0.5;
        y=-5+j*0.5;
        S1=x*W1(1)+y*W1(2)+W1(3);
        S2=x*W2(1)+y*W2(2)+W2(3);
        S3=x*W3(1)+y*W3(2)+W3(3);        
     
   o1=1.0/(1.0+exp(-S1));
   o2=1.0/(1.0+exp(-S2));
   o3=1.0/(1.0+exp(-S3));
   
   S21=o1*W21(1)+o2*W21(2)+o3*W21(3)+W21(4);
   S22=o1*W22(1)+o2*W22(2)+o3*W22(3)+W22(4);
   S23=o1*W23(1)+o2*W23(2)+o3*W23(3)+W23(4);
   S24=o1*W24(1)+o2*W24(2)+o3*W24(3)+W24(4);
   
   o21=1.0/(1.0+exp(-S21));
   o22=1.0/(1.0+exp(-S22));
   o23=1.0/(1.0+exp(-S23));
   o24=1.0/(1.0+exp(-S24));
        
    if o21>0.5
        plot(x,y,'r +');
    elseif o22>0.5
        plot(x,y,'g +');
    elseif o23>0.5
        plot(x,y,'b +');
    elseif o24>0.5
        plot(x,y,'k +');
    end
    
    end
end

hFig = figure(7);
set(hFig,'name','error','Position', [300 0 500 400]);
line(EIT(1,:),EIT(2,:));


axis([0 it 0 1]);
