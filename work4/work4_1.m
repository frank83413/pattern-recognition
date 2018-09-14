%-----------------1---------------------
hFig = figure(1);
set(hFig,'name','1 hidden layers , 3 hidden nodes,learning rate=0.1, error>0.03 && iteration<8000','Position', [200 500 500 400]);

alpha=0.1;
for i = 0:96
    thetai = pi.*i/16;
    ri = 6.5.*(104-i)./104;
    xi = ri.*sin(thetai);
    yi = ri.*cos(thetai);
    X(i+1)=xi;
    Y(i+1)=yi;
    plot(xi,yi,'o','MarkerSize',2,'MarkerEdgeColor','r');
    axis([-8 8 -8 8]);
    hold on;
end

for j = 0:96
    thetaj = pi.*j/16;
    rj = 6.5.*(104-j)./104;
    xj = -rj.*sin(thetaj);
    yj = -rj.*cos(thetaj);    
    X(j+98)=xj;
    Y(j+98)=yj;
    plot(xj,yj,'*','MarkerSize',2,'MarkerEdgeColor','b');
    axis([-8 8 -8 8]);
    hold on;
end


WL1=0.1*rand(40,3);
WL2=0.1*rand(20,41);
WL3=0.1*rand(2,21);
error=1;
it=0;
while(error>0.03 && it<8000)
    it=it+1;
for i=1:194
    error=0;
    
    if i<98
        d=[1 0];
    else
        d=[0 1];
    end
    for j=1:40
        SL1(j)=WL1(j,1)*X(i)+WL1(j,2)*Y(i)+WL1(j,3);
        OL1(j)=1.0/(1.0+exp(-SL1(j)));
    end
    
    for j=1:20   
        SL2(j)=0;
        for k=1:40
            SL2(j)=SL2(j)+WL2(j,k)*OL1(k);
        end
        SL2(j)=SL2(j)+WL2(j,41);
        OL2(j)=1.0/(1.0+exp(-SL2(j)));
    end
    
    for j=1:2   
        SL3(j)=0;
        for k=1:20
            SL3(j)=SL3(j)+WL3(j,k)*OL2(k);
        end
        SL3(j)=SL3(j)+WL3(j,21);
        OL3(j)=1.0/(1.0+exp(-SL3(j)));
    end
    error=error+sqrt((d(1)-OL3(1))*(d(1)-OL3(1)))+sqrt((d(2)-OL3(2))*(d(2)-OL3(2)));
    %WL1
    
    for j=1:40
        temp2=0;     
         for k=1:20
             temp=0; 
            for l=1:2
                temp=temp+(d(l)-OL3(l))*OL3(l)*(1-OL3(l))*WL3(l,k);       
            end
            temp2=temp2+temp*OL2(k)*(1-OL2(k))*WL2(k,j);
         end
         
        WL1(j,1)= WL1(j,1)+alpha*temp2*OL1(j)*(1-OL1(j))*X(i);
        WL1(j,2)= WL1(j,2)+alpha*temp2*OL1(j)*(1-OL1(j))*Y(i);
        WL1(j,3)= WL1(j,3)+alpha*temp2*OL1(j)*(1-OL1(j))*1;
    end
    %WL2
      
    for j=1:20
         temp=0;
         for l=1:2
            temp=temp+(d(l)-OL3(l))*OL3(l)*(1-OL3(l))*WL3(l,j);       
        end
        for k=1:40
            WL2(j,k)= WL2(j,k)+alpha*temp*OL2(j)*(1-OL2(j))*OL1(k);  
        end
        WL2(j,41)= WL2(j,41)+alpha*temp*OL2(j)*(1-OL2(j))*1;  
    end
    %WL3
    for j=1:20
       WL3(1,j)= WL3(1,j)+alpha*(d(1)-OL3(1))*OL3(1)*(1-OL3(1))*OL2(j);
       WL3(2,j)= WL3(2,j)+alpha*(d(2)-OL3(2))*OL3(2)*(1-OL3(2))*OL2(j);
    end
    WL3(1,21)= WL3(1,21)+alpha*(d(1)-OL3(1))*OL3(1)*(1-OL3(1))*1;
    WL3(2,21)= WL3(2,21)+alpha*(d(2)-OL3(2))*OL3(2)*(1-OL3(2))*1;
    error=error/2;
    EIT(1,it)=it;
    EIT(2,it)=error;
