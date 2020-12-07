format compact

%From walk data set
dirstring = 'X:\7th Semester\CMPEN 454\Project 3\Data Sets\walk';

%Gather the image files
filePattern = fullfile(dirstring, '*.jpg');
files = dir(filePattern);

%Lambda Values
SBS_Lambda = 10; 
SFD_Lambda = 10;
ABS_lambda = 10;


%Simple Background Substraction Example
for i = 1:length(files)
    %Gets File Name
    fileName = files(i).name;
    
    %To Red,Green,Blue image
    rgbImage = imread(fullfile(dirstring, fileName));
    
    %To grey scale
    next_frame = rgb2gray(rgbImage);    
    
    %Background Image
    SBS_Background = rgb2gray(imread(fullfile(dirstring, files(1).name)));
    
    %Calculation
    SBS_Result = SimpleBackgroundSubstraction(SBS_Background, next_frame, SBS_Lambda);
    
    %Display
    imshow(SBS_Result)
    
end

%Simple Frame Differencing Example
SFD_Background = rgb2gray(imread(fullfile(dirstring, files(1).name)));
for i = 1:length(files)
    
    fileName = files(i).name;
    rgbImage = imread(fullfile(dirstring, fileName));
    next_frame = rgb2gray(rgbImage);
    SFD_Result = SimpleFrameDifferencing(SFD_Background, next_frame, SFD_Lambda);
    imshow(SFD_Result)
    SFD_Background = next_frame;

end

%Both Combined
SFD_Background = rgb2gray(imread(fullfile(dirstring, files(1).name)));
for i = 1:length(files)
    
    fileName = files(i).name;
    rgbImage = imread(fullfile(dirstring, fileName));
    next_frame = rgb2gray(rgbImage);
    
    %SBS
    SBS_Background = rgb2gray(imread(fullfile(dirstring, files(1).name)));
    SBS_Result = SimpleBackgroundSubstraction(SBS_Background, next_frame, SBS_Lambda);
    
    %SFD
    SFD_Result = SimpleFrameDifferencing(SFD_Background, next_frame, SFD_Lambda);
    SFD_Background = next_frame;
    
    %Show side by side
    imshowpair(SBS_Result,SFD_Result, 'montage');
    
end
 

%Video Detection Functions

function solution = SimpleFrameDifferencing(Background, next_frame, SFD_Lambda)

diff = abs(Background - next_frame);
disp(sum(sum(diff)));
solution = diff > SFD_Lambda;


end

function solution = SimpleBackgroundSubstraction(Background, next_frame, SBS_Lambda)

diff = abs(Background - next_frame);
disp(sum(sum(diff)));
solution = diff > SBS_Lambda;

end

function solution = AdaptiveBackgroundSubstraction(Background, next_frame, ABS_Lambda)
solution = 1;
end

function solution = PersistentFrameDifferencing(Background, next_frame, PFD_Lambda)
solution = 1;
end


%%Ignore for now
function solution = Proj3Main(dirstring, maxframenum, abs_diff_threshold, alpha_parameter, gamma_parameter)
solution = 1;
disp("lol")
end
