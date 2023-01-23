## Area-Based-Matching
In this project I've managed to code area-based matching using cross correlation method in matlab.
__________________________________________________
We have two images. User chooses one point on the left image and the matching function calculates the matching point of the selected one. <br />
![1](https://user-images.githubusercontent.com/60284829/214118128-e94b08a5-7354-448b-890c-bb30375ede39.PNG)
![2](https://user-images.githubusercontent.com/60284829/214118228-998a54e8-fb69-4709-ab96-b8a23d4107b9.PNG)


To have a good matching we need to limit our space search. to do so, we use some geometrical constraints or assumptions. One of these constraints is Epipolar plane. by using this method, we can change the dimension of our search space from 2 to 1 which is in direction to the x-axis.<br />
![9](https://user-images.githubusercontent.com/60284829/214118347-36fe4beb-0796-4823-8b36-cedcc3e50fb3.PNG)

Then the selected method for matching is Cross correlation. on the left image we have a template which contains the matching entity. on the right image, also we have another template called matching window, the same dimension as templateon the left image. The matching window moves into the search space with two for-loops(i,j) and for each i and j we calculate a correlation coefficient using the below equations:<br />
![22](https://user-images.githubusercontent.com/60284829/214118483-a6861a27-6d02-49d9-87f9-032bd7b21316.PNG)
![Capture](https://user-images.githubusercontent.com/60284829/214118866-a364b3c9-8ccf-4079-9836-4246cdeef526.PNG)

then that pixel that represents the highest correlation coefficient(Rho) is the matching for selected point.<br />
![Capture2](https://user-images.githubusercontent.com/60284829/214118994-7bcd8a8f-a598-409f-9da8-3db9d9ee8709.PNG)

the matching function(matching.m) contains above calculations.<br />
This implementation has been done through different values as width of the search space. By evaluating results we can say that as width increases, the number of possible candidates increases as well and the quality of results would decrease. also the have a good matching in crowded areas rather than homogeneous areas.<br />
Crowded areas:<br />
![left_1](https://user-images.githubusercontent.com/60284829/214119363-a8807092-1058-457a-9b69-abb95a5bbd8a.PNG)
![43](https://user-images.githubusercontent.com/60284829/214119460-b3b98adf-966b-4f02-b86c-1944ba169b23.PNG)

homogeneous areas:<br />
![left_5](https://user-images.githubusercontent.com/60284829/214119728-caeb33fc-8ae3-40d8-930a-fbd75f70ece0.PNG)
![47](https://user-images.githubusercontent.com/60284829/214119774-5c77fd1d-867f-4ac6-80d4-16c5a414dfac.PNG)

_____________________________________________
In the third file which is smooth matching, I've tried to implement Gaussian filter to matching process and evaluate the results. this filter has been convoluted in the search space to smooth the image; but according to the results, it has been concluded that implementing Gaussian doesn't necessarily help to improve the matching.<br />
![Capture3](https://user-images.githubusercontent.com/60284829/214120058-9fe18290-1121-47f2-93f5-8b6b2f9c0809.PNG)
