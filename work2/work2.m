
%0556638張為誠
hFig = figure(1);
set(hFig,'name','data','Position', [0 0 500 400]);

Mean = [2 2]; 
MySigma=3;
Covariance = [2.5 1.5;1.5 2.5];
K=[1 0;0 2];
[V,D]=eig(Covariance);
X = randn(1000,1);  %產生x方向data
Y = randn(1000,1);  %產生y方向data

Point=[X Y];        %建成poiny產生2高斯data N(0,1)
TPoint=transpose(Point);
B=ones(1000,1)*Mean;
Plotp=V*sqrt(D)*TPoint+transpose(B);%計算新的2d高斯
B=ones(1000,1)*Mean;
TPlotp=transpose(Plotp);
L=plot(TPlotp(:,1),TPlotp(:,2),'.');
axis([-4 10 -4 10])

hFig = figure(2);
set(hFig,'name','histogram','Position', [100 0 500 400]);

hist3(TPlotp,[30 30]);
set(get(gca,'child'),'FaceColor','interp','CDataMode','auto');


hFig = figure(3);
set(hFig,'name','等高線圖。','Position', [200 0 500 400]);
[n,c]=hist3(TPlotp,[30 30]);
[e,h] = contour(c{1}, c{2}, n);
clabel(e,h);

%計算ExpectedVector
sumx=0;
for i=1:1000
   sumx=sumx+ Plotp(1,i);    
end
sumx=sumx/1000;

sumy=0;
for i=1:1000
   sumy=sumy+ Plotp(2,i);    
end
sumy=sumy/1000;

%計算Covariance
a11=0;
for i=1:1000
    a11=a11+(Plotp(1,i)-sumx)^2;
end
a11=a11/1000;

a22=0;
for i=1:1000
    a22=a22+(Plotp(2,i)-sumx)^2;    
end
a22=a22/1000;

a12=0;
for i=1:1000
    tempx=Plotp(1,i)-sumx;
    tempy=Plotp(2,i)-sumx;
    a12=a12+tempx*tempy;
end
a12=a12/1000;

NewExpectedVector=[sumx;sumy];
NewCovariance=[a11 a12;a12 a22];

[NV,ND,IINV]=eig(NewCovariance);

hFig = figure(4);
set(hFig,'name','ExpectedVector,Covarianc','Position', [300 0 500 400]);
text(0.1,0.6,'Expected Vector matrix is','HorizontalAlignment','left');
text(0.1,0.5,num2str(NewExpectedVector),'HorizontalAlignment','left');
text(0.5,0.6,'Covariance matrix is','HorizontalAlignment','left');
text(0.5,0.5,num2str(NewCovariance),'HorizontalAlignment','left');
hFig = figure(5);
set(hFig,'name','Eigenvectors,Eigenvalues','Position', [400 0 500 400]);
text(0.1,0.6,'Eigenvectors matrix is','HorizontalAlignment','left');
text(0.1,0.5,num2str(NV),'HorizontalAlignment','left');
text(0.5,0.6,'Eigenvalues matrix is','HorizontalAlignment','left');
text(0.5,0.5,num2str(ND),'HorizontalAlignment','left');

%Diagonalization

hFig = figure(6);
set(hFig,'name','Diagonalization','Position', [500 0 500 400]);

NDD=[1/sqrt(ND(1,1)) 0;0 1/sqrt(ND(2,2))];
Plotp=IINV*(Plotp-transpose(B))+transpose(B);%減去原本MEAN值計算新的2d高斯
TPlotp=transpose(Plotp);

%計算ExpectedVector
sumx=0;
for i=1:1000
   sumx=sumx+ Plotp(1,i);
end
sumx=sumx/1000;

sumy=0;
for i=1:1000
   sumy=sumy+ Plotp(2,i);    
end
sumy=sumy/1000;

%計算Covariance
a11=0;
for i=1:1000
    a11=a11+(Plotp(1,i)-sumx)^2;
end
a11=a11/1000;

a22=0;
for i=1:1000
    a22=a22+(Plotp(2,i)-sumx)^2;    
end
a22=a22/1000;

a12=0;
for i=1:1000
    tempx=Plotp(1,i)-sumx;
    tempy=Plotp(2,i)-sumx;
    a12=a12+tempx*tempy;
end
a12=a12/1000;
L=plot(TPlotp(:,1),TPlotp(:,2),'.');

NewExpectedVector=[sumx;sumy];
NewCovariance=[a11 a12;a12 a22];
text(sumx,sumy+1,'Covariance','color','r','HorizontalAlignment','left');
text(sumx,sumy,num2str(NewCovariance),'color','r','HorizontalAlignment','left');
axis([-4 10 -4 10])


%Whitening

hFig = figure(7);
set(hFig,'name','Whitening','Position', [600 0 500 400]);


Plotp=NDD*(Plotp-transpose(B))+transpose(B);%減去原本MEAN值計算新的2d高斯
TPlotp=transpose(Plotp);

%計算ExpectedVector
sumx=0;
for i=1:1000
   sumx=sumx+ Plotp(1,i);
end
sumx=sumx/1000;

sumy=0;
for i=1:1000
   sumy=sumy+ Plotp(2,i);    
end
sumy=sumy/1000;

%計算Covariance
a11=0;
for i=1:1000
    a11=a11+(Plotp(1,i)-sumx)^2;
end
a11=a11/1000;

a22=0;
for i=1:1000
    a22=a22+(Plotp(2,i)-sumx)^2;    
end
a22=a22/1000;

a12=0;
for i=1:1000
    tempx=Plotp(1,i)-sumx;
    tempy=Plotp(2,i)-sumx;
    a12=a12+tempx*tempy;
end
a12=a12/1000;
NewExpectedVector=[sumx;sumy];
NewCovariance=[a11 a12;a12 a22];


L=plot(TPlotp(:,1),TPlotp(:,2),'.');
text(sumx,sumy+1,'Covariance','color','r','HorizontalAlignment','left');
text(sumx,sumy,num2str(NewCovariance),'color','r','HorizontalAlignment','left');
axis([-4 10 -4 10])






