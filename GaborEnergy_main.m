clc
clear all
close all
tic

addpath('Gabor_Image_Features_Support_Files');

height = 128;
width = 128;

videoNum = 42;%[23 39 42 43 56 64] %[16 17 19 21 23 25 26 28 30 34 37 39 41 42 43 45 46 48 56 58 62 64 65]

outputLoc = ['GaborEnergy_Features/P' num2str(videoNum)];
mkdir(outputLoc);

fid = fopen(strcat('List_',num2str(videoNum),'_Video.txt'));
tline = fgetl(fid);
while ischar(tline)
    C = strsplit(tline,' ');
    videoFrameLoc = strjoin(C(1));
    videoFrame = imread(videoFrameLoc); %Reads Grayscale Automatically
    [gaborSquareEnergy, gaborMeanAmplitude ]= phasesym(videoFrame);
    ge = gaborSquareEnergy;        

    C = strsplit(strjoin(C(1)),'/');
    C = strrep(strrep(strjoin(C(3)),'Frame',''),'.jpg','');
    featureFilename = [outputLoc '/gaborFeatureFrame' C '.mat'];
    save(featureFilename,'ge');
    tline = fgetl(fid);
end 
fclose(fid);
toc

rmpath('Gabor_Image_Features_Support_Files');