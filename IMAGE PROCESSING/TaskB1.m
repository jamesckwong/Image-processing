fileName = uigetfile();
HandImage = imread(fileName);

r = HandImage(:, :, 1); 
g = HandImage(:, :, 2); 
b = HandImage(:, :, 3); 






greyScaleHand = rgb2gray(HandImage);
catGreyScale = cat(3, greyScaleHand , greyScaleHand, greyScaleHand );

orangeBinary = r > 142 & r < 208 & g > 68 & g < 109 & b < 54; 
orangeIsolated = HandImage;
orangeIsolated(repmat(~orangeBinary,[1 1 3])) = 0; 


yellowBinary = r > 174 & r < 235 & g > 142 & g < 206 & b > 33 & b < 108;
yellowIsolated = HandImage;
yellowIsolated(repmat(~yellowBinary,[1 1 3])) = 0;


blueBinary = r > 5 & r < 30 & g > 40 & g < 60 & b > 70 & b < 170;
blueIsolated = HandImage;
blueIsolated(repmat(~blueBinary,[1 1 3])) = 0;


greenBinary = r > 0 & r < 50 &  g > 70 & g < 100 & b > 70 & b < 105;
greenIsolated = HandImage;
greenIsolated(repmat(~greenBinary,[1 1 3])) = 0;

redBinary = r > 140 & r < 180 & g > 55 & g < 80 & b > 50 & b < 80;
redIsolated = HandImage;
redIsolated(repmat(~redBinary,[1 1 3])) = 0;


greyWithColour = imadd(catGreyScale, orangeIsolated); 
greyWithColour = imadd(greyWithColour, redIsolated); 
greyWithColour = imadd(greyWithColour, blueIsolated); 
greyWithColour = imadd(greyWithColour, greenIsolated); 
greyWithColour = imadd(greyWithColour, yellowIsolated); 
imshow(greyWithColour);

OrangeCardinality = sum(orangeBinary(:));
YellowCardinality = sum(yellowBinary(:));
BlueCardinality = sum(blueBinary(:));
RedCardinality = sum(redBinary(:));
GreenCardinality = sum(greenBinary(:));

[y,x] = find(orangeBinary);
Orangexmean = mean(x);
Orangeymean = mean(y);

hold on;
plot(Orangexmean, Orangeymean, 'ro', 'MarkerSize', 30);


[y,x] = find(greenBinary);
Greenxmean = mean(x);
Greenymean = mean(y);

hold on;
plot(Greenxmean, Greenymean, 'ro', 'MarkerSize', 30);

[y,x] = find(blueBinary);
Bluexmean = mean(x);
Blueymean = mean(y);

hold on;
plot(Bluexmean, Blueymean, 'ro', 'MarkerSize', 30);

[y,x] = find(redBinary);
Redxmean = mean(x);
Redymean = mean(y);

hold on;
plot(Redxmean, Redymean, 'ro', 'MarkerSize', 30);

[y,x] = find(yellowBinary);
Yellowxmean = mean(x);
Yellowymean = mean(y);

hold on;
plot(Yellowxmean, Yellowymean, 'ro', 'MarkerSize', 30);



plot([Orangexmean, Yellowxmean] ,[Orangeymean ,Yellowymean], 'g')
plot([Yellowxmean, Bluexmean], [Yellowymean, Blueymean], 'g')
plot([Bluexmean, Greenxmean], [Blueymean, Greenymean], 'g')
plot([Greenxmean, Redxmean], [Greenymean ,Redymean], 'g')


orange2Yellow = pdist([Orangexmean, Orangeymean; Yellowxmean,Yellowymean], 'euclidean');

orange2Blue = pdist([Orangexmean, Orangeymean ; Bluexmean,Blueymean], 'euclidean');

orange2Red = pdist([Orangexmean, Orangeymean ; Redxmean,Redymean], 'euclidean');

orange2Green = pdist([Orangexmean, Orangeymean ; Greenxmean,Greenymean], 'euclidean');

 distances =cat(1,orange2Yellow, orange2Blue, orange2Red, orange2Green);

%Displaying back to user output commands of each gesture. 
if orange2Yellow<orange2Blue && orange2Yellow<orange2Red && orange2Yellow<orange2Green 
    disp('This is thumb to Index Finger.')
end
if  orange2Blue<orange2Yellow && orange2Blue<orange2Red && orange2Blue<orange2Green
    disp('This is thumb to Middle Finger.')
end
if orange2Green<orange2Yellow && orange2Green<orange2Red && orange2Green<orange2Blue
    disp('This is thumb to Ring Finger.')
end
if orange2Red<orange2Yellow && orange2Red<orange2Blue && orange2Red<orange2Green
    disp('This is thumb to Pinky Finger.')
end 

    

