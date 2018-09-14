
%(1) Given 1-d Gaussian function, draw it.
hFig = figure(1);
set(hFig,'name','(1) Given 1-d Gaussian function, draw it.','Position', [0 0 500 400]);
Mean=3;
Variance=4;
MySigma=sqrt(Variance);
x=linspace(Mean-3*MySigma,Mean+3*MySigma);
y=normpdf(x,Mean,MySigma);
L=plot(x,y);
set(L,'Color','blue');

%(2) Given 2-d Gaussian function, draw it.
hFig = figure(2);
set(hFig,'name','(2) Given 2-d Gaussian function, draw it.','Position', [100 0 500 400]);
Mean = [1 2]; 
Covariance = [1 0;0 1]; 
[X,Y] = meshgrid(linspace(Mean(1)-3*Covariance(1,1),Mean(1)+3*Covariance(1,1)),linspace(Mean(2)-3*Covariance(2,2),Mean(2)+3*Covariance(2,2)));
Z = mvnpdf([X(:) Y(:)],Mean,Covariance); 
Z = reshape(Z,size(X)); 
mesh(X,Y,Z);

%(3) Call 1-d Gaussian random data and plot 1-d histogram.
hFig = figure(3);
set(hFig,'name','(3) Call 1-d Gaussian random data and plot 1-d histogram.','Position', [200 0 500 400]);
Mean = 0;
MySigma = 1;
NormalHist = randn(1 , 10000)*MySigma + Mean;
hist(NormalHist, 50);

%(4) Call 2-d Gaussian random data. 點在 2-d space 上
hFig = figure(4);
set(hFig,'name','(4) Call 2-d Gaussian random data. 點在 2-d space 上','Position', [300 0 500 400]);
Mean = [1;2]; 
MySigma = [3 0; 0 4];
NormalPoint = mvnrnd(Mean, MySigma, 10000);
L=plot(NormalPoint(:,1),NormalPoint(:,2),'.');
set(L,'Color','blue');

%(4) Call 2-d Gaussian random data. Plot 2-d histogram.
hFig = figure(5);
set(hFig,'name','(4) Call 2-d Gaussian random data. Plot 2-d histogram.','Position', [400 0 500 400]);
hist3(NormalPoint,[40 40]);
set(get(gca,'child'),'FaceColor','interp','CDataMode','auto');

%(5) 承(4)，在 2-d histogram 上畫等高線圖。
hFig = figure(6);
set(hFig,'name','(5) 承(4)，在 2-d histogram 上畫等高線圖。','Position', [500 0 500 400]);
[n,c]=hist3(NormalPoint,[40 40]);
[e,h] = contour(c{1}, c{2}, n);
clabel(e,h);

%(6) Plot line x-y=1.
hFig = figure(7);
set(hFig,'name','(6) Plot line x-y=1.','Position', [600 0 500 400]);
L=ezplot('x-y-1=0',[-6.2 6.2],[-6.2 6.2]);
set(L,'Color','blue');

%(7) Plot circle x^2+y^2=1.
hFig = figure(8);
set(hFig,'name','(7) Plot circle x^2+y^2=1.','Position', [700 0 500 400]);
L=ezplot('x.^2+y.^2-1=0',[-1.9 1.9],[-1.4 1.7]);
set(L,'Color','blue');

%(8) Plot ellipse x^2+y^2/4 =1.
hFig = figure(9);
set(hFig,'name','(8) Plot ellipse x^2+y^2/4 =1.','Position', [800 0 500 400]);
L=ezplot('x.^2+y.^2./4=1',[-3.9 3.9],[-3.4 2.9]);
set(L,'Color','blue');

%(9) Plot hyperbola x^2-y^2/4 =1.

hFig = figure(10);
set(hFig,'name','(8) Plot ellipse x^2-y^2/4 =1.','Position', [900 0 500 400]);
L=ezplot('x.^2-y.^2./4=1',[-6.2 6.2],[-6.2 6.2]);
set(L,'Color','blue');

%(10) Generate data of line 2x-y=0 and plot.
hFig = figure(11);
set(hFig,'name','(10) Generate data of line 2x-y=0 and plot.','Position', [1000 0 500 400]);
x = linspace(0,100,100);
y = 2*x;
L=plot(x,y,'*','MarkerSize',2);
set(L,'Color','blue');

%(11) Generate data of circle x^2+y^2=4 and plot. 
hFig = figure(12);
set(hFig,'name','(11) Generate data of circle x^2+y^2=4 and plot.','Position', [1100 0 500 400]);
x = linspace(-2,2,50);
y1 = sqrt(4-x.^2);
y2 = -sqrt(4-x.^2);

L=plot(x,y1,'*','MarkerSize',2);
set(L,'Color','blue');
hold on;
L=plot(x,y2,'*','MarkerSize',2);
set(L,'Color','blue');
hold off;
axis([-2.5 2.5 -2 2]);

%(12) Generate data of ellipse x^2/4+y^2=1 and plot. 
hFig = figure(13);
set(hFig,'name','(12) Generate data of ellipse x^2/4+y^2=1 and plot. ','Position', [0 500 500 400]);