end
end
for i=1:50
    for l=1:50
        x=-8+i*0.32;
        y=-8+l*0.32;
        
        for j=1:40
            SL1(j)=WL1(j,1)*x+WL1(j,2)*y+WL1(j,3);
            OL1(j)=1.0/(1.0+exp(-SL1(j)));
        end
    
        for j=1:20   
            SL2(j)=0;
            for k=1:40
                SL2(j)=SL2(j)+WL2(j,k)*OL1(k);
            end
            SL2(j)=SL2(j)+WL2(j,41);
            OL2(j)=1.0/(1.0+exp(-SL2(j)));
        end
    
        for j=1:2   
            SL3(j)=0;
            for k=1:20
                SL3(j)=SL3(j)+WL3(j,k)*OL2(k);
            end
            SL3(j)=SL3(j)+WL3(j,21);
            OL3(j)=1.0/(1.0+exp(-SL3(j)));
        end              
        if OL3(1)>0.5
            plot(x,y,'r +');
        else
            plot(x,y,'b +');
        end
    end
end
for i=1:40
x=linspace(-8,8);
y=(-WL1(i,1)*x-WL1(i,3))/WL1(i,2);
L=plot(x,y);
set(L,'Color','green');
end

hFig = figure(2);
set(hFig,'name','error','Position', [300 0 500 400]);
line(EIT(1,:),EIT(2,:));


axis([0 it 0 0.8]);

hFig = figure(3);
set(hFig,'name','1','Position', [300 0 500 400]);
for i = 0:96
    thetai = pi.*i/16;
    ri = 6.5.*(104-i)./104;
    xi = ri.*sin(thetai);
    yi = ri.*cos(thetai);
    X(i+1)=xi;
    Y(i+1)=yi;
    plot(xi,yi,'o','MarkerSize',2,'MarkerEdgeColor','r');
    axis([-8 8 -8 8]);
    hold on;
end

for j = 0:96
    thetaj = pi.*j/16;
    rj = 6.5.*(104-j)./104;
    xj = -rj.*sin(thetaj);
    yj = -rj.*cos(thetaj);    
    X(j+98)=xj;
    Y(j+98)=yj;
    plot(xj,yj,'*','MarkerSize',2,'MarkerEdgeColor','b');
    axis([-8 8 -8 8]);
    hold on;
end

for i=1:50
    for l=1:50
        x=-8+i*0.32;
        y=-8+l*0.32;
        
        for j=1:40
            SL1(j)=WL1(j,1)*x+WL1(j,2)*y+WL1(j,3);
            OL1(j)=1.0/(1.0+exp(-SL1(j)));
        end
    
        for j=1:20   
            SL2(j)=0;
            for k=1:40
                SL2(j)=SL2(j)+WL2(j,k)*OL1(k);
            end
            SL2(j)=SL2(j)+WL2(j,41);
            OL2(j)=1.0/(1.0+exp(-SL2(j)));
        end
    
        for j=1:2   
            SL3(j)=0;
            for k=1:20
                SL3(j)=SL3(j)+WL3(j,k)*OL2(k);
            end
            SL3(j)=SL3(j)+WL3(j,21);
            OL3(j)=1.0/(1.0+exp(-SL3(j)));
        end              
        if OL3(1)>0.5
            plot(x,y,'r +');
        else
            plot(x,y,'b +');
        end
    end
end