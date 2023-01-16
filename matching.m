function [Rho,X_Y_output] = matching(img_1,img_2,xl,yl,xc,yc,s,D)
    
for i=1:length(xc)
    searchWindow = img_2(xc(i)-round(s/2):xc(i)+round(s/2),yc(i)-D:yc(i)+D);
    template = img_1(round(xl(i))-D:round(xl(i))+D,round(yl(i))-D:round(yl(i))+D);
    template=double(template);
    [m,n]=size(template);      %length
    g_L = (sum(sum(template)))/(n*m);
    sigma_L = sqrt((sum(sum((template-g_L).^2)))/(n*m-1));
    for j=0:size(searchWindow,1)-1
       matchingWindow = img_2(xc(i)-round(s/2)+j-D:xc(i)-round(s/2)+j+D,yc(i)-D:yc(i)+D);
       matchingWindow = double(matchingWindow);
       g_R = sum(sum(matchingWindow))/(n*m);
       sigma_R = sqrt((sum(sum((matchingWindow-g_R).^2)))/(n*m-1));
       sigma_LR = (sum(sum((template-g_L).*(matchingWindow-g_R))))/(n*m-1);
       matchingWindow = [];
       initial_rho(i,j+1) = sigma_LR/(sigma_L*sigma_R);
    end
    Rho = initial_rho;
    maximum(i) = max(Rho(i,:));
    if maximum(i) ~= 0 && maximum(i)> 0.5
        [l,k] = find(Rho(i,:) == maximum(i));
        x_total = xc(i)-round(s/2)+k;
       else
           disp(['d=',num2str(2*D+1),'; maximum is 0 because of your threshold!'])
           x_total = xc(i);
    end
X_Y_output(i,1) = x_total;
X_Y_output(i,2) = yc(i);
end

end