%-----------------1---------------------
hFig = figure(1);
set(hFig,'name','100張圖','Position', [200 500 500 400]);

alpha=0.1;
%read
 fp = fopen('train-images.idx3-ubyte', 'rb');
magic = fread(fp, 1, 'int32', 0, 'ieee-be');

numImages = fread(fp, 1, 'int32', 0, 'ieee-be');
numRows = fread(fp, 1, 'int32', 0, 'ieee-be');
numCols = fread(fp, 1, 'int32', 0, 'ieee-be');

images = fread(fp, inf, 'unsigned char');
images = reshape(images, numCols, numRows, numImages);
images = permute(images,[2 1 3]);
fclose(fp);

images = reshape(images, size(images, 1) * size(images, 2), size(images, 3));
images = double(images) / 255;

%
fp = fopen('train-labels.idx1-ubyte', 'rb');
magic = fread(fp, 1, 'int32', 0, 'ieee-be');
numLabels = fread(fp, 1, 'int32', 0, 'ieee-be');
labels = fread(fp, inf, 'unsigned char');
fclose(fp);
%read

%output 100張圖
outpic=zeros(280,280);
for i=1:10
    for j=1:10
        for k=1:28
            for l=1:28
                outpic(l+28*(i-1),k+28*(j-1))=images((k-1)*28+l,(i-1)*10+j);
            end
        end
    end
end
imshow(outpic);



WL1=0.1*rand(50,785);
WL2=0.1*rand(10,51);
error=1;
it=0;
d=[0 0 0 0 0 0 0 0 0 0];
errorstop=0.03;
time=tic;
while(error>errorstop && it<100)
    it=it+1;
    error=0;
for i=1:5000    
    for j=1:10
       d(j)=0; 
    end
    d(labels(i)+1)=1;
    
    for j=1:50   
        SL1(j)=0;
        for k=1:784            
                SL1(j)=SL1(j)+WL1(j,k)*images(k,i);            
        end
        SL1(j)=SL1(j)+WL1(j,785);
        OL1(j)=1.0/(1.0+exp(-SL1(j)));
    end
    
    for j=1:10   
        SL2(j)=0;
        for k=1:50
            SL2(j)=SL2(j)+WL2(j,k)*OL1(k);
        end
        SL2(j)=SL2(j)+WL2(j,51);
        OL2(j)=1.0/(1.0+exp(-SL2(j)));
    end
    temperror=0;
    for j=1:10
       temperror=temperror+sqrt((d(j)-OL2(j))*(d(j)-OL2(j)));
    end
    error=error+temperror/10;
    
    %WL1      
    for j=1:50
         temp=0;
         for l=1:10
            temp=temp+(d(l)-OL2(l))*OL2(l)*(1-OL2(l))*WL2(l,j);       
        end
        for k=1:784
            WL1(j,k)= WL1(j,k)+alpha*temp*OL1(j)*(1-OL1(j))*images(k,i);  
        end
        WL1(j,785)= WL1(j,41)+alpha*temp*OL1(j)*(1-OL1(j))*1;  
    end
    %WL2
    for j=1:50
        for k=1:10
            WL2(k,j)= WL2(k,j)+alpha*(d(k)-OL2(k))*OL2(k)*(1-OL2(k))*OL1(j);       
        end
    end
    for k=1:10
        WL2(k,51)= WL2(k,51)+alpha*(d(k)-OL2(k))*OL2(k)*(1-OL2(k))*1;
    end   
end
    error=error/5000;
    EIT(1,it)=it;
    EIT(2,it)=error;
end

timetoc=toc(time);

%read
 fp = fopen('t10k-images.idx3-ubyte', 'rb');
magic = fread(fp, 1, 'int32', 0, 'ieee-be');

numImages = fread(fp, 1, 'int32', 0, 'ieee-be');
numRows = fread(fp, 1, 'int32', 0, 'ieee-be');
numCols = fread(fp, 1, 'int32', 0, 'ieee-be');

images = fread(fp, inf, 'unsigned char');
images = reshape(images, numCols, numRows, numImages);
images = permute(images,[2 1 3]);
fclose(fp);

images = reshape(images, size(images, 1) * size(images, 2), size(images, 3));
images = double(images) / 255;

%
fp = fopen('t10k-labels.idx1-ubyte', 'rb');
magic = fread(fp, 1, 'int32', 0, 'ieee-be');
numLabels = fread(fp, 1, 'int32', 0, 'ieee-be');
labels = fread(fp, inf, 'unsigned char');
fclose(fp);
%read

finalmatch=zeros(10,10);
error=0;
for i=1:2000

    for j=1:10
       d(j)=0; 
    end
    d(labels(i)+1)=1;
    
    for j=1:50   
        SL1(j)=0;
        for k=1:784            
                SL1(j)=SL1(j)+WL1(j,k)*images(k,i);            
        end
        SL1(j)=SL1(j)+WL1(j,785);
        OL1(j)=1.0/(1.0+exp(-SL1(j)));
    end
    
    for j=1:10   
        SL2(j)=0;
        for k=1:50
            SL2(j)=SL2(j)+WL2(j,k)*OL1(k);
        end
        SL2(j)=SL2(j)+WL2(j,51);
        OL2(j)=1.0/(1.0+exp(-SL2(j)));
    end
    tempol=OL2(1);
    tempj=1;
    for j=1:10        
        if tempol<OL2(j)
            tempol=OL2(j);
            tempj=j;
        end
    end
    if tempj~=labels(i)+1
        error=error+1;
    end
    finalmatch(labels(i)+1,tempj)= finalmatch(labels(i)+1,tempj)+1;
end
error=error/2000

hFig = figure(2);
set(hFig,'name','1 hidden layers , 50 hidden nodes,learning rate=0.1, error>0.03 && iteration<100','Position', [200 500 500 400]);
line(EIT(1,:),EIT(2,:));
axis([0 it 0 0.2]);
str = ['error=', num2str(error), ', time=', num2str(timetoc)];
title(str);