x = linspace(-2,2,50);
y1 = sqrt(1-x.^2/4);
y2 = -sqrt(1-x.^2/4);

L=plot(x,y1,'*','MarkerSize',2);
set(L,'Color','blue');
hold on;
L=plot(x,y2,'*','MarkerSize',2);
set(L,'Color','blue');
hold off;
axis([-2 2 -1.6 1.6])


%(13) Generate data of hyperbola xy=1 and plot.
hFig = figure(14);
set(hFig,'name','(13) Generate data of hyperbola xy=1 and plot.','Position', [100 500 500 400]);

x = linspace(-1,1,100);
y = 1./x;
L=plot(x,y,'*','MarkerSize',2);
set(L,'Color','blue');
axis([-1 1 -10 10]);

%(14) Plot two spirals.
hFig = figure(15);
set(hFig,'name','(14) Plot two spirals.','Position', [200 500 500 400]);

for i = 0:96
    thetai = pi.*i/16;
    ri = 6.5.*(104-i)./104;
    xi = ri.*sin(thetai);
    yi = ri.*cos(thetai);
    plot(xi,yi,'o','MarkerSize',2,'MarkerEdgeColor','r');
    axis([-8 8 -8 8]);
    hold on;
end

for j = 0:96
    thetaj = pi.*j/16;
    rj = 6.5.*(104-j)./104;
    xj = -rj.*sin(thetaj);
    yj = -rj.*cos(thetaj);
    plot(xj,yj,'*','MarkerSize',2,'MarkerEdgeColor','b');
    axis([-8 8 -8 8]);
    hold on;
end

%(15) Plot 8 points in the three dimensional space, and the plane z = x – y + 0.5 that can separate these two classes.
hFig = figure(16);
set(hFig,'name','(15) Plot 8 points in the three dimensional space, and the plane z = x – y + 0.5 that can separate these two classes.','Position', [300 500 500 400]);

point=[0 1 1;0 0 0;1 0 0; 1 0 1;0 0 1;1 1 0;1 1 1;0 1 0]
for i=1:8
    x = point(i,1);
    y = point(i,2);
    z = point(i,3);
        if x - y + 0.5 < z
            scatter3(x,y,z,'b','o');
        else
            scatter3(x,y,z,'r','x');
        end
        hold on;
    
end
set(gca,'xtick',0:0.2:1);
set(gca,'ytick',0:0.2:1);
set(gca,'ztick',-0.5:0.5:1.5);
axis([0 1 0 1 -0.5 1.5])

x = 0:1; 
y = 0:1; 
[X,Y] = meshgrid(x,y); 
Z = X-Y+0.5; 
mesh(X,Y,Z);

box on;
ax = gca;
ax.BoxStyle = 'full';

%(16) Plot double moon problem:
hFig = figure(17);
set(hFig,'name','(16) Plot double moon problem:','Position', [400 500 500 400]);

i=1
while i<501
    x = -15+20*rand;
    y = -2+14*rand;
    
    d = ((x+5)^2)+(y^2);
    if d>36 && d<100 
        bx(i)=x;
        by(i)=y;
        i=i+1;
    end  
    hold on;
end
i=1;
while i <501;
    x =-5+20*rand;
    y =-12+14*rand;
    
    d = ((x-5)^2)+(y^2);
    if d>36&& d<100
        rx(i)=x;
        ry(i)=y;
        i=i+1;
    end    
    hold on;
end

b = plot(bx,by,'o','MarkerEdgeColor','b','MarkerSize',2);
r = plot(rx,ry,'o','MarkerEdgeColor','r','MarkerSize',2);

axis([-15 15 -15 15]);

for count=1:3
for i = 1:50
        tempy = by+i/10;
        set(b, 'ydata', tempy);
        tempy = ry-i/10;
        set(r, 'ydata', tempy);
        drawnow;
end

for i = 1:60
        tempy = by-i/10+5;
        set(b, 'ydata', tempy);
        tempy = ry+i/10-5;
        set(r, 'ydata', tempy);
        drawnow;
end
end

%17. Given 5 sine function with different periods (different frequencies)
hFig = figure(18);
set(hFig,'name','17. Given 5 sine function with different periods (different frequencies)','Position', [500 500 500 400]);
for j=1:5
for i=1:90
   plot(i/5,sin(i/(5*j)),'o','MarkerSize',5);
   hold on;
   axis([0 18 -1 1]);
    M(i) = getframe;
end
end

%18.Design a uniform random number generator
hFig = figure(19);
set(hFig,'name','18.Design a uniform random number generator','Position', [600 500 500 400]);
low  = 0;
high = 500;
Ia = 106;
Ic = 1283;
Im = 6075;
fran = 250;
count(1:501) = 0;
%
count(fran+1) = count(fran+1) +1;
%
for i = 1:10000
    fran = mod((fran*Ia+Ic),Im);
    fsw = low + floor(((high-low+1)*fran)/Im);
    count(fsw+1) = count(fsw+1)+1;
end;

plot(0:0.002:1, count);
axis([0 1 0 30]);
xlabel('Hz');
ylabel('number of times');
