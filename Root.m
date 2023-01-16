clc;
clear;
close all;

img_1 = imread('1614.tif');
imshow(img_1);
img_2 = imread('1615.tif');

img_1 = im2double(img_1);
img_2 = im2double(img_2);

H = 2650; hm = 1883.73; f = 0.15324; scale = 1/5000;
delta_Z = 15; PS = 18*10^-6; b = 0.0775; B = b/scale;

[xl,yl] = ginput;

imshow(img_1);
hold on
plot(xl,yl,'*r')

%% Search space
s=((b*H*2*delta_Z)/(H-hm)^2)/PS;
px = ((B*f)/(H-hm))/PS;            %% Parallax

xc = round(xl-px); yc = round(yl);

d = 5;    % template dimension
D = (d-1)/2;

%% Cross Correlation
d = [5 11 23 33];
D = (d-1)/2;
All_Rho = {};
for j=1:length(D)
[Rho,X_Y_output] = matching(img_1,img_2,xl,yl,xc,yc,s,D(j));
All_Rho{j,1} = Rho;
figure
imshow(img_2)
hold on
for i=1:length(xc)
    plot(xc(i),yc(i),'ow')
    hold on
    plot(X_Y_output(i,1),X_Y_output(i,2),'*b')
    rectangle('Position',[xc(i)-round(s/2) yc(i)-D(j) s 2*D(j)],'EdgeColor','w')
end
title(['d= ',num2str(d(j))])
end

% figure
for j=1:length(D)
    Rho = All_Rho{j};
    2*D(j)+1
    figure
for i=1:length(xc)
   subplot(3,3,i)
   scatter(1:round(s),Rho(i,:),'.')
   title(['#',num2str(i)])
end
end

%% Gaussian
sigma = 1.5;    % 11*11
for i=1:11
    for j=1:11
        filter(i,j) = exp((-((i-6)^2+(j-6)^2))/(-2*sigma^2))/(2*pi*sigma^2);
    end
end
filter = filter/sum(sum(filter));
D = 5;

[Rho,X_Y_output] = smooth_matching(img_1,img_2,xl,yl,xc,yc,s,D,filter);
figure
title(['d= ',num2str(d)])
imshow(img_2)
hold on
for i=1:length(xc)
    plot(xc(i),yc(i),'ow')
    hold on
    plot(X_Y_output(i,1),X_Y_output(i,2),'*b')
    rectangle('Position',[xc(i)-round(s/2) yc(i)-D s 2*D],'EdgeColor','w')
end

figure
for i=1:length(xc)
   subplot(3,3,i)
   scatter(1:round(s),Rho(i,:),'.')
   title(['#',num2str(i)])
end
